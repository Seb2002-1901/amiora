/// Indice de présence — implémentation de référence.
///
/// CONTRAT : ce fichier implémente À LA LETTRE le livrable
/// docs/sprint-0/01-indice-de-presence.md. Toute modification de la
/// formule passe par une révision du livrable, jamais par ce fichier seul.
/// Dart pur : testable sans Flutter ni base de données.
library;

import 'dart:math' as math;

import '../entities/entities.dart';

/// Cadence attendue par défaut (jours) — livrable 01 § 2.1.
const Map<RelationshipCategory, int> kDefaultCadenceDays = {
  RelationshipCategory.partner: 2,
  RelationshipCategory.child: 3,
  RelationshipCategory.family: 7,
  RelationshipCategory.friend: 14,
  RelationshipCategory.mentor: 30,
  RelationshipCategory.professional: 30,
  RelationshipCategory.other: 30,
};

/// Durées effectives par défaut (minutes) — livrable 01 § 2.2.
const Map<InteractionType, int> kDefaultDurationMinutes = {
  InteractionType.call: 15,
  InteractionType.message: 2,
  InteractionType.meal: 90,
  InteractionType.outing: 180,
  InteractionType.visit: 120,
  InteractionType.trip: 600,
  InteractionType.gift: 15,
  InteractionType.moment: 60,
  InteractionType.photo: 5,
  InteractionType.event: 180,
};

/// Objectif de temps ensemble (minutes / 90 jours) — livrable 01 § 2.3.
const Map<RelationshipCategory, int> kTargetMinutesPer90Days = {
  RelationshipCategory.partner: 1800,
  RelationshipCategory.child: 1200,
  RelationshipCategory.family: 600,
  RelationshipCategory.friend: 360,
  RelationshipCategory.mentor: 120,
  RelationshipCategory.professional: 120,
  RelationshipCategory.other: 120,
};

/// Plafond de chute du score affiché : 1,2 point/jour (§ 4.2).
const double kMaxDropPerDay = 1.2;

/// Plancher pour une relation ayant eu au moins une interaction (§ 4).
const int kScoreFloor = 15;

/// Durée de la période de découverte (§ 4.1).
const int kDiscoveryDays = 14;

sealed class PresenceResult {
  const PresenceResult();
}

/// Relation de moins de 14 jours sans interaction : pastille
/// « Nouvelle relation », pas de chiffre (§ 4.1).
final class PresenceNewRelation extends PresenceResult {
  const PresenceNewRelation();
}

final class PresenceScore extends PresenceResult {
  const PresenceScore({
    required this.display,
    required this.calc,
    required this.components,
  });

  final int display;
  final int calc;
  final PresenceComponents components;
}

/// Composantes dans [0, 1], avant pondération.
final class PresenceComponents {
  const PresenceComponents({
    required this.freshness,
    required this.regularity,
    required this.timeTogether,
    required this.promises,
    required this.memories,
    required this.importantDates,
  });

  final double freshness; // F — 35 %
  final double regularity; // R — 25 %
  final double timeTogether; // T — 15 %
  final double promises; // Pc — 10 %
  final double memories; // S — 10 %
  final double importantDates; // D — 5 %
}

/// Arrondi « half up » (§ 9.8) : 0,5 → 1 (jamais d'arrondi bancaire).
int roundHalfUp(double value) => (value + 0.5).floor();

/// Normalise un instant à sa date calendaire locale (minuit local).
DateTime dateOnly(DateTime t) => DateTime(t.year, t.month, t.day);

/// Différence en jours calendaires entiers (b − a).
int daysBetween(DateTime a, DateTime b) =>
    dateOnly(b).difference(dateOnly(a)).inDays;

/// Calcule l'Indice de présence d'une relation au jour [today].
///
/// [interactions], [memories], [promises], [importantDates] peuvent
/// contenir des éléments d'autres relations : le filtrage se fait ici
/// (une interaction multi-personnes est créditée à chaque participant).
/// Les données supprimées ne doivent PAS être passées (le recalcul
/// depuis les données vivantes est la règle — § 5).
PresenceResult computePresenceScore({
  required Relationship rel,
  required List<Interaction> interactions,
  required List<Memory> memories,
  required List<Promise> promises,
  required List<ImportantDate> importantDates,
  PresenceSnapshot? lastSnapshot,
  required DateTime today,
}) {
  final day = dateOnly(today);
  final int p = rel.cadenceDays;
  final int age = daysBetween(rel.createdAt, day);

  final own = interactions
      .where((i) =>
          i.participantIds.contains(rel.id) &&
          !dateOnly(i.occurredAt).isAfter(day),)
      .toList();

  if (age < kDiscoveryDays && own.isEmpty) {
    return const PresenceNewRelation();
  }

  // --- F : fraîcheur (ancre = dernière interaction, sinon création).
  DateTime anchor = rel.createdAt;
  for (final i in own) {
    if (i.occurredAt.isAfter(anchor)) anchor = i.occurredAt;
  }
  final int d = daysBetween(anchor, day);
  final double f = d <= p ? 1.0 : math.pow(0.5, (d - p) / (2.0 * p)).toDouble();

  // --- R : régularité sur n fenêtres de P jours.
  // La fenêtre k couvre les distances de jour dd ∈ [(k−1)·P, k·P).
  double r;
  if (age < p) {
    r = 0.6;
  } else {
    final int n = math.min(8, math.max(1, age ~/ p));
    final hitWindows = <int>{};
    for (final i in own) {
      final int dd = daysBetween(i.occurredAt, day);
      if (dd >= 0 && dd < n * p) hitWindows.add(dd ~/ p);
    }
    r = hitWindows.length / n;
  }

  // --- T : temps ensemble sur 90 jours, objectif proratisé (w).
  final double w = math.min(90, math.max(age, kDiscoveryDays)) / 90.0;
  int minutes90 = 0;
  for (final i in own) {
    final int dd = daysBetween(i.occurredAt, day);
    if (dd >= 0 && dd < 90) {
      minutes90 += i.durationMinutes ?? kDefaultDurationMinutes[i.type]!;
    }
  }
  final double t =
      math.min(1.0, minutes90 / (kTargetMinutesPer90Days[rel.category]! * w));

  // --- Pc : promesses échues sur 180 jours.
  final duePromises = promises.where((pr) {
    if (pr.relationshipId != rel.id || pr.dueDate == null) return false;
    final int dd = daysBetween(pr.dueDate!, day);
    return dd >= 0 && dd <= 180;
  }).toList();
  final double pc = duePromises.isEmpty
      ? 0.7
      : duePromises.where((pr) => pr.status == PromiseStatus.done).length /
          duePromises.length;

  // --- S : souvenirs sur 90 jours.
  int mem90 = 0;
  for (final m in memories) {
    if (!m.relationshipIds.contains(rel.id)) continue;
    final int dd = daysBetween(m.createdAt, day);
    if (dd >= 0 && dd < 90) mem90++;
  }
  final double s = math.min(1.0, mem90 / math.max(1.0, 3.0 * w));

  // --- D : dernière occurrence d'une date importante (± 3 jours).
  DateTime? lastOccurrence;
  for (final idate in importantDates) {
    if (idate.relationshipId != rel.id) continue;
    final occ = _lastOccurrence(idate, day);
    if (occ == null) continue;
    if (daysBetween(rel.createdAt, occ) < 0) continue; // avant la relation
    if (daysBetween(occ, day) > 365) continue;
    if (lastOccurrence == null || occ.isAfter(lastOccurrence)) {
      lastOccurrence = occ;
    }
  }
  double dComp;
  if (lastOccurrence == null) {
    dComp = 0.7;
  } else {
    final celebrated = own.any(
      (i) => daysBetween(i.occurredAt, lastOccurrence!).abs() <= 3,
    );
    dComp = celebrated ? 1.0 : 0.4;
  }

  // --- Période de découverte : bornes basses hors F (§ 4.1).
  if (age < kDiscoveryDays) {
    r = math.max(r, 0.6);
    final tFloored = math.max(t, 0.6);
    final pcFloored = math.max(pc, 0.6);
    final sFloored = math.max(s, 0.6);
    dComp = math.max(dComp, 0.6);
    return _assemble(
      f, r, tFloored, pcFloored, sFloored, dComp,
      hasInteractions: own.isNotEmpty,
      lastSnapshot: lastSnapshot,
      today: day,
    );
  }

  return _assemble(
    f, r, t, pc, s, dComp,
    hasInteractions: own.isNotEmpty,
    lastSnapshot: lastSnapshot,
    today: day,
  );
}

PresenceScore _assemble(
  double f,
  double r,
  double t,
  double pc,
  double s,
  double d, {
  required bool hasInteractions,
  required PresenceSnapshot? lastSnapshot,
  required DateTime today,
}) {
  final double raw =
      100 * (0.35 * f + 0.25 * r + 0.15 * t + 0.10 * pc + 0.10 * s + 0.05 * d);

  int calc = roundHalfUp(raw).clamp(0, 100);
  if (hasInteractions) calc = math.max(calc, kScoreFloor);

  // Chute plafonnée (§ 4.2) : baisses ≤ 1,2 pt/jour, hausses instantanées.
  int display = calc;
  if (lastSnapshot != null && calc < lastSnapshot.scoreDisplay) {
    final int elapsed = math.max(1, daysBetween(lastSnapshot.date, today));
    display = roundHalfUp(
      math.max(
        calc.toDouble(),
        lastSnapshot.scoreDisplay - kMaxDropPerDay * elapsed,
      ),
    );
  }

  return PresenceScore(
    display: display,
    calc: calc,
    components: PresenceComponents(
      freshness: f,
      regularity: r,
      timeTogether: t,
      promises: pc,
      memories: s,
      importantDates: d,
    ),
  );
}

/// Dernière occurrence d'une date importante au plus tard [day].
DateTime? _lastOccurrence(ImportantDate idate, DateTime day) {
  final base = dateOnly(idate.date);
  if (!idate.recursAnnually) {
    return base.isAfter(day) ? null : base;
  }
  var occ = DateTime(day.year, base.month, base.day);
  if (occ.isAfter(day)) occ = DateTime(day.year - 1, base.month, base.day);
  return occ.isBefore(base) ? null : occ;
}
