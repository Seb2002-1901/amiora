// Synchronisation (Phase 3) : la file outbox journalise chaque mutation
// dans l'ordre, et reste intacte en mode local (aucun backend configuré).
import 'dart:convert';

import 'package:amiora/data/local/database.dart';
import 'package:amiora/data/sync/sync_service.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AmioraDatabase db;

  setUp(() => db = AmioraDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  test('Chaque mutation est journalisée dans la file, dans l’ordre', () async {
    await db.insertRelationship(
      RelationshipsCompanion.insert(
        id: 'papa',
        firstName: 'Papa',
        category: 'family',
        cadenceDays: 7,
        createdAt: DateTime(2026, 1, 1),
      ),
    );
    await db.insertInteraction(
      InteractionsCompanion.insert(
        id: 'i1',
        type: 'call',
        occurredAt: DateTime(2026, 7, 3),
      ),
      ['papa'],
    );
    await db.insertMemory(
      MemoriesCompanion.insert(
        id: 'm1',
        type: 'note',
        body: const Value('Souvenir'),
        createdAt: DateTime(2026, 7, 3),
      ),
      ['papa'],
    );
    await db.insertPromise(
      PromisesCompanion.insert(
        id: 'pr1',
        relationshipId: 'papa',
        title: 'Rappeler dimanche',
      ),
    );
    await db.setPromiseStatus('pr1', 'done');
    await db.setRelationshipStatus('papa', 'archived');

    final outbox = await db.select(db.outbox).get();
    expect(
      [for (final o in outbox) '${o.entity}:${o.op}'],
      [
        'relationships:create',
        'interactions:create',
        'memories:create',
        'promises:create',
        'promises:update',
        'relationships:update',
      ],
    );
    // L'ordre de rejeu est garanti par la séquence monotone.
    expect(
      [for (final o in outbox) o.seq],
      List.generate(outbox.length, (i) => outbox.first.seq + i),
    );
  });

  test('En mode local, la synchronisation est un no-op qui préserve la file',
      () async {
    await db.insertRelationship(
      RelationshipsCompanion.insert(
        id: 'emma',
        firstName: 'Emma',
        category: 'partner',
        cadenceDays: 2,
        createdAt: DateTime(2026, 1, 1),
      ),
    );
    final service = SyncService(db);
    final report = await service.synchronize();
    expect(report.pushed, 0);
    expect(report.pulled, 0);
    expect(await db.select(db.outbox).get(), hasLength(1));
  });

  test('Identifiant de liaison : stable et déterministe (UUID v5)', () {
    final a = stableLinkId('interaction-1', 'papa');
    final b = stableLinkId('interaction-1', 'papa');
    final c = stableLinkId('interaction-1', 'maman');
    expect(a, b);
    expect(a, isNot(c));
    expect(a, matches(RegExp(r'^[0-9a-f-]{36}$')));
  });

  test('restore() écrit un curseur au même format que le tirage (jsonEncode)',
      () async {
    await SyncService(db).restore();
    final raw = await db.settingValue('sync_last_pulled_at');
    expect(raw, isNotNull);
    // Le tirage relit le curseur via jsonDecode : le format doit coïncider.
    final decoded = jsonDecode(raw!) as String;
    expect(DateTime.parse(decoded), DateTime.utc(1970));
  });

  test('La charge utile d’un souvenir pousse created_at (chronologie)',
      () async {
    await db.insertMemory(
      MemoriesCompanion.insert(
        id: 'm1',
        type: 'note',
        body: const Value('Souvenir'),
        createdAt: DateTime.utc(2026, 7, 3),
      ),
      const [],
    );
    final row = await (db.select(db.memories)
          ..where((m) => m.id.equals('m1')))
        .getSingle();
    final payload = SyncService(db).debugMapMemory(row, const []);
    expect(
      payload['created_at'],
      DateTime.utc(2026, 7, 3).toIso8601String(),
    );
  });

  test('Une entité outbox inconnue lève une erreur franche (StateError)',
      () async {
    await db.journalMutation('inconnue', 'x-1', 'create');
    final op = await db.select(db.outbox).getSingle();
    await expectLater(
      SyncService(db).debugPushOne(op),
      throwsStateError,
    );
  });
}
