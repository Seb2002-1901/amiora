import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/notifications/push_service.dart';
import 'data/remote/supabase_service.dart';
import 'data/subscription/subscription_service.dart';
import 'demo/demo_overrides.dart';

/// Environnement d'exécution, injecté à la compilation :
/// flutter run --dart-define=AMIORA_ENV=dev|staging|prod
const String amioraEnv = String.fromEnvironment('AMIORA_ENV', defaultValue: 'dev');

/// Mode vitrine : jeu de données canonique, aucune écriture réelle
/// (captures stores, vérifications responsive sur navigateur).
const bool amioraDemo = bool.fromEnvironment('AMIORA_DEMO');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Services gardés par configuration : sans clé, mode local intégral.
  await SupabaseService.initIfConfigured();
  await PushService.initIfConfigured();
  await SubscriptionService.initIfConfigured(
    appUserId: SupabaseService.userId,
  );
  // TODO(bêta) : Sentry (SENTRY_DSN) une fois le DSN fourni.
  runApp(
    ProviderScope(
      overrides: amioraDemo ? demoOverrides : const [],
      child: const AmioraApp(),
    ),
  );
}
