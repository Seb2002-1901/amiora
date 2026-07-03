// Harnais de vérification contre le VRAI backend (Phases 2-3 du mandat).
//
// Ignoré tant que les clés publiques ne sont pas fournies. Dès qu'elles
// existent :
//
//   flutter test test/e2e/live_backend_test.dart \
//     --dart-define=SUPABASE_URL=https://xxxx.supabase.co \
//     --dart-define=SUPABASE_ANON_KEY=eyJ...
//
// Prérequis côté projet Supabase DEV (jamais la production) :
//   - migrations jouées (`supabase db push`) ;
//   - fournisseur e-mail activé avec « Confirm email » DÉSACTIVÉ
//     (projet de test uniquement) ;
//   - fonction `account-deletion` déployée pour le dernier scénario
//     (sinon il est ignoré proprement).
//
// Les comptes créés sont jetables (adresse aléatoire) ; la purge serveur
// à J+30 fait le ménage après `account-deletion`.
import 'package:amiora/data/local/database.dart';
import 'package:amiora/data/remote/supabase_service.dart';
import 'package:amiora/data/sync/sync_service.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

void main() {
  const skip = SupabaseService.isConfigured
      ? false
      : 'SUPABASE_URL / SUPABASE_ANON_KEY non fournis — harnais en attente '
          'des clés publiques.';

  final email = 'beta.${const Uuid().v4()}@exemple-amiora.ch';
  const password = 'MotDePasseBeta2026!';

  group('Backend réel — authentification et synchronisation', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      await SupabaseService.initIfConfigured();
    });

    test('Nouvel utilisateur : inscription puis connexion e-mail', () async {
      final auth = SupabaseService.client.auth;
      await auth.signUp(email: email, password: password);
      if (auth.currentSession == null) {
        await auth.signInWithPassword(email: email, password: password);
      }
      expect(SupabaseService.userId, isNotNull);
    });

    test(
        'Appareil A : créations locales → poussée complète '
        '(relation, interaction, souvenir, promesse)', () async {
      final deviceA = AmioraDatabase(NativeDatabase.memory());
      addTearDown(deviceA.close);
      final sync = SyncService(deviceA);

      await deviceA.insertRelationship(
        RelationshipsCompanion.insert(
          id: const Uuid().v4(),
          firstName: 'Papa',
          category: 'family',
          cadenceDays: 7,
          createdAt: DateTime.now(),
        ),
      );
      final rel =
          (await deviceA.watchActiveRelationships().first).single;
      await deviceA.insertInteraction(
        InteractionsCompanion.insert(
          id: const Uuid().v4(),
          type: 'call',
          occurredAt: DateTime.now(),
          durationMinutes: const Value(20),
        ),
        [rel.id],
      );
      await deviceA.insertMemory(
        MemoriesCompanion.insert(
          id: const Uuid().v4(),
          type: 'note',
          body: const Value('Souvenir de test bout-en-bout'),
          createdAt: DateTime.now(),
        ),
        [rel.id],
      );
      await deviceA.insertPromise(
        PromisesCompanion.insert(
          id: const Uuid().v4(),
          relationshipId: rel.id,
          title: 'Rappeler dimanche',
        ),
      );

      // Hors ligne → en ligne : tout part d'un coup, dans l'ordre.
      final report = await sync.synchronize();
      expect(report.pushed, 4);
      expect(await deviceA.select(deviceA.outbox).get(), isEmpty,
          reason: 'La file doit être vide après une poussée réussie.');
    });

    test('Nouvel appareil : restauration complète depuis le serveur',
        () async {
      final deviceB = AmioraDatabase(NativeDatabase.memory());
      addTearDown(deviceB.close);
      await SyncService(deviceB).restore();

      final rels = await deviceB.watchActiveRelationships().first;
      expect(rels, hasLength(1), reason: 'La relation doit être restaurée.');
      expect(rels.single.firstName, 'Papa');
      expect(
        await deviceB.interactionsForRelationship(rels.single.id),
        hasLength(1),
        reason: 'Interaction et participants doivent être restaurés.',
      );
      expect(
        await deviceB.memoriesForRelationship(rels.single.id),
        hasLength(1),
        reason: 'Souvenir et liaisons doivent être restaurés.',
      );
      expect(
        await deviceB.promisesForRelationship(rels.single.id),
        hasLength(1),
      );
    });

    test(
        'Deux appareils : modification sur B, dernière écriture gagne sur A',
        () async {
      final deviceA = AmioraDatabase(NativeDatabase.memory());
      final deviceB = AmioraDatabase(NativeDatabase.memory());
      addTearDown(deviceA.close);
      addTearDown(deviceB.close);
      await SyncService(deviceA).restore();
      await SyncService(deviceB).restore();

      final relB = (await deviceB.watchActiveRelationships().first).single;
      await deviceB.setRelationshipStatus(relB.id, 'archived');
      await SyncService(deviceB).synchronize();

      await SyncService(deviceA).synchronize();
      expect(
        await deviceA.watchActiveRelationships().first,
        isEmpty,
        reason: "L'archivage fait sur B doit gagner sur A (LWW serveur).",
      );
    });

    test('Déconnexion puis restauration de session par reconnexion',
        () async {
      final auth = SupabaseService.client.auth;
      await auth.signOut();
      expect(SupabaseService.session, isNull);
      await auth.signInWithPassword(email: email, password: password);
      expect(SupabaseService.session, isNotNull);
    });

    test('Réinitialisation de mot de passe : demande acceptée', () async {
      // Vérifie l'appel (l'e-mail réel n'est pas relevable en test).
      await SupabaseService.client.auth.resetPasswordForEmail(email);
    });

    test(
        'Suppression de compte : marquage + déconnexion '
        '(grâce 30 jours, purge serveur)', () async {
      try {
        await SupabaseService.client.functions.invoke('account-deletion');
      } on Exception {
        markTestSkipped(
          'Fonction account-deletion non déployée sur ce projet — '
          'scénario à rejouer après `supabase functions deploy`.',
        );
        return;
      }
      await SupabaseService.client.auth.signOut();
      expect(SupabaseService.session, isNull);
    });
  }, skip: skip);
}
