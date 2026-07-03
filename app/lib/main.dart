import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'demo/demo_overrides.dart';

/// Environnement d'exécution, injecté à la compilation :
/// flutter run --dart-define=AMIORA_ENV=dev|staging|prod
const String amioraEnv = String.fromEnvironment('AMIORA_ENV', defaultValue: 'dev');

/// Mode vitrine : jeu de données canonique, aucune écriture réelle
/// (captures stores, vérifications responsive sur navigateur).
const bool amioraDemo = bool.fromEnvironment('AMIORA_DEMO');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO(Phase 1): initialiser Supabase (SUPABASE_URL / SUPABASE_ANON_KEY),
  // Firebase Messaging, RevenueCat et Sentry selon amioraEnv — le squelette
  // démarre sans clé pour rester exécutable dès le premier build.
  runApp(
    ProviderScope(
      overrides: amioraDemo ? demoOverrides : const [],
      child: const AmioraApp(),
    ),
  );
}
