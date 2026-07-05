import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/presence/presence_score.dart';
import 'local/connection/connection.dart';
import 'local/database.dart';
import 'presence_repository.dart';

/// Base locale unique de l'application (offline-first).
final databaseProvider = Provider<AmioraDatabase>((ref) {
  final db = AmioraDatabase(openAmioraConnection());
  ref.onDispose(db.close);
  return db;
});

final presenceRepositoryProvider = Provider<PresenceRepository>(
  (ref) => PresenceRepository(ref.watch(databaseProvider)),
);

/// Incrémenté après chaque mutation : déclenche les recalculs dérivés.
final dbTickProvider = StateProvider<int>((_) => 0);

/// Relations actives, en continu.
final relationshipsProvider = StreamProvider<List<Relationship>>(
  (ref) => ref.watch(databaseProvider).watchActiveRelationships(),
);

/// Indices de présence de toutes les relations actives
/// (recalcul événementiel : dépend du flux ET du tick de mutation).
final scoresProvider = FutureProvider<Map<String, PresenceResult>>((ref) async {
  ref.watch(dbTickProvider);
  await ref.watch(relationshipsProvider.future);
  return ref.watch(presenceRepositoryProvider).computeAll(DateTime.now());
});

/// Interactions d'une relation (plus récentes d'abord).
/// autoDispose : pas de rétention par identifiant visité.
final interactionsProvider =
    FutureProvider.autoDispose.family<List<Interaction>, String>((ref, relId) {
  ref.watch(dbTickProvider);
  return ref.watch(databaseProvider).interactionsForRelationship(relId);
});

final relationshipProvider =
    FutureProvider.autoDispose.family<Relationship?, String>((ref, id) {
  ref.watch(dbTickProvider);
  return ref.watch(databaseProvider).relationshipById(id);
});

/// Souvenirs (tous, plus récents d'abord).
final memoriesProvider = StreamProvider<List<Memory>>(
  (ref) => ref.watch(databaseProvider).watchMemories(),
);

/// Promesses (tous statuts, tri par échéance).
final promisesProvider = StreamProvider<List<Promise>>(
  (ref) => ref.watch(databaseProvider).watchPromises(),
);

/// Relations « En mémoire ».
final inMemoriamProvider = StreamProvider<List<Relationship>>(
  (ref) => ref.watch(databaseProvider).watchInMemoriam(),
);

/// Statistiques de l'année en cours (calcul dérivé — jamais stocké).
final yearStatsProvider =
    FutureProvider<({Map<String, int> byType, int minutes, int memories})>(
        (ref) async {
  ref.watch(dbTickProvider);
  final db = ref.watch(databaseProvider);
  final from = DateTime(DateTime.now().year);
  final (byType, minutes) = await db.interactionStatsSince(from);
  final memories = await db.memoriesCountSince(from);
  return (byType: byType, minutes: minutes, memories: memories);
});

/// Réglage booléen persisté (notifications, biométrie, analytics…).
/// autoDispose : pas de rétention par clé visitée.
final boolSettingProvider =
    FutureProvider.autoDispose.family<bool, (String, bool)>((ref, arg) async {
  ref.watch(dbTickProvider);
  final (key, defaultValue) = arg;
  final raw = await ref.watch(databaseProvider).settingValue(key);
  return raw == null ? defaultValue : raw == 'true';
});
