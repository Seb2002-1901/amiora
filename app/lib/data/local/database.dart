/// Base locale Drift (SQLite) — miroir hors-ligne d'abord du schéma
/// serveur (docs/sprint-0/04-schema.sql, supabase/migrations).
///
/// Règles de synchronisation (architecture § 4) :
/// - UUID générés côté client (offline-first) ;
/// - `updatedAt` posé par le SERVEUR fait foi (last-write-wins par ligne) ;
/// - suppression logique via `deletedAt`, purge serveur à J+30 ;
/// - toute mutation locale est journalisée dans [Outbox] puis rejouée
///   au retour du réseau (silencieusement).
///
/// Génération : `dart run build_runner build` (produit database.g.dart).
library;

import 'package:drift/drift.dart';

part 'database.g.dart';

mixin SyncColumns on Table {
  TextColumn get id => text()(); // UUID v4 client
  DateTimeColumn get updatedAt => dateTime().nullable()(); // horloge serveur
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

class Relationships extends Table with SyncColumns {
  TextColumn get firstName => text()();
  TextColumn get lastName => text().nullable()();
  TextColumn get category => text()(); // enum relationship_category
  TextColumn get status => text().withDefault(const Constant('active'))();
  IntColumn get cadenceDays => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get archivedAt => dateTime().nullable()();
  DateTimeColumn get birthday => dateTime().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get job => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get photoLocalPath => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Interactions extends Table with SyncColumns {
  TextColumn get type => text()(); // enum interaction_type
  DateTimeColumn get occurredAt => dateTime()();
  IntColumn get durationMinutes => integer().nullable()();
  TextColumn get quality => text().nullable()(); // enum interaction_quality
  TextColumn get location => text().nullable()();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class InteractionParticipants extends Table {
  TextColumn get interactionId => text().references(Interactions, #id)();
  TextColumn get relationshipId => text().references(Relationships, #id)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {interactionId, relationshipId};
}

class Albums extends Table with SyncColumns {
  TextColumn get title => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Memories extends Table with SyncColumns {
  TextColumn get type => text()(); // enum memory_type
  TextColumn get title => text().nullable()();
  TextColumn get body => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get takenAt => dateTime().nullable()();
  TextColumn get albumId => text().nullable().references(Albums, #id)();

  @override
  Set<Column> get primaryKey => {id};
}

class MemoryLinks extends Table {
  TextColumn get memoryId => text().references(Memories, #id)();
  TextColumn get relationshipId => text().references(Relationships, #id)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {memoryId, relationshipId};
}

/// Fichiers médias : upload en tâche de fond avec reprise
/// (compression ~2048 px / ~400 Ko + miniature avant envoi).
class MediaAssets extends Table with SyncColumns {
  TextColumn get memoryId => text().references(Memories, #id)();
  TextColumn get localPath => text().nullable()();
  TextColumn get storagePath => text().nullable()();
  TextColumn get thumbStoragePath => text().nullable()();
  IntColumn get sizeBytes => integer().nullable()();
  TextColumn get uploadStatus =>
      text().withDefault(const Constant('pending'))(); // pending|uploading|done|failed

  @override
  Set<Column> get primaryKey => {id};
}

class ImportantDates extends Table with SyncColumns {
  TextColumn get relationshipId => text().references(Relationships, #id)();
  TextColumn get type => text()(); // enum important_date_type
  DateTimeColumn get date => dateTime()();
  BoolColumn get recursAnnually => boolean().withDefault(const Constant(true))();
  TextColumn get label => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Promises extends Table with SyncColumns {
  TextColumn get relationshipId => text().references(Relationships, #id)();
  TextColumn get title => text()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  IntColumn get priority => integer().nullable()();
  TextColumn get status => text().withDefault(const Constant('todo'))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Événements planifiés (calendrier) — le passé consigné vit dans
/// [Interactions], le futur planifié ici.
class Events extends Table with SyncColumns {
  TextColumn get relationshipId =>
      text().nullable().references(Relationships, #id)();
  TextColumn get title => text()();
  DateTimeColumn get startsAt => dateTime()();
  TextColumn get kind => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Préférences d'une relation (restaurants, loisirs, idées cadeaux…)
/// en clé/valeur JSON — suffisant en V1 (revue du PRD § tables).
class Preferences extends Table with SyncColumns {
  TextColumn get relationshipId => text().references(Relationships, #id)();
  TextColumn get key => text()();
  TextColumn get valueJson => text()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Instantanés quotidiens de l'Indice de présence (livrable 01 § 6) —
/// nécessaires à la chute plafonnée et à l'historique.
class PresenceSnapshots extends Table {
  TextColumn get relationshipId => text().references(Relationships, #id)();
  DateTimeColumn get date => dateTime()();
  IntColumn get scoreCalc => integer()();
  IntColumn get scoreDisplay => integer()();
  TextColumn get componentsJson => text().nullable()();

  @override
  Set<Column> get primaryKey => {relationshipId, date};
}

class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get valueJson => text()();

  @override
  Set<Column> get primaryKey => {key};
}

/// File de mutations à rejouer vers Supabase (offline-first).
class Outbox extends Table {
  IntColumn get seq => integer().autoIncrement()();
  TextColumn get entity => text()();
  TextColumn get entityId => text()();
  TextColumn get op => text()(); // create|update|delete
  TextColumn get payloadJson => text()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
}

@DriftDatabase(tables: [
  Relationships,
  Interactions,
  InteractionParticipants,
  Albums,
  Memories,
  MemoryLinks,
  MediaAssets,
  ImportantDates,
  Promises,
  Events,
  Preferences,
  PresenceSnapshots,
  AppSettings,
  Outbox,
])
class AmioraDatabase extends _$AmioraDatabase {
  AmioraDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  // ---- Relations -----------------------------------------------------

  Stream<List<Relationship>> watchActiveRelationships() {
    return (select(relationships)
          ..where((r) => r.deletedAt.isNull() & r.status.equals('active'))
          ..orderBy([(r) => OrderingTerm.asc(r.firstName)]))
        .watch();
  }

  Future<Relationship?> relationshipById(String id) =>
      (select(relationships)..where((r) => r.id.equals(id))).getSingleOrNull();

  Future<void> insertRelationship(RelationshipsCompanion entry) {
    return transaction(() async {
      await into(relationships).insert(entry);
      await journalMutation('relationships', entry.id.value, 'create');
    });
  }

  Future<void> setRelationshipStatus(String id, String status) {
    return transaction(() async {
      await (update(relationships)..where((r) => r.id.equals(id))).write(
        RelationshipsCompanion(
          status: Value(status),
          archivedAt: Value(status == 'active' ? null : DateTime.now()),
        ),
      );
      await journalMutation('relationships', id, 'update');
    });
  }

  // ---- Interactions (le geste central) -------------------------------

  /// Insère une interaction et ses participants en une transaction.
  Future<void> insertInteraction(
    InteractionsCompanion entry,
    List<String> relationshipIds,
  ) {
    return transaction(() async {
      await into(interactions).insert(entry);
      for (final relId in relationshipIds) {
        await into(interactionParticipants).insert(
          InteractionParticipantsCompanion.insert(
            interactionId: entry.id.value,
            relationshipId: relId,
          ),
        );
      }
      await journalMutation('interactions', entry.id.value, 'create');
    });
  }

  /// Interactions (vivantes) d'une relation, plus récentes d'abord.
  Future<List<Interaction>> interactionsForRelationship(String relId) {
    final query = select(interactions).join([
      innerJoin(
        interactionParticipants,
        interactionParticipants.interactionId.equalsExp(interactions.id),
      ),
    ])
      ..where(
        interactionParticipants.relationshipId.equals(relId) &
            interactions.deletedAt.isNull() &
            interactionParticipants.deletedAt.isNull(),
      )
      ..orderBy([OrderingTerm.desc(interactions.occurredAt)]);
    return query.map((row) => row.readTable(interactions)).get();
  }

  // ---- Données du calcul de l'Indice ---------------------------------

  Future<List<Memory>> memoriesForRelationship(String relId) {
    final query = select(memories).join([
      innerJoin(memoryLinks, memoryLinks.memoryId.equalsExp(memories.id)),
    ])
      ..where(
        memoryLinks.relationshipId.equals(relId) &
            memories.deletedAt.isNull() &
            memoryLinks.deletedAt.isNull(),
      );
    return query.map((row) => row.readTable(memories)).get();
  }

  Future<List<Promise>> promisesForRelationship(String relId) =>
      (select(promises)
            ..where(
              (p) => p.relationshipId.equals(relId) & p.deletedAt.isNull(),
            ))
          .get();

  Future<List<ImportantDate>> importantDatesForRelationship(String relId) =>
      (select(importantDates)
            ..where(
              (d) => d.relationshipId.equals(relId) & d.deletedAt.isNull(),
            ))
          .get();

  // ---- Souvenirs ------------------------------------------------------

  /// Souvenirs vivants, plus récents d'abord.
  Stream<List<Memory>> watchMemories() {
    return (select(memories)
          ..where((m) => m.deletedAt.isNull())
          ..orderBy([(m) => OrderingTerm.desc(m.createdAt)]))
        .watch();
  }

  Future<void> insertMemory(
    MemoriesCompanion entry,
    List<String> relationshipIds,
  ) {
    return transaction(() async {
      await into(memories).insert(entry);
      for (final relId in relationshipIds) {
        await into(memoryLinks).insert(
          MemoryLinksCompanion.insert(
            memoryId: entry.id.value,
            relationshipId: relId,
          ),
        );
      }
      await journalMutation('memories', entry.id.value, 'create');
    });
  }

  // ---- Promesses -------------------------------------------------------

  Stream<List<Promise>> watchPromises() {
    return (select(promises)
          ..where((p) => p.deletedAt.isNull())
          ..orderBy([
            (p) => OrderingTerm.asc(p.dueDate),
            (p) => OrderingTerm.asc(p.title),
          ]))
        .watch();
  }

  Future<void> insertPromise(PromisesCompanion entry) {
    return transaction(() async {
      await into(promises).insert(entry);
      await journalMutation('promises', entry.id.value, 'create');
    });
  }

  Future<void> setPromiseStatus(String id, String status) {
    return transaction(() async {
      await (update(promises)..where((p) => p.id.equals(id)))
          .write(PromisesCompanion(status: Value(status)));
      await journalMutation('promises', id, 'update');
    });
  }

  Future<void> softDeletePromise(String id) {
    return transaction(() async {
      await (update(promises)..where((p) => p.id.equals(id)))
          .write(PromisesCompanion(deletedAt: Value(DateTime.now())));
      await journalMutation('promises', id, 'delete');
    });
  }

  /// Journalise une mutation dans la file de synchronisation (outbox).
  /// La poussée relit l'état COURANT de la ligne : la file ne porte que
  /// l'ordre et l'identité, jamais une charge utile figée.
  Future<void> journalMutation(String entity, String entityId, String op) =>
      into(outbox).insert(
        OutboxCompanion.insert(
          entity: entity,
          entityId: entityId,
          op: op,
          payloadJson: '{}',
          createdAt: DateTime.now(),
        ),
      );

  // ---- Statistiques (calcul dérivé, jamais stocké) ---------------------

  /// Compte des interactions par type et minutes cumulées depuis [from].
  Future<(Map<String, int>, int)> interactionStatsSince(DateTime from) async {
    final rows = await (select(interactions)
          ..where(
            (i) =>
                i.deletedAt.isNull() &
                i.occurredAt.isBiggerOrEqualValue(from),
          ))
        .get();
    final byType = <String, int>{};
    var minutes = 0;
    for (final i in rows) {
      byType[i.type] = (byType[i.type] ?? 0) + 1;
      minutes += i.durationMinutes ?? 0;
    }
    return (byType, minutes);
  }

  Future<int> memoriesCountSince(DateTime from) async {
    final rows = await (select(memories)
          ..where(
            (m) =>
                m.deletedAt.isNull() & m.createdAt.isBiggerOrEqualValue(from),
          ))
        .get();
    return rows.length;
  }

  // ---- En mémoire ------------------------------------------------------

  Stream<List<Relationship>> watchInMemoriam() {
    return (select(relationships)
          ..where(
            (r) => r.deletedAt.isNull() & r.status.equals('in_memoriam'),
          )
          ..orderBy([(r) => OrderingTerm.asc(r.firstName)]))
        .watch();
  }

  // ---- Réglages (clé/valeur JSON) --------------------------------------

  Future<String?> settingValue(String key) async {
    final row = await (select(appSettings)..where((s) => s.key.equals(key)))
        .getSingleOrNull();
    return row?.valueJson;
  }

  Future<void> setSetting(String key, String valueJson) =>
      into(appSettings).insertOnConflictUpdate(
        AppSettingsCompanion.insert(key: key, valueJson: valueJson),
      );

  Future<PresenceSnapshot?> lastSnapshotFor(String relId) =>
      (select(presenceSnapshots)
            ..where((s) => s.relationshipId.equals(relId))
            ..orderBy([(s) => OrderingTerm.desc(s.date)])
            ..limit(1))
          .getSingleOrNull();

  Future<void> upsertSnapshot(PresenceSnapshotsCompanion entry) =>
      into(presenceSnapshots).insertOnConflictUpdate(entry);
}
