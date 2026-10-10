import 'package:flutter/material.dart';

/// A reusable linear progress component for PersianUI.
///
/// [PLinearProgress] displays horizontal progress and can optionally
/// show the current progress percentage.
///
/// The [value] must be between `0.0` and `1.0`.
class PLinearProgress extends StatelessWidget {
  /// Creates a linear progress indicator.
  const PLinearProgress({
    super.key,
    required this.value,
    this.height = 8,
    this.color,
    this.backgroundColor,
    this.borderRadius,
    this.showPercentage = false,
  });

  /// The current progress value.
  ///
  /// The value must be between `0.0` and `1.0`.
  final double value;

  /// The height of the progress bar.
  final double height;

  /// The color of the completed portion.
  ///
  /// When null, the ambient theme's progress indicator color is used.
  final Color? color;

  /// The color of the uncompleted portion.
  ///
  /// When null, the ambient theme's default track color is used.
  final Color? backgroundColor;

  /// The border radius applied to the progress bar.
  final BorderRadiusGeometry? borderRadius;

  /// Whether to display the progress percentage.
  final bool showPercentage;

  String get _percentageText => '${(value * 100).round()}%';

  @override
  Widget build(BuildContext context) {
    final progressIndicator = SizedBox(
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

    if (!showPercentage) {
      return progressIndicator;
    }

    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: progressIndicator,
        ),
        const SizedBox(width: 8),
        Text(_percentageText),
      ],
    );
  }
}