import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/errors/app_exception.dart';
import '../../core/logging/logger.dart';
import 'supabase_service.dart';

/// Authentification (PRD V1.2 : Apple, Google, e-mail, mot de passe oublié,
/// déconnexion, suppression du compte). Inactif en mode local.
class AuthRepository {
  const AuthRepository();

  GoTrueClient get _auth => SupabaseService.client.auth;

  Future<void> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signUp(email: email, password: password);
      Log.info('auth_signup_email');
    } on AuthException catch (e) {
      throw NetworkException(_frenchAuthMessage(e));
    }
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithPassword(email: email, password: password);
      Log.info('auth_signin_email');
    } on AuthException catch (e) {
      throw NetworkException(_frenchAuthMessage(e));
    }
  }

  /// Apple / Google : flux OAuth natif de Supabase. Exige la configuration
  /// des fournisseurs côté projet et des URL de redirection (app/README.md).
  Future<void> signInWithProvider(OAuthProvider provider) async {
    try {
      await _auth.signInWithOAuth(
        provider,
        redirectTo: 'ch.amiora.app://login-callback',
      );
    } on AuthException catch (e) {
      throw NetworkException(_frenchAuthMessage(e));
    }
  }

  Future<void> sendPasswordReset(String email) async {
    try {
      await _auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw NetworkException(_frenchAuthMessage(e));
    }
  }

  Future<void> signOut() => _auth.signOut();

  /// Suppression de compte : marque le compte côté serveur (grâce de
  /// 30 jours, purge par `purge-deleted`) puis déconnecte localement.
  Future<void> requestAccountDeletion() async {
    await SupabaseService.client.functions.invoke('account-deletion');
    await _auth.signOut();
    Log.info('auth_account_deletion_requested');
  }

  String _frenchAuthMessage(AuthException e) => switch (e.statusCode) {
        '400' => 'E-mail ou mot de passe incorrect.',
        '422' => 'Adresse e-mail invalide ou mot de passe trop court.',
        '429' => 'Trop de tentatives — réessaie dans quelques minutes.',
        _ => 'La connexion a échoué. Réessaie dans un instant.',
      };
}

final authRepositoryProvider = Provider<AuthRepository>(
  (_) => const AuthRepository(),
);

/// Session courante (null : non connecté ou mode local).
final sessionProvider = StreamProvider<Session?>((ref) {
  if (!SupabaseService.isConfigured) return Stream.value(null);
  return SupabaseService.client.auth.onAuthStateChange
      .map((event) => event.session)
      .distinct((a, b) => a?.accessToken == b?.accessToken);
});

/// Vrai quand l'app exige une session (backend configuré) et qu'il n'y en
/// a pas — le routeur redirige alors vers /login.
final needsLoginProvider = Provider<bool>((ref) {
  if (!SupabaseService.isConfigured) return false;
  final session = ref.watch(sessionProvider).valueOrNull;
  return session == null;
});
