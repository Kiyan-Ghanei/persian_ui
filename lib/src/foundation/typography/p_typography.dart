import 'package:flutter/material.dart';

/// Typography design tokens used throughout PersianUI.
///
/// The typography system provides a consistent set of text sizes and
/// font weights that can be reused across components.
abstract final class PTypography {
  PTypography._();

  // ---------------------------------------------------------------------------
  // Font Sizes
  // ---------------------------------------------------------------------------

  /// Extra-small text.
  static const double fontSizeXs = 12.0;

  /// Small text.
  static const double fontSizeSm = 14.0;

  /// Medium/default text.
  static const double fontSizeMd = 16.0;

  /// Large text.
  static const double fontSizeLg = 18.0;

  /// Extra-large text.
  static const double fontSizeXl = 20.0;

  /// Extra-extra-large text.
  static const double fontSizeXxl = 24.0;

  /// Large display text.
  static const double fontSizeDisplay = 32.0;

  // ---------------------------------------------------------------------------
  // Font Weights
  // ---------------------------------------------------------------------------

  /// Regular font weight.
  static const FontWeight regular = FontWeight.w400;

  /// Medium font weight.
  static const FontWeight medium = FontWeight.w500;

  /// Semi-bold font weight.
  static const FontWeight semiBold = FontWeight.w600;

  /// Bold font weight.
  static const FontWeight bold = FontWeight.w700;
}