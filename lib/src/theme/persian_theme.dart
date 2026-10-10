import 'package:flutter/material.dart';

import '../foundation/colors/p_colors.dart';

/// Theme system used by PersianUI.
///
/// Provides light and dark Material 3 themes based on PersianUI design tokens.
abstract final class PersianTheme {
  PersianTheme._();

  /// Creates the light theme for PersianUI.
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      colorScheme: ColorScheme.fromSeed(
        seedColor: PColors.primary,
        brightness: Brightness.light,
      ),

      scaffoldBackgroundColor: PColors.background,

      dividerColor: PColors.divider,

      cardColor: PColors.surface,

      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: PColors.surface,
      ),
    );
  }

  /// Creates the dark theme for PersianUI.
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      colorScheme: ColorScheme.fromSeed(
        seedColor: PColors.primary,
        brightness: Brightness.dark,
      ),
    );
  }
}