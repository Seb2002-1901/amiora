import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/logging/logger.dart';

/// Accès Supabase — entièrement gardé par configuration :
/// sans SUPABASE_URL / SUPABASE_ANON_KEY, l'application fonctionne en
/// mode local (aucune authentification exigée, aucune synchronisation).
///
///   flutter run --dart-define=SUPABASE_URL=https://xxxx.supabase.co \
///               --dart-define=SUPABASE_ANON_KEY=eyJ...
///
/// Seule la clé publique est acceptée ici (« publishable key », ou clé
/// anon héritée) — jamais de clé service.
abstract final class SupabaseService {
  static const String url = String.fromEnvironment('SUPABASE_URL');
  static const String anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  /// Vrai quand le backend est configuré (mode connecté).
  static const bool isConfigured = url != '' && anonKey != '';

  static bool _initialized = false;

  static Future<void> initIfConfigured() async {
    if (!isConfigured || _initialized) return;
    await Supabase.initialize(url: url, publishableKey: anonKey);
    _initialized = true;
    Log.info('supabase_initialized');
  }

  /// Client — à n'appeler que si [isConfigured].
  static SupabaseClient get client => Supabase.instance.client;

  static Session? get session =>
      isConfigured && _initialized ? client.auth.currentSession : null;

  static String? get userId => session?.user.id;
}
