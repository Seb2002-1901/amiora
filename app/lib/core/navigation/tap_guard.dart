/// Garde anti double-tap : évite d'empiler deux fois le même écran ou la
/// même feuille quand l'utilisateur tape deux fois très vite.
abstract final class TapGuard {
  static const Duration _interval = Duration(milliseconds: 600);
  static DateTime? _last;

  /// Vrai si l'action peut se déclencher : refuse tout déclenchement à
  /// moins de 600 ms du précédent accepté.
  static bool allow() {
    final now = DateTime.now();
    if (_last != null && now.difference(_last!) < _interval) return false;
    _last = now;
    return true;
  }
}
