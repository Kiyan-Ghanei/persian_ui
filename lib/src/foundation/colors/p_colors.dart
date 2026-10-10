import 'package:flutter/material.dart';

/// The color system used throughout PersianUI.
///
/// Colors are defined as semantic design tokens so that all components
/// can share the same visual language.
abstract final class PColors {
  PColors._();

  // ---------------------------------------------------------------------------
  // Brand
  // ---------------------------------------------------------------------------

  /// Main brand color.
  static const Color primary = Color(0xFF1976D2);

  /// Dark variant of the primary color.
  static const Color primaryDark = Color(0xFF1259A7);

  /// Light variant of the primary color.
  static const Color primaryLight = Color(0xFFE3F2FD);

  // ---------------------------------------------------------------------------
  // Semantic
  // ---------------------------------------------------------------------------

  /// Indicates a successful operation.
  static const Color success = Color(0xFF2E7D32);

  /// Indicates a warning or potentially risky operation.
  static const Color warning = Color(0xFFED6C02);

  /// Indicates an error or destructive operation.
  static const Color error = Color(0xFFD32F2F);

  /// Indicates informational content.
  static const Color info = Color(0xFF0288D1);

  // ---------------------------------------------------------------------------
  // Neutral
  // ---------------------------------------------------------------------------

  static const Color white = Color(0xFFFFFFFF);

  static const Color black = Color(0xFF000000);

  static const Color background = Color(0xFFF8F9FA);

  static const Color surface = Color(0xFFFFFFFF);

  static const Color surfaceVariant = Color(0xFFF1F3F5);

  static const Color border = Color(0xFFDEE2E6);

  static const Color divider = Color(0xFFE9ECEF);

  // ---------------------------------------------------------------------------
  // Text
  // ---------------------------------------------------------------------------

  static const Color textPrimary = Color(0xFF212529);

  static const Color textSecondary = Color(0xFF6C757D);

  static const Color textDisabled = Color(0xFFADB5BD);

  static const Color textOnPrimary = Color(0xFFFFFFFF);
}