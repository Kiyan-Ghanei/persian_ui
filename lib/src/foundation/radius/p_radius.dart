/// Border radius design tokens used throughout PersianUI.
///
/// The radius system provides consistent corner shapes across components.
abstract final class PRadius {
  PRadius._();

  // ---------------------------------------------------------------------------
  // Base
  // ---------------------------------------------------------------------------

  /// No rounded corners.
  static const double none = 0.0;

  /// Small corner radius.
  static const double sm = 4.0;

  /// Medium corner radius.
  static const double md = 8.0;

  /// Large corner radius.
  static const double lg = 12.0;

  /// Extra-large corner radius.
  static const double xl = 16.0;

  /// Extra-extra-large corner radius.
  static const double xxl = 24.0;

  /// Fully rounded shape.
  ///
  /// This value is intended for components such as pills, chips, and badges.
  static const double full = 999.0;
}