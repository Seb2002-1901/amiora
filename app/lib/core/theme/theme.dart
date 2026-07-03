import 'package:flutter/material.dart';

import 'tokens.dart';

/// Thème sombre unique de la V1 (design system § 1) — construit
/// exclusivement sur les tokens, jamais sur des valeurs locales.
ThemeData buildAmioraTheme() {
  const scheme = ColorScheme.dark(
    surface: AmioraColors.bg,
    surfaceContainer: AmioraColors.surface,
    surfaceContainerHigh: AmioraColors.surfaceRaised,
    primary: AmioraColors.gold,
    onPrimary: AmioraColors.onGold,
    secondary: AmioraColors.gold,
    onSecondary: AmioraColors.onGold,
    error: AmioraColors.errorText,
    onError: AmioraColors.onGold,
    onSurface: AmioraColors.text,
    onSurfaceVariant: AmioraColors.text2,
    outline: AmioraColors.border,
  );

  // Échelle typographique du design system § 3.2 (Inter en Phase 1,
  // pile système en attendant l'embarquement de la police).
  const textTheme = TextTheme(
    displaySmall: TextStyle(fontSize: 32, height: 40 / 32, fontWeight: FontWeight.w700),
    titleLarge: TextStyle(fontSize: 24, height: 32 / 24, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 20, height: 28 / 20, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 16, height: 24 / 16, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14, height: 20 / 14, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 16, height: 24 / 16, fontWeight: FontWeight.w600),
    bodySmall: TextStyle(fontSize: 12, height: 16 / 12, fontWeight: FontWeight.w400),
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: scheme,
    scaffoldBackgroundColor: AmioraColors.bg,
    textTheme: textTheme.apply(
      bodyColor: AmioraColors.text,
      displayColor: AmioraColors.text,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AmioraColors.bg,
      foregroundColor: AmioraColors.text,
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardTheme(
      color: AmioraColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AmioraRadii.card),
        side: const BorderSide(color: AmioraColors.border),
      ),
      margin: EdgeInsets.zero,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AmioraColors.gold,
        foregroundColor: AmioraColors.onGold,
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AmioraRadii.button),
        ),
        textStyle: textTheme.labelLarge,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AmioraColors.text,
        side: const BorderSide(color: AmioraColors.border),
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AmioraRadii.button),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AmioraColors.gold),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AmioraColors.surface,
      hintStyle: const TextStyle(color: AmioraColors.text3),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AmioraSpacing.x4,
        vertical: AmioraSpacing.x4,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AmioraRadii.field),
        borderSide: const BorderSide(color: AmioraColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AmioraRadii.field),
        borderSide: const BorderSide(color: AmioraColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AmioraRadii.field),
        borderSide: const BorderSide(color: AmioraColors.gold, width: 1.5),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AmioraColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AmioraRadii.card)),
      ),
      showDragHandle: true,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AmioraColors.surface,
      indicatorColor: AmioraColors.gold.withValues(alpha: 0.16),
      labelTextStyle: WidgetStatePropertyAll(
        textTheme.bodySmall!.copyWith(color: AmioraColors.text2),
      ),
    ),
    dividerTheme: const DividerThemeData(color: AmioraColors.border, thickness: 1),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AmioraColors.surfaceRaised,
      contentTextStyle: textTheme.bodyMedium!.copyWith(color: AmioraColors.text),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AmioraRadii.field),
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
