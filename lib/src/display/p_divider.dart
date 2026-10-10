import 'package:flutter/material.dart';

/// A reusable divider component for PersianUI.
///
/// Supports both horizontal and vertical orientations while preserving
/// Flutter's standard [Divider] and [VerticalDivider] behavior.
class PDivider extends StatelessWidget {
  /// Creates a PersianUI divider.
  const PDivider({
    super.key,
    this.orientation = Axis.horizontal,
    this.thickness = 1.0,
    this.color,
    this.indent = 0.0,
    this.endIndent = 0.0,
  });

  /// The orientation of the divider.
  ///
  /// Defaults to [Axis.horizontal].
  final Axis orientation;

  /// The thickness of the divider line.
  ///
  /// Defaults to `1.0`.
  final double thickness;

  /// The color of the divider line.
  ///
  /// When null, Flutter's theme-based divider color is used.
  final Color? color;

  /// Empty space before the divider.
  ///
  /// For a horizontal divider, this applies horizontally.
  /// For a vertical divider, this applies vertically.
  final double indent;

  /// Empty space after the divider.
  ///
  /// For a horizontal divider, this applies horizontally.
  /// For a vertical divider, this applies vertically.
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    return switch (orientation) {
      Axis.horizontal => Divider(
          thickness: thickness,
          color: color,
          indent: indent,
          endIndent: endIndent,
        ),
      Axis.vertical => VerticalDivider(
          thickness: thickness,
          color: color,
          indent: indent,
          endIndent: endIndent,
        ),
    };
  }
}