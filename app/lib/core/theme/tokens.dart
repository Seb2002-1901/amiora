import 'dart:ui';

/// Tokens du design system AMIORA (Sprint 0 — livrable 3).
/// Référence unique : docs/sprint-0/03-design-system.md.
abstract final class AmioraColors {
  static const Color bg = Color(0xFF0B0B0D);
  static const Color surface = Color(0xFF1A1A1E);
  static const Color surfaceRaised = Color(0xFF232329);
  static const Color border = Color(0xFF2E2E33);

  static const Color gold = Color(0xFFD9B45B);
  static const Color goldPressed = Color(0xFFB8963F);
  static const Color onGold = Color(0xFF1A1405);

  static const Color text = Color(0xFFF4F1E9);
  static const Color text2 = Color(0xFFA9A6A0);
  static const Color text3 = Color(0xFF6E6C68);

  static const Color success = Color(0xFF8BC49A);
  static const Color warning = Color(0xFFE0A45C);
  static const Color error = Color(0xFFC96A5E);

  /// Texte d'erreur sur surfaces (contraste ≥ 4,5:1 partout).
  static const Color errorText = Color(0xFFDE8478);

  static const Color overlay = Color(0x99000000); // rgba(0,0,0,0.6)
}

abstract final class AmioraRadii {
  static const double card = 24;
  static const double button = 16;
  static const double field = 12;
  static const double pill = 999;
}

/// Grille 4 pt — seules valeurs d'espacement autorisées.
abstract final class AmioraSpacing {
  static const double x1 = 4;
  static const double x2 = 8;
  static const double x3 = 12;
  static const double x4 = 16;
  static const double x5 = 20;
  static const double x6 = 24;
  static const double x8 = 32;
  static const double x10 = 40;
  static const double x12 = 48;
}

abstract final class AmioraDurations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration standard = Duration(milliseconds: 220);
  static const Duration expressive = Duration(milliseconds: 350);
}

/// Cible tactile minimale (design system § 8).
const double kMinTouchTarget = 44;
