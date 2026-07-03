import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/logging/logger.dart';
import '../app_providers.dart';
import '../local/database.dart';
import '../remote/supabase_service.dart';

/// Synchronisation hors-ligne d'abord (architecture § 4) :
/// - POUSSÉE : la file outbox est rejouée dans l'ordre vers Supabase
///   (état courant de la ligne locale, pas de charge utile figée) ;
/// - TIRAGE : delta serveur depuis `last_pulled_at`, appliqué en
///   last-write-wins par ligne (l'horloge serveur fait foi) ;
/// - RESTAURATION : tirage complet depuis l'origine (nouvel appareil).
///
/// Silencieuse, jamais bloquante : en mode local ou sans session, ne fait rien.
class SyncService {
  SyncService(this._db);

  final AmioraDatabase _db;
  bool _running = false;

  static const _lastPullKey = 'sync_last_pulled_at';

  Future<({int pushed, int pulled})> synchronize() async {
    if (!SupabaseService.isConfigured || SupabaseService.userId == null) {
      return (pushed: 0, pulled: 0);
    }
    if (_running) return (pushed: 0, pulled: 0);
    _running = true;
    try {
      final pushed = await _push();
      final pulled = await _pull();
      await _pushSettings();
      if (pushed > 0 || pulled > 0) {
        Log.info('sync_completed pushed=$pushed pulled=$pulled');
      }
      return (pushed: pushed, pulled: pulled);
    } finally {
      _running = false;
    }
  }

  /// Restauration complète (nouvel appareil, réinstallation).
  Future<void> restore() async {
    await _db.setSetting(
      _lastPullKey,
      DateTime.utc(1970).toIso8601String(),
    );
    await synchronize();
  }

  // ---- Poussée ---------------------------------------------------------

  Future<int> _push() async {
    final pending = await (_db.select(_db.outbox)
          ..orderBy([(o) => OrderingTerm.asc(o.seq)]))
        .get();
    var pushed = 0;
    for (final op in pending) {
      try {
        await _pushOne(op);
        await (_db.delete(_db.outbox)..where((o) => o.seq.equals(op.seq)))
            .go();
        pushed++;
      } catch (e) {
        // L'ordre est préservé : on s'arrête à la première erreur et on
        // réessaiera au prochain déclenchement (réseau revenu, reprise…).
        await (_db.update(_db.outbox)..where((o) => o.seq.equals(op.seq)))
            .write(OutboxCompanion(attempts: Value(op.attempts + 1)));
        Log.warning('sync_push_retry entity=${op.entity} attempts=${op.attempts + 1}');
        break;
      }
    }
    return pushed;
  }

  Future<void> _pushOne(OutboxData op) async {
    final sb = SupabaseService.client;
    switch (op.entity) {
      case 'relationships':
        final row = await (_db.select(_db.relationships)
              ..where((r) => r.id.equals(op.entityId)))
            .getSingleOrNull();
        if (row == null) return;
        await sb.from('relationships').upsert(_mapRelationship(row));
      case 'interactions':
        final row = await (_db.select(_db.interactions)
              ..where((i) => i.id.equals(op.entityId)))
            .getSingleOrNull();
        if (row == null) return;
        await sb.from('interactions').upsert(_mapInteraction(row));
        final links = await (_db.select(_db.interactionParticipants)
              ..where((p) => p.interactionId.equals(op.entityId)))
            .get();
        if (links.isNotEmpty) {
          await sb.from('interaction_participants').upsert([
            for (final link in links)
              {
                'id': stableLinkId(link.interactionId, link.relationshipId),
                'user_id': SupabaseService.userId,
                'interaction_id': link.interactionId,
                'relationship_id': link.relationshipId,
                'deleted_at': link.deletedAt?.toUtc().toIso8601String(),
              },
          ]);
        }
      case 'memories':
        final row = await (_db.select(_db.memories)
              ..where((m) => m.id.equals(op.entityId)))
            .getSingleOrNull();
        if (row == null) return;
        final links = await (_db.select(_db.memoryLinks)
              ..where((l) => l.memoryId.equals(op.entityId)))
            .get();
        await sb.from('memories').upsert(_mapMemory(row, links));
        if (links.isNotEmpty) {
          await sb.from('memory_links').upsert([
            for (final link in links)
              {
                'id': stableLinkId(link.memoryId, link.relationshipId),
                'user_id': SupabaseService.userId,
                'memory_id': link.memoryId,
                'relationship_id': link.relationshipId,
                'deleted_at': link.deletedAt?.toUtc().toIso8601String(),
              },
          ]);
        }
      case 'promises':
        final row = await (_db.select(_db.promises)
              ..where((p) => p.id.equals(op.entityId)))
            .getSingleOrNull();
        if (row == null) return;
        await sb.from('promises').upsert(_mapPromise(row));
      case 'important_dates':
        final row = await (_db.select(_db.importantDates)
              ..where((d) => d.id.equals(op.entityId)))
            .getSingleOrNull();
        if (row == null) return;
        await sb.from('important_dates').upsert(_mapImportantDate(row));
      default:
        Log.warning('sync_push_unknown_entity ${op.entity}');
    }
  }

  // ---- Tirage (last-write-wins par ligne) -------------------------------

  Future<int> _pull() async {
    final sb = SupabaseService.client;
    final sinceRaw = await _db.settingValue(_lastPullKey);
    final since = sinceRaw == null
        ? DateTime.utc(1970)
        : DateTime.parse(jsonDecode(sinceRaw) as String);
    var maxSeen = since;
    var applied = 0;

    // Identifiants avec mutation locale en attente : le serveur ne doit
    // pas les écraser avant que la poussée ait abouti.
    final pendingIds = {
      for (final o in await _db.select(_db.outbox).get()) o.entityId,
    };

    Future<void> pullTable(
      String table,
      Future<void> Function(Map<String, dynamic> row) apply,
    ) async {
      final rows = await sb
          .from(table)
          .select()
          .gt('updated_at', since.toIso8601String())
          .order('updated_at', ascending: true);
      for (final row in rows) {
        final updatedAt = DateTime.parse(row['updated_at'] as String);
        if (updatedAt.isAfter(maxSeen)) maxSeen = updatedAt;
        if (pendingIds.contains(row['id'])) continue;
        await apply(row);
        applied++;
      }
    }

    await pullTable('relationships', (r) async {
      await _db.into(_db.relationships).insertOnConflictUpdate(
            RelationshipsCompanion.insert(
              id: r['id'] as String,
              firstName: r['first_name'] as String,
              lastName: Value(r['last_name'] as String?),
              category: r['category'] as String,
              status: Value(r['status'] as String),
              cadenceDays: r['expected_cadence_days'] as int,
              createdAt: DateTime.parse(r['created_at'] as String),
              birthday: Value(_dateOrNull(r['birthday'])),
              phone: Value(r['phone'] as String?),
              email: Value(r['email'] as String?),
              address: Value(r['address'] as String?),
              job: Value(r['job'] as String?),
              notes: Value(r['notes'] as String?),
              updatedAt: Value(DateTime.parse(r['updated_at'] as String)),
              deletedAt: Value(_timeOrNull(r['deleted_at'])),
            ),
          );
    });
    await pullTable('interactions', (r) async {
      await _db.into(_db.interactions).insertOnConflictUpdate(
            InteractionsCompanion.insert(
              id: r['id'] as String,
              type: r['type'] as String,
              occurredAt: DateTime.parse(r['occurred_at'] as String),
              durationMinutes: Value(r['duration_minutes'] as int?),
              quality: Value(r['quality'] as String?),
              location: Value(r['location'] as String?),
              note: Value(r['note'] as String?),
              updatedAt: Value(DateTime.parse(r['updated_at'] as String)),
              deletedAt: Value(_timeOrNull(r['deleted_at'])),
            ),
          );
    });
    await pullTable('interaction_participants', (r) async {
      await _db.into(_db.interactionParticipants).insertOnConflictUpdate(
            InteractionParticipantsCompanion.insert(
              interactionId: r['interaction_id'] as String,
              relationshipId: r['relationship_id'] as String,
              deletedAt: Value(_timeOrNull(r['deleted_at'])),
            ),
          );
    });
    await pullTable('memories', (r) async {
      await _db.into(_db.memories).insertOnConflictUpdate(
            MemoriesCompanion.insert(
              id: r['id'] as String,
              type: r['type'] as String,
              title: Value(r['title'] as String?),
              body: Value(r['body'] as String?),
              createdAt: DateTime.parse(r['created_at'] as String),
              takenAt: Value(_timeOrNull(r['taken_at'])),
              updatedAt: Value(DateTime.parse(r['updated_at'] as String)),
              deletedAt: Value(_timeOrNull(r['deleted_at'])),
            ),
          );
    });
    await pullTable('memory_links', (r) async {
      await _db.into(_db.memoryLinks).insertOnConflictUpdate(
            MemoryLinksCompanion.insert(
              memoryId: r['memory_id'] as String,
              relationshipId: r['relationship_id'] as String,
              deletedAt: Value(_timeOrNull(r['deleted_at'])),
            ),
          );
    });
    await pullTable('promises', (r) async {
      await _db.into(_db.promises).insertOnConflictUpdate(
            PromisesCompanion.insert(
              id: r['id'] as String,
              relationshipId: r['relationship_id'] as String,
              title: r['title'] as String,
              dueDate: Value(_dateOrNull(r['due_date'])),
              priority: Value(r['priority'] as int?),
              status: Value(r['status'] as String),
              updatedAt: Value(DateTime.parse(r['updated_at'] as String)),
              deletedAt: Value(_timeOrNull(r['deleted_at'])),
            ),
          );
    });
    await pullTable('important_dates', (r) async {
      await _db.into(_db.importantDates).insertOnConflictUpdate(
            ImportantDatesCompanion.insert(
              id: r['id'] as String,
              relationshipId: r['relationship_id'] as String,
              type: r['type'] as String,
              date: DateTime.parse(r['date'] as String),
              recursAnnually: Value(r['recurs_annually'] as bool? ?? true),
              label: Value(r['label'] as String?),
              updatedAt: Value(DateTime.parse(r['updated_at'] as String)),
              deletedAt: Value(_timeOrNull(r['deleted_at'])),
            ),
          );
    });

    await _db.setSetting(_lastPullKey, jsonEncode(maxSeen.toIso8601String()));
    return applied;
  }

  // ---- Réglages (moteur de notifications serveur) -----------------------

  Future<void> _pushSettings() async {
    final birthdays = await _boolSetting('notif_birthdays', true);
    final attention = await _boolSetting('notif_attention', true);
    final weekly = await _boolSetting('notif_weekly', false);
    await SupabaseService.client.from('settings').upsert({
      'user_id': SupabaseService.userId,
      'notifications_enabled': birthdays || attention || weekly,
      'extra': {
        'timezone': DateTime.now().timeZoneName,
        'notif_birthdays': birthdays,
        'notif_attention': attention,
        'notif_weekly': weekly,
      },
    });
  }

  Future<bool> _boolSetting(String key, bool fallback) async {
    final raw = await _db.settingValue(key);
    return raw == null ? fallback : raw == 'true';
  }

  // ---- Correspondances local → serveur -----------------------------------

  Map<String, dynamic> _mapRelationship(Relationship r) => {
        'id': r.id,
        'user_id': SupabaseService.userId,
        'first_name': r.firstName,
        'last_name': r.lastName,
        'category': r.category,
        'status': r.status,
        'birthday': _dateString(r.birthday),
        'phone': r.phone,
        'email': r.email,
        'address': r.address,
        'job': r.job,
        'notes': r.notes,
        'expected_cadence_days': r.cadenceDays,
        'created_at': r.createdAt.toUtc().toIso8601String(),
        'deleted_at': r.deletedAt?.toUtc().toIso8601String(),
      };

  Map<String, dynamic> _mapInteraction(Interaction i) => {
        'id': i.id,
        'user_id': SupabaseService.userId,
        'type': i.type,
        'occurred_at': i.occurredAt.toUtc().toIso8601String(),
        'duration_minutes': i.durationMinutes,
        'quality': i.quality,
        'location': i.location,
        'note': i.note,
        'deleted_at': i.deletedAt?.toUtc().toIso8601String(),
      };

  Map<String, dynamic> _mapMemory(Memory m, List<MemoryLink> links) => {
        'id': m.id,
        'user_id': SupabaseService.userId,
        // Colonne héritée mono-relation : premier lien (les liens complets
        // vivent dans memory_links, migration 20260706).
        'relationship_id': links.isEmpty ? null : links.first.relationshipId,
        'type': m.type,
        'title': m.title,
        'body': m.body,
        'taken_at': (m.takenAt ?? m.createdAt).toUtc().toIso8601String(),
        'deleted_at': m.deletedAt?.toUtc().toIso8601String(),
      };

  Map<String, dynamic> _mapPromise(Promise p) => {
        'id': p.id,
        'user_id': SupabaseService.userId,
        'relationship_id': p.relationshipId,
        'title': p.title,
        'due_date': _dateString(p.dueDate),
        'priority': p.priority ?? 2,
        'status': p.status,
        // Contrainte serveur : done ⟺ completed_at non nul.
        'completed_at':
            p.status == 'done' ? DateTime.now().toUtc().toIso8601String() : null,
        'deleted_at': p.deletedAt?.toUtc().toIso8601String(),
      };

  Map<String, dynamic> _mapImportantDate(ImportantDate d) => {
        'id': d.id,
        'user_id': SupabaseService.userId,
        'relationship_id': d.relationshipId,
        'type': d.type,
        'date': _dateString(d.date),
        'recurs_annually': d.recursAnnually,
        'label': d.label,
        'deleted_at': d.deletedAt?.toUtc().toIso8601String(),
      };

  String? _dateString(DateTime? d) => d == null
      ? null
      : '${d.year.toString().padLeft(4, '0')}-'
          '${d.month.toString().padLeft(2, '0')}-'
          '${d.day.toString().padLeft(2, '0')}';

  DateTime? _dateOrNull(Object? v) =>
      v == null ? null : DateTime.parse(v as String);

  DateTime? _timeOrNull(Object? v) =>
      v == null ? null : DateTime.parse(v as String);
}

/// Identifiant stable d'une ligne de liaison (UUID v5 déterministe) :
/// permet l'upsert idempotent côté serveur.
String stableLinkId(String a, String b) =>
    const Uuid().v5(Namespace.url.value, 'https://amiora.ch/link/$a/$b');

final syncServiceProvider = Provider<SyncService>(
  (ref) => SyncService(ref.watch(databaseProvider)),
);
