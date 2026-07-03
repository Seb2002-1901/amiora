/// Hiérarchie d'exceptions applicatives (architecture § 5).
/// Les messages sont techniques et ne contiennent JAMAIS de contenu
/// utilisateur (nom d'un proche, note, lieu…).
sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// Échec réseau (requête Supabase, upload média).
final class NetworkException extends AppException {
  const NetworkException(super.message);
}

/// Échec de synchronisation (conflit, mutation rejetée).
final class SyncException extends AppException {
  const SyncException(super.message);
}

/// Quota atteint (stockage média).
final class QuotaException extends AppException {
  const QuotaException(super.message);
}

/// Problème d'abonnement (expiré → lecture seule, achat échoué).
final class SubscriptionException extends AppException {
  const SubscriptionException(super.message);
}
