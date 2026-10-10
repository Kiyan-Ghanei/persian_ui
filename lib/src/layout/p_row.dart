import 'package:flutter/material.dart';

/// A reusable horizontal layout component for PersianUI.
///
/// [PRow] provides a typed and consistent API around Flutter's [Row]
/// while keeping layout responsibilities explicit and focused.
class PRow extends StatelessWidget {
  /// Creates a PersianUI horizontal layout.
  const PRow({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
  });

  /// The widgets displayed horizontally.
  final List<Widget> children;

  /// How the children are positioned along the horizontal axis.
  final MainAxisAlignment mainAxisAlignment;

  /// How much horizontal space the row should occupy.
  final MainAxisSize mainAxisSize;

  /// How the children are positioned along the vertical axis.
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
    return Row(
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