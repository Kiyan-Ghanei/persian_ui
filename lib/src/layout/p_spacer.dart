import 'package:flutter/material.dart';

/// A reusable fixed-spacing component for PersianUI.
///
/// [PSpacer] creates a fixed amount of empty space between widgets.
/// It is intentionally based on [SizedBox] and does not implement
/// flex behavior.
///
/// For flex-based spacing inside a [Row] or [Column], use Flutter's
/// standard [Spacer] directly.
class PSpacer extends StatelessWidget {
  /// Creates a fixed horizontal or vertical spacer.
  const PSpacer({
    super.key,
    this.height,
    this.width,
  });

  /// The fixed vertical space.
  final double? height;

  /// The fixed horizontal space.
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}