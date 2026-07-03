// Test de bout en bout du geste central (Étape 3 du mandat) :
// créer une relation → enregistrer une interaction → l'Indice de
// présence est recalculé et historisé — le tout sur une vraie base
// Drift (SQLite en mémoire), comme en production locale.
import 'package:amiora/data/local/database.dart';
import 'package:amiora/data/presence_repository.dart';
import 'package:amiora/domain/presence/presence_score.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AmioraDatabase db;
  late PresenceRepository repo;

  setUp(() {
    db = AmioraDatabase(NativeDatabase.memory());
    repo = PresenceRepository(db);
  });

  tearDown(() => db.close());

  test('Le geste central fonctionne de bout en bout sur la base locale',
      () async {
    final today = DateTime(2026, 7, 3);

    // 1. Créer une relation (Papa, famille, cadence 7 j).
    await db.insertRelationship(
      RelationshipsCompanion.insert(
        id: 'papa',
        firstName: 'Papa',
        category: 'family',
        cadenceDays: 7,
        createdAt: DateTime(2025, 1, 1),
      ),
    );
    final rels = await db.watchActiveRelationships().first;
    expect(rels, hasLength(1));

    // 2. Sans interaction : la relation existe, l'indice décroît depuis
    //    la création (pas de plancher sans interaction).
    final before = await repo.computeAll(today);
    expect(before['papa'], isA<PresenceScore>());

    // 3. Le geste central : enregistrer un appel aujourd'hui.
    await db.insertInteraction(
      InteractionsCompanion.insert(
        id: 'i1',
        type: 'call',
        occurredAt: today,
        durationMinutes: const Value(25),
      ),
      ['papa'],
    );
    final interactions = await db.interactionsForRelationship('papa');
    expect(interactions, hasLength(1));
    expect(interactions.first.type, 'call');

    // 4. Recalcul immédiat : fraîcheur au maximum, score en hausse.
    final after = await repo.computeAll(today);
    final scoreAfter = after['papa']! as PresenceScore;
    final scoreBefore = before['papa']! as PresenceScore;
    expect(scoreAfter.components.freshness, 1.0);
    expect(scoreAfter.display, greaterThan(scoreBefore.display));

    // 5. L'instantané du jour est historisé (chute plafonnée, historique).
    final snapshot = await db.lastSnapshotFor('papa');
    expect(snapshot, isNotNull);
    expect(snapshot!.scoreDisplay, scoreAfter.display);

    // 6. Archivage : la relation sort du cercle actif.
    await db.setRelationshipStatus('papa', 'archived');
    expect(await db.watchActiveRelationships().first, isEmpty);
    expect(await repo.computeAll(today), isEmpty);
  });

  test('Souvenirs et promesses alimentent les composantes S et Pc', () async {
    final today = DateTime(2026, 7, 3);
    await db.insertRelationship(
      RelationshipsCompanion.insert(
        id: 'maman',
        firstName: 'Maman',
        category: 'family',
        cadenceDays: 7,
        createdAt: DateTime(2024, 1, 1),
      ),
    );
    await db.insertInteraction(
      InteractionsCompanion.insert(id: 'i0', type: 'call', occurredAt: today),
      ['maman'],
    );

    final before = (await repo.computeAll(today))['maman']! as PresenceScore;
    expect(before.components.memories, 0.0);
    expect(before.components.promises, 0.7); // neutre sans promesse échue

    // Un souvenir lié → S progresse.
    await db.insertMemory(
      MemoriesCompanion.insert(
        id: 'm1',
        type: 'note',
        createdAt: today,
      ),
      ['maman'],
    );
    // Une promesse échue et tenue → Pc = 1.
    await db.insertPromise(
      PromisesCompanion.insert(
        id: 'pr1',
        relationshipId: 'maman',
        title: 'Aller marcher ensemble',
        dueDate: Value(today.subtract(const Duration(days: 2))),
      ),
    );
    await db.setPromiseStatus('pr1', 'done');

    final after = (await repo.computeAll(today))['maman']! as PresenceScore;
    expect(after.components.memories, closeTo(1 / 3, 1e-9));
    expect(after.components.promises, 1.0);
    expect(after.display, greaterThan(before.display));

    // « En mémoire » : sort du calcul, souvenirs préservés.
    await db.setRelationshipStatus('maman', 'in_memoriam');
    expect(await repo.computeAll(today), isEmpty);
    expect(await db.memoriesForRelationship('maman'), hasLength(1));
  });

  test('Une interaction multi-personnes crédite chaque relation', () async {
    for (final id in ['emma', 'julie']) {
      await db.insertRelationship(
        RelationshipsCompanion.insert(
          id: id,
          firstName: id,
          category: 'friend',
          cadenceDays: 14,
          createdAt: DateTime(2025, 1, 1),
        ),
      );
    }
    await db.insertInteraction(
      InteractionsCompanion.insert(
        id: 'sortie',
        type: 'outing',
        occurredAt: DateTime(2026, 7, 3),
      ),
      ['emma', 'julie'],
    );
    expect(await db.interactionsForRelationship('emma'), hasLength(1));
    expect(await db.interactionsForRelationship('julie'), hasLength(1));

    final scores = await repo.computeAll(DateTime(2026, 7, 3));
    expect(
      (scores['emma']! as PresenceScore).components.freshness,
      1.0,
    );
    expect(
      (scores['julie']! as PresenceScore).components.freshness,
      1.0,
    );
  });
}
