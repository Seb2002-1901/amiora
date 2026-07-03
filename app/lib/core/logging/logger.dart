import 'dart:developer' as developer;

/// Journalisation minimale sans dépendance (architecture § 5).
///
/// RÈGLE ABSOLUE : aucun contenu utilisateur dans les journaux —
/// ni nom de proche, ni note, ni lieu, ni photo. On journalise des
/// identifiants techniques et des états, jamais des données.
final class Log {
  const Log._();

  static void debug(String message) => _log(message, level: 500);
  static void info(String message) => _log(message, level: 800);
  static void warning(String message) => _log(message, level: 900);

  static void error(String message, [Object? error, StackTrace? stackTrace]) =>
      _log(message, level: 1000, error: error, stackTrace: stackTrace);

  static void _log(
    String message, {
    required int level,
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: 'amiora',
      level: level,
      error: error,
      stackTrace: stackTrace,
    );
    // TODO(Phase 1): relayer level >= 1000 vers Sentry (sans contenu).
  }
}
