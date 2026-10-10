import 'package:flutter/material.dart';

/// A reusable loading indicator for PersianUI.
///
/// [PLoadingIndicator] provides a consistent API around Flutter's
/// [CircularProgressIndicator] while keeping the component focused
/// on loading feedback.
///
/// The indicator inherits its color from the ambient theme unless
/// a custom color is provided.
class PLoadingIndicator extends StatelessWidget {
  /// Creates a circular loading indicator.
  const PLoadingIndicator({
    super.key,
    this.size = 24,
    this.strokeWidth = 2,
    this.color,
    this.semanticsLabel,
  });

  /// The width and height of the loading indicator.
  final double size;

  /// The width of the progress indicator's stroke.
  final double strokeWidth;

  /// The color of the progress indicator.
  ///
  /// When null, the indicator uses the ambient theme's progress
  /// indicator color.
  final Color? color;

  /// An optional semantic label for accessibility.
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final indicator = SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        color: color,
      ),
    );

    if (semanticsLabel == null) {
      return indicator;
    }

    return Semantics(
      label: semanticsLabel,
      child: indicator,
    );
  }
}