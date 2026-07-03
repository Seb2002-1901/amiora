import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

/// Environnement d'exécution, injecté à la compilation :
/// flutter run --dart-define=AMIORA_ENV=dev|staging|prod
const String amioraEnv = String.fromEnvironment('AMIORA_ENV', defaultValue: 'dev');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO(Phase 1): initialiser Supabase (SUPABASE_URL / SUPABASE_ANON_KEY),
  // Firebase Messaging, RevenueCat et Sentry selon amioraEnv — le squelette
  // démarre sans clé pour rester exécutable dès le premier build.
  runApp(const ProviderScope(child: AmioraApp()));
}
