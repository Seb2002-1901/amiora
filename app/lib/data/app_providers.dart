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
final interactionsProvider =
    FutureProvider.family<List<Interaction>, String>((ref, relId) {
  ref.watch(dbTickProvider);
  return ref.watch(databaseProvider).interactionsForRelationship(relId);
});

final relationshipProvider =
    FutureProvider.family<Relationship?, String>((ref, id) {
  ref.watch(dbTickProvider);
  return ref.watch(databaseProvider).relationshipById(id);
});
