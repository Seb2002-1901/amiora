import 'package:flutter/widgets.dart';

/// Classes de taille Material 3 (design system § 9.1).
enum SizeClass { compact, medium, expanded }

/// Points de rupture normatifs (en dp logiques).
abstract final class Breakpoints {
  static const double medium = 600;
  static const double expanded = 840;

  /// Largeur maximale du contenu en medium/expanded (design system § 9.1).
  static const double maxContentWidth = 600;

  /// Gouttières horizontales minimales (design system § 9.2).
  static const double gutterCompact = 16;
  static const double gutterWide = 24;
}

extension SizeClassX on BuildContext {
  SizeClass get sizeClass {
    final width = MediaQuery.sizeOf(this).width;
    if (width >= Breakpoints.expanded) return SizeClass.expanded;
    if (width >= Breakpoints.medium) return SizeClass.medium;
    return SizeClass.compact;
  }

  double get gutter => sizeClass == SizeClass.compact
      ? Breakpoints.gutterCompact
      : Breakpoints.gutterWide;
}

/// Gabarits de test officiels (design system § 9.3) — utilisés par les
/// tests widget : chaque écran doit passer sur les six sans débordement.
abstract final class TestDevices {
  static const Size iphoneSe = Size(375, 667);
  static const Size iphoneStandard = Size(393, 852);
  static const Size galaxyStandard = Size(360, 780);
  static const Size iphoneProMax = Size(430, 932);
  static const Size galaxyUltra = Size(412, 915);
  static const Size ipad = Size(834, 1194);

  static const List<Size> all = [
    iphoneSe,
    iphoneStandard,
    galaxyStandard,
    iphoneProMax,
    galaxyUltra,
    ipad,
  ];
}
