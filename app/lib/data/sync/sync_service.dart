import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
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
  bool _rerunRequested = false;

  static const _lastPullKey = 'sync_last_pulled_at';

  /// Seuil d'alerte : au-delà, l'entrée outbox est signalée à chaque cycle
  /// (jamais supprimée — aucune perte silencieuse de mutation).
  static const _stuckAttempts = 20;

  /// Clés de réglages notifications répliquées vers le serveur.
  static const _notifKeys = ['notif_birthdays', 'notif_attention', 'notif_weekly'];

  Future<({int pushed, int pulled})> synchronize() async {
    if (!SupabaseService.isConfigured || SupabaseService.userId == null) {
      return (pushed: 0, pulled: 0);
    }
    if (_running) {
      // Une passe est en vol : on note la demande plutôt que de la jeter
      // (sinon la mutation attendrait le prochain déclenchement périodique).
      _rerunRequested = true;
      return (pushed: 0, pulled: 0);
    }
    _running = true;
    var pushed = 0;
    var pulled = 0;
    try {
      // Boucle bornée : une seule relance par vague de demandes reçues
      // pendant la passe en cours (pas de récursion).
      do {
        _rerunRequested = false;
        pushed += await _push();
        // Hors ligne : aucune exception ne doit fuir (même contrat que
        // _push, qui absorbe déjà les erreurs réseau).
        try {
          pulled += await _pull();
        } catch (e) {
          Log.warning('sync_pull_failed $e');
        }
        try {
          await _pushSettings();
        } catch (e) {
          Log.warning('sync_push_settings_failed $e');
        }
      } while (_rerunRequested);
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
    // Même format que le curseur écrit en fin de _pull (jsonEncode).
    await _db.setSetting(
      _lastPullKey,
      jsonEncode(DateTime.utc(1970).toIso8601String()),
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
      if (op.attempts >= _stuckAttempts) {
        Log.error('sync_push_stuck entity=${op.entity} attempts=${op.attempts}');
      }
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
    // Paresseux : le client n'est sollicité qu'une fois l'entité reconnue.
    late final sb = SupabaseService.client;
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
        // Erreur franche plutôt qu'une évacuation silencieuse : l'entrée
        // reste dans la file et son compteur d'essais la rend visible.
        throw StateError('entité outbox inconnue: ${op.entity}');
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

    // Re-vérification à l'instant T, dans la transaction d'application :
    // une mutation locale journalisée PENDANT le tirage prime sur l'écho
    // serveur (elle sera poussée au prochain cycle).
    Future<bool> applyUnlessPending(
      String id,
      Future<void> Function() apply,
    ) {
      return _db.transaction(() async {
        final pending = await (_db.select(_db.outbox)
              ..where((o) => o.entityId.equals(id))
              ..limit(1))
            .get();
        if (pending.isNotEmpty) return false;
        await apply();
        return true;
      });
    }

    // Tirage paginé : PostgREST plafonne chaque réponse à 1000 lignes.
    // Chaque table est épuisée page par page (tri stable updated_at puis
    // id) ; `gte` peut renvoyer des doublons de bord, sans effet car
    // l'application est idempotente (insertOnConflictUpdate).
    const pageSize = 1000;
    Future<void> pullTable(
      String table,
      Future<void> Function(Map<String, dynamic> row) apply,
    ) async {
      var offset = 0;
      while (true) {
        final rows = await sb
            .from(table)
            .select()
            .gte('updated_at', since.toIso8601String())
            .order('updated_at', ascending: true)
            .order('id', ascending: true)
            .range(offset, offset + pageSize - 1);
        for (final row in rows) {
          final updatedAt = DateTime.parse(row['updated_at'] as String);
          if (updatedAt.isAfter(maxSeen)) maxSeen = updatedAt;
          if (pendingIds.contains(row['id'])) continue;
          if (await applyUnlessPending(row['id'] as String, () => apply(row))) {
            applied++;
          }
        }
        if (rows.length < pageSize) break;
        offset += pageSize;
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
              archivedAt: Value(_timeOrNull(r['archived_at'])),
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

    await _pullSettings();

    // Le curseur global n'avance qu'une fois TOUTES les tables épuisées :
    // aucune ligne située après une page tronquée ne peut être perdue.
    await _db.setSetting(_lastPullKey, jsonEncode(maxSeen.toIso8601String()));
    return applied;
  }

  // ---- Réglages (moteur de notifications serveur) -----------------------

  /// Rapatrie les réglages serveur ABSENTS de la table locale : le réglage
  /// local explicite garde priorité (il sera poussé par [_pushSettings]).
  Future<void> _pullSettings() async {
    final row = await SupabaseService.client
        .from('settings')
        .select('extra')
        .maybeSingle();
    final extra = row?['extra'];
    if (extra is! Map<String, dynamic>) return;
    for (final entry in extra.entries) {
      final value = entry.value;
      if (value is! bool) continue; // champs techniques (fuseau…) ignorés
      if (await _db.settingValue(entry.key) != null) continue;
      await _db.setSetting(entry.key, value ? 'true' : 'false');
    }
  }

  Future<void> _pushSettings() async {
    // Seules les clés explicitement réglées localement sont poussées :
    // un appareil neuf n'écrase pas les préférences serveur avec des
    // valeurs par défaut.
    final extra = <String, Object>{};
    for (final key in _notifKeys) {
      final raw = await _db.settingValue(key);
      if (raw != null) extra[key] = raw == 'true';
    }
    // timeZoneName est souvent une abréviation (« CEST ») inexploitable :
    // seul un identifiant IANA (contient '/') est envoyé tel quel ; sinon
    // le décalage en minutes sert de repli au moteur de notifications.
    final now = DateTime.now();
    if (now.timeZoneName.contains('/')) {
      extra['timezone'] = now.timeZoneName;
    } else {
      extra['tz_offset_min'] = now.timeZoneOffset.inMinutes;
    }
    final toggles =
        _notifKeys.map((k) => extra[k]).whereType<bool>().toList();
    await SupabaseService.client.from('settings').upsert({
      'user_id': SupabaseService.userId,
      // Déduit des seuls réglages explicites — jamais de valeur par défaut.
      if (toggles.isNotEmpty) 'notifications_enabled': toggles.any((v) => v),
      'extra': extra,
    });
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
        if (r.archivedAt != null)
          'archived_at': r.archivedAt!.toUtc().toIso8601String(),
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
        // Sans created_at explicite, le serveur poserait now() et l'écho
        // corromprait la chronologie des souvenirs à la restauration.
        'created_at': m.createdAt.toUtc().toIso8601String(),
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

  // ---- Accès de test ------------------------------------------------------

  /// Charge utile serveur d'un souvenir — exposée pour les tests.
  @visibleForTesting
  Map<String, dynamic> debugMapMemory(Memory m, List<MemoryLink> links) =>
      _mapMemory(m, links);

  /// Rejeu d'une entrée outbox — exposé pour les tests.
  @visibleForTesting
  Future<void> debugPushOne(OutboxData op) => _pushOne(op);
}

/// Identifiant stable d'une ligne de liaison (UUID v5 déterministe) :
/// permet l'upsert idempotent côté serveur.
String stableLinkId(String a, String b) =>
    const Uuid().v5(Namespace.url.value, 'https://amiora.ch/link/$a/$b');

final syncServiceProvider = Provider<SyncService>(
  (ref) => SyncService(ref.watch(databaseProvider)),
);
