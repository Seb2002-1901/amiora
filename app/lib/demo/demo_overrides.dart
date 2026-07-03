/// Mode vitrine (`--dart-define=AMIORA_DEMO=true`) : jeu de données
/// canonique des maquettes (jeudi 5 mars 2026) injecté à la place de la
/// base locale. Sert aux captures d'écran (stores, revues de design) et
/// aux vérifications responsive sur navigateur — AUCUNE écriture réelle.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/app_providers.dart';
import '../data/local/database.dart';
import '../domain/presence/presence_score.dart';

final _now = DateTime.now();

Relationship _rel(
  String id,
  String firstName,
  String category,
  int cadence,
) {
  return Relationship(
    id: id,
    firstName: firstName,
    category: category,
    status: 'active',
    cadenceDays: cadence,
    createdAt: _now.subtract(const Duration(days: 700)),
  );
}

final _relationships = <Relationship>[
  _rel('emma', 'Emma', 'partner', 2),
  _rel('maman', 'Maman', 'family', 7),
  _rel('julie', 'Julie', 'friend', 14),
  _rel('papa', 'Papa', 'family', 7),
  _rel('grandmaman', 'Grand-maman', 'family', 7),
  _rel('thomas', 'Thomas', 'friend', 14),
];

PresenceScore _score(int display, double f, double r, double t) {
  return PresenceScore(
    display: display,
    calc: display,
    components: PresenceComponents(
      freshness: f,
      regularity: r,
      timeTogether: t,
      promises: 0.7,
      memories: 0.7,
      importantDates: 0.7,
    ),
  );
}

final _scores = <String, PresenceResult>{
  'emma': _score(94, 1, 0.875, 1),
  'maman': _score(88, 1, 0.75, 0.9),
  'julie': _score(76, 0.9, 0.625, 0.7),
  'papa': _score(65, 0.5, 0.625, 0.9),
  'grandmaman': _score(58, 0.35, 0.5, 0.6),
  'thomas': _score(27, 0.22, 0.125, 0.5),
};

Interaction _inter(String id, String type, int daysAgo, {int? minutes}) {
  return Interaction(
    id: id,
    type: type,
    occurredAt: _now.subtract(Duration(days: daysAgo)),
    durationMinutes: minutes,
  );
}

final _interactions = <String, List<Interaction>>{
  'emma': [
    _inter('e1', 'message', 0),
    _inter('e2', 'meal', 2, minutes: 90),
    _inter('e3', 'outing', 5, minutes: 180),
  ],
  'papa': [
    _inter('p1', 'call', 21, minutes: 25),
    _inter('p2', 'meal', 28, minutes: 120),
  ],
  'thomas': [_inter('t1', 'outing', 76, minutes: 180)],
  'maman': [_inter('m1', 'call', 1, minutes: 30)],
  'julie': [_inter('j1', 'outing', 6, minutes: 150)],
  'grandmaman': [_inter('g1', 'visit', 41, minutes: 120)],
};

/// Substitutions de providers pour le mode vitrine.
final demoOverrides = <Override>[
  relationshipsProvider.overrideWith((ref) => Stream.value(_relationships)),
  scoresProvider.overrideWith((ref) async => _scores),
  interactionsProvider.overrideWith(
    (ref, relId) async => _interactions[relId] ?? const [],
  ),
  relationshipProvider.overrideWith((ref, id) async {
    for (final rel in _relationships) {
      if (rel.id == id) return rel;
    }
    return null;
  }),
];
