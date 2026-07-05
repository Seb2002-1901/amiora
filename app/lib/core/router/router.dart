import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/remote/supabase_service.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/signup_screen.dart';
import '../../features/calendar/presentation/calendar_screen.dart';
import '../../features/common/access.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/in_memoriam/presentation/in_memoriam_screen.dart';
import '../../features/interactions/presentation/add_interaction_sheet.dart';
import '../../features/memories/presentation/memories_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/paywall/presentation/paywall_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/promises/presentation/promises_screen.dart';
import '../../features/relationships/presentation/add_relationship_screen.dart';
import '../../features/relationships/presentation/relationship_detail_screen.dart';
import '../../features/relationships/presentation/relationships_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/statistics/presentation/statistics_screen.dart';
import '../layout/adaptive_scaffold.dart';
import '../layout/breakpoints.dart';
import '../navigation/tap_guard.dart';
import '../theme/tokens.dart';

/// Table des routes (PRD V1.2 — 17 écrans).
/// Quatre branches persistantes + « + » central modal.
final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  refreshListenable: _AuthRefresh(),
  // Mode connecté (Supabase configuré) : session exigée hors écrans
  // d'entrée. Mode local : aucune redirection.
  redirect: (context, state) {
    if (!SupabaseService.isConfigured) return null;
    const open = {'/splash', '/onboarding', '/login', '/signup'};
    final loggedIn = SupabaseService.session != null;
    final location = state.matchedLocation;
    if (!loggedIn && !open.contains(location)) return '/login';
    if (loggedIn && (location == '/login' || location == '/signup')) {
      return '/home';
    }
    return null;
  },
  // Deep link inconnu (dont ch.amiora.app://login-callback reçu app
  // ouverte) : écran doux aux couleurs du thème, jamais l'erreur anglaise
  // de go_router.
  errorBuilder: (_, __) => const _NotFoundScreen(),
  routes: [
    // Racine (deep link « / ») : renvoie vers l'accueil.
    GoRoute(path: '/', redirect: (_, __) => '/home'),
    GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
    GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (_, __) => const SignupScreen()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          _AppShell(shell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
        ],),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/relationships',
            builder: (_, __) => const RelationshipsScreen(),
            routes: [
              GoRoute(
                path: 'add',
                builder: (_, __) => const AddRelationshipScreen(),
              ),
              GoRoute(
                path: ':id',
                builder: (_, state) =>
                    RelationshipDetailScreen(id: state.pathParameters['id']!),
              ),
            ],
          ),
        ],),
        StatefulShellBranch(routes: [
          GoRoute(path: '/memories', builder: (_, __) => const MemoriesScreen()),
        ],),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/profile',
            builder: (_, __) => const ProfileScreen(),
            routes: [
              GoRoute(
                path: 'settings',
                builder: (_, __) => const SettingsScreen(),
              ),
              GoRoute(
                path: 'statistics',
                builder: (_, __) => const StatisticsScreen(),
              ),
            ],
          ),
        ],),
      ],
    ),
    GoRoute(path: '/calendar', builder: (_, __) => const CalendarScreen()),
    GoRoute(path: '/promises', builder: (_, __) => const PromisesScreen()),
    GoRoute(path: '/paywall', builder: (_, __) => const PaywallScreen()),
    GoRoute(
      path: '/in-memoriam/:id',
      builder: (_, state) =>
          InMemoriamScreen(id: state.pathParameters['id']),
    ),
  ],
  // TODO(Phase 1): redirect selon l'état d'authentification Supabase
  // (session absente → /onboarding ; session présente → /home).
);

/// Rafraîchit le routeur quand l'état d'authentification change.
class _AuthRefresh extends ChangeNotifier {
  _AuthRefresh() {
    if (SupabaseService.isConfigured) {
      _sub = SupabaseService.client.auth.onAuthStateChange
          .listen((_) => notifyListeners());
    }
  }

  StreamSubscription<dynamic>? _sub;

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

/// Écran « Page introuvable » : sortie douce pour toute route inconnue.
class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.gutter * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.explore_off_outlined,
                size: 64,
                color: AmioraColors.gold,
              ),
              const SizedBox(height: AmioraSpacing.x5),
              Text(
                'Page introuvable',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AmioraSpacing.x2),
              Text(
                'Ce lien ne mène nulle part — tes relations, elles, '
                'sont toujours là.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AmioraColors.text2),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AmioraSpacing.x6),
              FilledButton(
                onPressed: () => context.go('/home'),
                child: const Text("Retour à l'accueil"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppShell extends ConsumerWidget {
  const _AppShell({required this.shell});

  final StatefulNavigationShell shell;

  static const _destinations = [
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdaptiveScaffold(
      body: shell,
      selectedIndex: shell.currentIndex,
      destinations: _destinations,
      onDestinationSelected: (index) => shell.goBranch(
        index,
        initialLocation: index == shell.currentIndex,
      ),
      onCreatePressed: () {
        if (!TapGuard.allow()) return;
        if (ensureWritable(context, ref)) AddInteractionSheet.show(context);
      },
    );
  }
}
