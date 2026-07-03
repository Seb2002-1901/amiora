// Vecteurs de test de l'Indice de présence — livrable 01 §§ 8-9.
// Ces tests sont le CONTRAT de la formule : mêmes entrées → mêmes sorties.
import 'dart:math' as math;

import 'package:amiora/domain/entities/entities.dart';
import 'package:amiora/domain/presence/presence_bands.dart';
import 'package:amiora/domain/presence/presence_score.dart';
import 'package:flutter_test/flutter_test.dart';

/// Jour de référence des vecteurs : jeudi 5 mars 2026.
final DateTime today = DateTime(2026, 3, 5);

/// Date située [dd] jours avant le 5 mars 2026.
DateTime daysAgo(int dd) => DateTime(2026, 3, 5 - dd);

Relationship rel({
  String id = 'r1',
  RelationshipCategory category = RelationshipCategory.friend,
  int? cadenceDays,
  DateTime? createdAt,
}) {
  return Relationship(
    id: id,
    firstName: 'Test',
    category: category,
    status: RelationshipStatus.active,
    cadenceDays: cadenceDays ?? kDefaultCadenceDays[category]!,
    createdAt: createdAt ?? DateTime(2020, 1, 1),
  );
}

Interaction inter(
  String relId,
  int dd, {
  InteractionType type = InteractionType.call,
  int? minutes,
}) {
  return Interaction(
    id: 'i$dd-$relId',
    type: type,
    occurredAt: daysAgo(dd),
    participantIds: [relId],
    durationMinutes: minutes,
  );
}

Memory memo(String relId, int dd) => Memory(
      id: 'm$dd',
      type: MemoryType.note,
      relationshipIds: [relId],
      createdAt: daysAgo(dd),
    );

PresenceScore scoreOf(PresenceResult r) {
  expect(r, isA<PresenceScore>());
  return r as PresenceScore;
}

void main() {
  group('Exemples chiffrés du livrable 01 § 8', () {
    test('Exemple 1 — Emma, partenaire, IP = 94', () {
      final emma = rel(
        id: 'emma',
        category: RelationshipCategory.partner,
        createdAt: DateTime(2024, 6, 1),
      );
      final interactions = [
        for (final dd in [0, 2, 4, 6, 8, 10, 12]) inter('emma', dd, minutes: 300),
        // Dîner le jour de l'anniversaire de rencontre (24 janvier).
        inter('emma', 40, type: InteractionType.meal, minutes: 0),
      ];
      final result = scoreOf(computePresenceScore(
        rel: emma,
        interactions: interactions,
        memories: [for (final dd in [5, 15, 25, 35]) memo('emma', dd)],
        promises: const [],
        importantDates: [
          ImportantDate(
            id: 'd1',
            relationshipId: 'emma',
            type: ImportantDateType.firstMeeting,
            date: DateTime(2021, 1, 24),
            recursAnnually: true,
          ),
        ],
        today: today,
      ));

      expect(result.components.freshness, 1.0);
      expect(result.components.regularity, closeTo(0.875, 1e-9));
      expect(result.components.timeTogether, 1.0);
      expect(result.components.promises, closeTo(0.7, 1e-9));
      expect(result.components.memories, 1.0);
      expect(result.components.importantDates, 1.0);
      expect(result.calc, 94);
      expect(result.display, 94);
      expect(presenceBandLabel(presenceBand(result.display)), 'Très entretenue');
    });

    test('Exemple 2 — Papa, famille, IP = 65', () {
      final papa = rel(
        id: 'papa',
        category: RelationshipCategory.family,
        createdAt: DateTime(2020, 1, 1),
      );
      final result = scoreOf(computePresenceScore(
        rel: papa,
        interactions: [
          for (final dd in [21, 28, 35, 44, 50]) inter('papa', dd, minutes: 108),
        ],
        memories: [memo('papa', 30), memo('papa', 60)],
        promises: [
          Promise(
            id: 'p1',
            relationshipId: 'papa',
            title: 'Aller marcher ensemble',
            status: PromiseStatus.done,
            dueDate: daysAgo(10),
          ),
        ],
        importantDates: [
          ImportantDate(
            id: 'd2',
            relationshipId: 'papa',
            type: ImportantDateType.birthday,
            date: DateTime(1958, 2, 20),
            recursAnnually: true,
          ),
        ],
        today: today,
      ));

      expect(result.components.freshness, closeTo(0.5, 1e-9));
      expect(result.components.regularity, closeTo(0.625, 1e-9));
      expect(result.components.timeTogether, closeTo(0.9, 1e-9));
      expect(result.components.promises, 1.0);
      expect(result.components.memories, closeTo(2 / 3, 1e-9));
      expect(result.components.importantDates, 0.4);
      expect(result.calc, 65);
      expect(presenceBandLabel(presenceBand(result.display)), 'À entretenir');
    });

    test('Exemple 3 — Thomas, ami, IP = 27', () {
      final thomas = rel(
        id: 'thomas',
        category: RelationshipCategory.friend,
        createdAt: DateTime(2019, 6, 1),
      );
      final result = scoreOf(computePresenceScore(
        rel: thomas,
        interactions: [
          inter('thomas', 76, type: InteractionType.outing, minutes: 180),
        ],
        memories: const [],
        promises: const [],
        importantDates: [
          ImportantDate(
            id: 'd3',
            relationshipId: 'thomas',
            type: ImportantDateType.birthday,
            date: DateTime(1994, 2, 3),
            recursAnnually: true,
          ),
        ],
        today: today,
      ));

      expect(
        result.components.freshness,
        closeTo(math.pow(0.5, 62 / 28).toDouble(), 1e-9),
      );
      expect(result.components.regularity, closeTo(0.125, 1e-9));
      expect(result.components.timeTogether, closeTo(0.5, 1e-9));
      expect(result.calc, 27);
      expect(presenceBandLabel(presenceBand(result.display)), 'Peu entretenue');
    });

    test('Exemple 4 — relation créée aujourd’hui avec un repas, IP = 76', () {
      final nova = rel(
        id: 'nova',
        category: RelationshipCategory.partner,
        createdAt: today,
      );
      final result = scoreOf(computePresenceScore(
        rel: nova,
        interactions: [
          inter('nova', 0, type: InteractionType.meal, minutes: 90),
        ],
        memories: const [],
        promises: const [],
        importantDates: const [],
        today: today,
      ));

      expect(result.components.freshness, 1.0);
      expect(result.components.regularity, 0.6);
      expect(result.components.timeTogether, 0.6); // 0,321 borné à 0,6
      expect(result.components.promises, 0.7);
      expect(result.components.memories, 0.6);
      expect(result.components.importantDates, 0.7);
      expect(result.calc, 76);
    });

    test('Exemple 5 — relation jamais alimentée (mentor, 60 j), IP = 35', () {
      final mentor = rel(
        id: 'mentor',
        category: RelationshipCategory.mentor,
        createdAt: daysAgo(60),
      );
      final result = scoreOf(computePresenceScore(
        rel: mentor,
        interactions: const [],
        memories: const [],
        promises: const [],
        importantDates: const [],
        today: today,
      ));

      expect(result.components.freshness, closeTo(math.sqrt(0.5), 1e-9));
      expect(result.calc, 35);
    });

    test('Nouvelle relation sans interaction : pastille, pas de chiffre', () {
      final result = computePresenceScore(
        rel: rel(id: 'new', createdAt: daysAgo(3)),
        interactions: const [],
        memories: const [],
        promises: const [],
        importantDates: const [],
        today: today,
      );
      expect(result, isA<PresenceNewRelation>());
    });
  });

  group('Points remarquables et bornes (livrable 01 § 9)', () {
    PresenceScore freshnessAt(int dd) {
      return scoreOf(computePresenceScore(
        rel: rel(id: 'f', category: RelationshipCategory.family),
        interactions: [inter('f', dd)],
        memories: const [],
        promises: const [],
        importantDates: const [],
        today: today,
      ));
    }

    test('F : d = P → 1 ; d = 3P → 0,5 ; d = 5P → 0,25 (famille, P = 7)', () {
      expect(freshnessAt(7).components.freshness, 1.0);
      expect(freshnessAt(21).components.freshness, closeTo(0.5, 1e-9));
      expect(freshnessAt(35).components.freshness, closeTo(0.25, 1e-9));
    });

    test('Plancher 15 : une interaction il y a 400 jours', () {
      final result = scoreOf(computePresenceScore(
        rel: rel(id: 'old'),
        interactions: [inter('old', 400, minutes: 60)],
        memories: const [],
        promises: const [],
        importantDates: const [],
        today: today,
      ));
      expect(result.calc, kScoreFloor);
    });

    test('Chute plafonnée : affiché 80 hier, calculé 27 → affiché 79', () {
      final thomas = rel(
        id: 'thomas',
        category: RelationshipCategory.friend,
        createdAt: DateTime(2019, 6, 1),
      );
      final result = scoreOf(computePresenceScore(
        rel: thomas,
        interactions: [
          inter('thomas', 76, type: InteractionType.outing, minutes: 180),
        ],
        memories: const [],
        promises: const [],
        importantDates: const [],
        lastSnapshot: PresenceSnapshot(
          relationshipId: 'thomas',
          date: daysAgo(1),
          scoreCalc: 80,
          scoreDisplay: 80,
        ),
        today: today,
      ));
      expect(result.calc, lessThan(80));
      expect(result.display, 79); // 80 − 1,2 = 78,8 → 79
    });

    test('Hausse instantanée : affiché 50 hier, calculé 94 → affiché 94', () {
      final emma = rel(
        id: 'emma',
        category: RelationshipCategory.partner,
        createdAt: DateTime(2024, 6, 1),
      );
      final result = scoreOf(computePresenceScore(
        rel: emma,
        interactions: [
          for (final dd in [0, 2, 4, 6, 8, 10, 12]) inter('emma', dd, minutes: 300),
        ],
        memories: [for (final dd in [5, 15, 25, 35]) memo('emma', dd)],
        promises: const [],
        importantDates: const [],
        lastSnapshot: PresenceSnapshot(
          relationshipId: 'emma',
          date: daysAgo(1),
          scoreCalc: 50,
          scoreDisplay: 50,
        ),
        today: today,
      ));
      expect(result.display, result.calc);
      expect(result.display, greaterThan(50));
    });

    test('Interaction multi-personnes : créditée à chaque participant', () {
      final a = rel(id: 'a', category: RelationshipCategory.friend);
      final b = rel(id: 'b', category: RelationshipCategory.friend);
      final shared = Interaction(
        id: 'shared',
        type: InteractionType.outing,
        occurredAt: today,
        participantIds: const ['a', 'b'],
        durationMinutes: 180,
      );
      final ra = scoreOf(computePresenceScore(
        rel: a,
        interactions: [shared],
        memories: const [],
        promises: const [],
        importantDates: const [],
        today: today,
      ));
      final rb = scoreOf(computePresenceScore(
        rel: b,
        interactions: [shared],
        memories: const [],
        promises: const [],
        importantDates: const [],
        today: today,
      ));
      expect(ra.components.freshness, 1.0);
      expect(rb.components.freshness, 1.0);
      expect(ra.calc, rb.calc);
    });

    test('roundHalfUp : 0,5 → 1 (jamais d’arrondi bancaire)', () {
      expect(roundHalfUp(0.5), 1);
      expect(roundHalfUp(78.8), 79);
      expect(roundHalfUp(93.875), 94);
      expect(roundHalfUp(65.291666), 65);
    });
  });
}
