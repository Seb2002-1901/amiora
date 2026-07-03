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

  Future<void> insertRelationship(RelationshipsCompanion entry) =>
      into(relationships).insert(entry);

  Future<void> setRelationshipStatus(String id, String status) =>
      (update(relationships)..where((r) => r.id.equals(id))).write(
        RelationshipsCompanion(
          status: Value(status),
          archivedAt: Value(status == 'active' ? null : DateTime.now()),
        ),
      );

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

  Future<PresenceSnapshot?> lastSnapshotFor(String relId) =>
      (select(presenceSnapshots)
            ..where((s) => s.relationshipId.equals(relId))
            ..orderBy([(s) => OrderingTerm.desc(s.date)])
            ..limit(1))
          .getSingleOrNull();

  Future<void> upsertSnapshot(PresenceSnapshotsCompanion entry) =>
      into(presenceSnapshots).insertOnConflictUpdate(entry);
}
