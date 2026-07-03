import 'dart:convert';

import 'package:drift/drift.dart';

import '../domain/entities/entities.dart' as domain;
import '../domain/presence/presence_score.dart';
import 'local/database.dart';

/// Calcule l'Indice de présence depuis la base locale (livrable 01 § 6) :
/// recalcul événementiel après chaque mutation + instantané quotidien.
class PresenceRepository {
  PresenceRepository(this._db);

  final AmioraDatabase _db;

  /// Recalcule toutes les relations actives et historise les instantanés.
  Future<Map<String, PresenceResult>> computeAll(DateTime today) async {
    final rels = await (_db.select(_db.relationships)
          ..where((r) => r.deletedAt.isNull() & r.status.equals('active')))
        .get();
    final results = <String, PresenceResult>{};
    for (final rel in rels) {
      results[rel.id] = await computeOne(rel, today);
    }
    return results;
  }

  Future<PresenceResult> computeOne(Relationship rel, DateTime today) async {
    final interactions = await _db.interactionsForRelationship(rel.id);
    final memories = await _db.memoriesForRelationship(rel.id);
    final promises = await _db.promisesForRelationship(rel.id);
    final dates = await _db.importantDatesForRelationship(rel.id);
    final snapshot = await _db.lastSnapshotFor(rel.id);

    final result = computePresenceScore(
      rel: _toDomainRelationship(rel),
      interactions: [
        for (final i in interactions)
          domain.Interaction(
            id: i.id,
            type: domain.InteractionType.values.byName(i.type),
            occurredAt: i.occurredAt,
            participantIds: [rel.id],
            durationMinutes: i.durationMinutes,
          ),
      ],
      memories: [
        for (final m in memories)
          domain.Memory(
            id: m.id,
            type: domain.MemoryType.values.byName(m.type),
            relationshipIds: [rel.id],
            createdAt: m.createdAt,
          ),
      ],
      promises: [
        for (final p in promises)
          domain.Promise(
            id: p.id,
            relationshipId: p.relationshipId,
            title: p.title,
            status: _promiseStatus(p.status),
            dueDate: p.dueDate,
          ),
      ],
      importantDates: [
        for (final d in dates)
          domain.ImportantDate(
            id: d.id,
            relationshipId: d.relationshipId,
            type: _dateType(d.type),
            date: d.date,
            recursAnnually: d.recursAnnually,
          ),
      ],
      lastSnapshot: snapshot == null
          ? null
          : domain.PresenceSnapshot(
              relationshipId: snapshot.relationshipId,
              date: snapshot.date,
              scoreCalc: snapshot.scoreCalc,
              scoreDisplay: snapshot.scoreDisplay,
            ),
      today: today,
    );

    if (result is PresenceScore) {
      await _db.upsertSnapshot(
        PresenceSnapshotsCompanion.insert(
          relationshipId: rel.id,
          date: dateOnly(today),
          scoreCalc: result.calc,
          scoreDisplay: result.display,
          componentsJson: Value(
            jsonEncode({
              'f': result.components.freshness,
              'r': result.components.regularity,
              't': result.components.timeTogether,
              'pc': result.components.promises,
              's': result.components.memories,
              'd': result.components.importantDates,
            }),
          ),
        ),
      );
    }
    return result;
  }

  domain.Relationship _toDomainRelationship(Relationship rel) {
    return domain.Relationship(
      id: rel.id,
      firstName: rel.firstName,
      lastName: rel.lastName,
      category: _category(rel.category),
      status: switch (rel.status) {
        'archived' => domain.RelationshipStatus.archived,
        'in_memoriam' => domain.RelationshipStatus.inMemoriam,
        _ => domain.RelationshipStatus.active,
      },
      cadenceDays: rel.cadenceDays,
      createdAt: rel.createdAt,
      birthday: rel.birthday,
    );
  }

  domain.RelationshipCategory _category(String value) =>
      domain.RelationshipCategory.values
          .firstWhere((c) => c.name == value, orElse: () => domain.RelationshipCategory.other);

  domain.PromiseStatus _promiseStatus(String value) => switch (value) {
        'in_progress' => domain.PromiseStatus.inProgress,
        'done' => domain.PromiseStatus.done,
        _ => domain.PromiseStatus.todo,
      };

  domain.ImportantDateType _dateType(String value) => switch (value) {
        'first_meeting' => domain.ImportantDateType.firstMeeting,
        'first_date' => domain.ImportantDateType.firstDate,
        _ => domain.ImportantDateType.values
            .firstWhere((t) => t.name == value, orElse: () => domain.ImportantDateType.custom),
      };
}
