import 'dart:async' show StreamSubscription;
import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../data/remote/supabase_service.dart';
import '../logging/logger.dart';

/// Notifications push (moteur serveur : supabase/functions/daily-notifications,
/// plafonds 2/jour et 6/semaine, heures silencieuses 22 h-8 h, priorités).
///
/// Gardé par configuration : activé par --dart-define=AMIORA_FCM=true,
/// qui suppose les fichiers Firebase en place (google-services.json /
/// GoogleService-Info.plist — voir app/README.md). Sans cela : inactif.
///
/// La demande de permission suit l'opt-in progressif (chapitre 08) :
/// jamais au premier lancement — après la première valeur, via un
/// pré-écran interne, puis [requestPermissionAndRegister].
abstract final class PushService {
  static const bool enabled = bool.fromEnvironment('AMIORA_FCM');

  static bool get isConfigured => enabled && !kIsWeb;

  static bool _initialized = false;

  /// Abonnement unique au renouvellement de jeton : jamais empilé.
  static StreamSubscription<String>? _tokenRefreshSub;

  static Future<void> initIfConfigured() async {
    if (!isConfigured || _initialized) return;
    await Firebase.initializeApp();
    _initialized = true;
    FirebaseMessaging.onMessage.listen((message) {
      // Affichage en avant-plan : bandeau in-app discret (Phase 4 UI).
      Log.info('push_received_foreground kind=${message.data['kind'] ?? '?'}');
    });
    Log.info('fcm_initialized');
  }

  /// À appeler UNIQUEMENT après le pré-écran d'opt-in accepté.
  static Future<bool> requestPermissionAndRegister() async {
    if (!isConfigured || !_initialized) return false;
    final settings = await FirebaseMessaging.instance.requestPermission();
    final granted =
        settings.authorizationStatus == AuthorizationStatus.authorized ||
            settings.authorizationStatus == AuthorizationStatus.provisional;
    Log.info('push_permission granted=$granted');
    if (!granted) return false;
    await _registerToken();
    _tokenRefreshSub ??=
        FirebaseMessaging.instance.onTokenRefresh.listen((_) async {
      try {
        await _registerToken();
      } on Exception catch (e) {
        Log.warning('push_token_refresh_failed error=$e');
      }
    });
    return true;
  }

  /// Enregistre le jeton dans `devices` (lu par le moteur serveur).
  static Future<void> _registerToken() async {
    final userId = SupabaseService.userId;
    if (userId == null) return;
    final token = await FirebaseMessaging.instance.getToken();
    if (token == null) return;
    await SupabaseService.client.from('devices').upsert(
      {
        'id': const Uuid().v5(
          Namespace.url.value,
          'https://amiora.ch/device/$userId/${Platform.operatingSystem}',
        ),
        'user_id': userId,
        'platform': Platform.isIOS ? 'ios' : 'android',
        'push_token': token,
      },
    );
    Log.info('push_token_registered');
  }
}
