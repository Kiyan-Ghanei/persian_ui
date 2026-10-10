import 'package:flutter/material.dart';

/// A reusable vertical layout component for PersianUI.
///
/// [PColumn] provides a typed and consistent API around Flutter's [Column]
/// while keeping layout responsibilities explicit.
class PColumn extends StatelessWidget {
  /// Creates a PersianUI vertical layout.
  const PColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
  });

  /// The widgets displayed vertically.
  final List<Widget> children;

  /// How the children are positioned along the vertical axis.
  final MainAxisAlignment mainAxisAlignment;

  /// How much vertical space the column should occupy.
  final MainAxisSize mainAxisSize;

  /// How the children are positioned along the horizontal axis.
  final CrossAxisAlignment crossAxisAlignment;

  /// The text direction used to determine the horizontal layout direction.
  ///
  /// When null, the ambient [Directionality] is used.
  final TextDirection? textDirection;

  /// The direction in which the children are laid out vertically.
  final VerticalDirection verticalDirection;

  /// The baseline used when [crossAxisAlignment] is
  /// [CrossAxisAlignment.baseline].
  final TextBaseline? textBaseline;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: children,
    );
  }
}