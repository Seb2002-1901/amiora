// Tests de fumée : l'application démarre, le splash s'affiche, le parcours
// splash → accueil fonctionne, et la coquille adaptative passe les six
// gabarits officiels sans débordement (un RenderFlex overflow fait échouer
// le test automatiquement).
import 'package:amiora/app.dart';
import 'package:amiora/core/layout/adaptive_scaffold.dart';
import 'package:amiora/core/layout/breakpoints.dart';
import 'package:amiora/core/theme/theme.dart';
import 'package:amiora/data/app_providers.dart';
import 'package:amiora/data/local/database.dart';
import 'package:amiora/data/subscription/subscription_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Splash → accueil : l’état vide du premier jour s’affiche',
      (tester) async {
    // Les flux de la base sont substitués ici : le parcours complet sur
    // base SQLite réelle est couvert par core_gesture_test.dart.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          relationshipsProvider.overrideWith(
            (ref) => Stream.value(const <Relationship>[]),
          ),
          scoresProvider.overrideWith((ref) async => const {}),
        ],
        child: const AmioraApp(),
      ),
    );
    expect(find.text('AMIORA'), findsOneWidget);
    expect(
      find.text('Prends soin des personnes qui comptent.'),
      findsOneWidget,
    );
    // Redirection différée du splash vers l'accueil.
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 400));
    expect(
      find.text('Commence par ajouter une personne qui compte pour toi'),
      findsOneWidget,
    );
  });

  testWidgets(
      'Lecture seule : le CTA de l’accueil est gardé par ensureWritable',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          relationshipsProvider.overrideWith(
            (ref) => Stream.value(const <Relationship>[]),
          ),
          scoresProvider.overrideWith((ref) async => const {}),
          accessStateProvider.overrideWith(
            (ref) => Stream.value(AccessState.readOnly),
          ),
        ],
        child: const AmioraApp(),
      ),
    );
    // Redirection différée du splash vers l'accueil.
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 400));

    // L'état d'accès est chargé (comme au démarrage réel) avant le tap :
    // le garde lit sa valeur, pas un état de chargement.
    final container = ProviderScope.containerOf(
      tester.element(find.byType(AmioraApp)),
      listen: false,
    );
    await container.read(accessStateProvider.future);

    // Tap sur le CTA : le garde d'écriture bloque, pas d'écran d'ajout.
    await tester.tap(find.text('Ajouter une personne'));
    await tester.pump();
    expect(find.text('Ajouter une relation'), findsNothing);
    // Comportement d'ensureWritable : snackbar douce + action « Réactiver »
    // (rendue par chaque Scaffold imbriqué, d'où findsWidgets).
    expect(
      find.text(
        'Ton abonnement a expiré — tes souvenirs restent à toi. '
        'Réactive AMIORA pour continuer à créer.',
      ),
      findsWidgets,
    );

    // L'action « Réactiver » mène au paywall.
    await tester.pumpAndSettle();
    await tester.tap(find.text('Réactiver').last);
    await tester.pumpAndSettle();
    expect(find.text('Continue de prendre soin'), findsOneWidget);
  });

  testWidgets('La coquille adaptative passe les 6 gabarits sans débordement',
      (tester) async {
    const destinations = [
      ShellDestination(
        icon: Icons.home_outlined,
        selectedIcon: Icons.home,
        label: 'Accueil',
      ),
      ShellDestination(
        icon: Icons.favorite_outline,
        selectedIcon: Icons.favorite,
        label: 'Relations',
      ),
      ShellDestination(
        icon: Icons.photo_outlined,
        selectedIcon: Icons.photo,
        label: 'Souvenirs',
      ),
      ShellDestination(
        icon: Icons.person_outline,
        selectedIcon: Icons.person,
        label: 'Profil',
      ),
    ];
    for (final size in TestDevices.all) {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        MaterialApp(
          theme: buildAmioraTheme(),
          home: AdaptiveScaffold(
            body: ListView(
              children: List.generate(
                20,
                (i) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Élément de démonstration $i — '
                    'texte volontairement long pour vérifier l’ellipse',
                  ),
                ),
              ),
            ),
            selectedIndex: 0,
            destinations: destinations,
            onDestinationSelected: (_) {},
            onCreatePressed: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.byType(AdaptiveScaffold),
        findsOneWidget,
        reason: 'Gabarit ${size.width.toInt()}×${size.height.toInt()}',
      );
      // Tablette : rail à gauche ; téléphone : « + » central en bas.
      if (size.width >= Breakpoints.expanded) {
        expect(find.byType(NavigationRail), findsOneWidget);
      } else {
        expect(find.byIcon(Icons.add), findsOneWidget);
      }
    }
  });
}
