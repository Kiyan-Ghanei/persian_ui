import 'package:flutter/material.dart';

/// A reusable horizontal progress indicator for PersianUI.
///
/// [PProgress] provides a simple and consistent API around Flutter's
/// [LinearProgressIndicator].
///
/// The [value] must be between `0.0` and `1.0`.
///
/// The component focuses only on displaying progress and does not contain
/// progress calculation or business logic.
class PProgress extends StatelessWidget {
  /// Creates a horizontal progress indicator.
  const PProgress({
    super.key,
    required this.value,
    this.height = 6,
    this.color,
    this.backgroundColor,
    this.borderRadius,
  });

  /// The current progress value.
  ///
  /// The value must be between `0.0` and `1.0`.
  ///
  /// A value of `0.0` represents no progress, while `1.0` represents
  /// completed progress.
  final double value;

  /// The height of the progress indicator.
  final double height;

  /// The color of the completed portion of the progress indicator.
  ///
  /// When null, the ambient theme's progress indicator color is used.
  final Color? color;

  /// The color of the uncompleted portion of the progress indicator.
  ///
  /// When null, the ambient theme's default track color is used.
  final Color? backgroundColor;

  /// The border radius applied to the progress indicator.
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: LinearProgressIndicator(
          value: value,
          color: color,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}