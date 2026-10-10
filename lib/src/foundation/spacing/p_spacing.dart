/// Spacing design tokens used throughout PersianUI.
///
/// The spacing system provides a consistent set of values that can be
/// reused across components instead of using arbitrary numbers.
abstract final class PSpacing {
  PSpacing._();

  // ---------------------------------------------------------------------------
  // Base
  // ---------------------------------------------------------------------------

  /// No spacing.
  static const double none = 0.0;

  /// Extra-extra-small spacing.
  static const double xxs = 2.0;

  /// Extra-small spacing.
  static const double xs = 4.0;

  /// Small spacing.
  static const double sm = 8.0;

  /// Medium spacing.
  static const double md = 12.0;

  /// Large spacing.
  static const double lg = 16.0;

  /// Extra-large spacing.
  static const double xl = 24.0;

  /// Extra-extra-large spacing.
  static const double xxl = 32.0;

  /// Huge spacing.
  static const double xxxl = 48.0;
}