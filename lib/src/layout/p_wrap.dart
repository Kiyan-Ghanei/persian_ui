
import 'package:flutter/material.dart';

/// A reusable wrapping layout component for PersianUI.
///
/// [PWrap] provides a consistent API around Flutter's [Wrap] widget.
/// It lays out children in sequence and moves them to additional runs when
/// they do not fit within the available space.
///
/// The component focuses on layout responsibilities and delegates sizing,
/// line breaking, text direction, and clipping behavior to Flutter.
///
/// By default, the layout follows the ambient [Directionality] and uses
/// horizontal wrapping with no additional spacing.
class PWrap extends StatelessWidget {
  /// Creates a PersianUI wrapping layout.
  ///
  /// [spacing] and [runSpacing] must be non-negative.
  const PWrap({
    super.key,
    required this.children,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.spacing = 0,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 0,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.clipBehavior = Clip.none,
  }) : assert(
         spacing >= 0,
         'spacing must be non-negative.',
       ),
       assert(
         runSpacing >= 0,
         'runSpacing must be non-negative.',
       );

  /// The widgets displayed inside the wrapping layout.
  final List<Widget> children;

  /// The axis along which children are initially placed.
  ///
  /// Horizontal layouts create additional rows when needed.
  /// Vertical layouts create additional columns when needed.
  final Axis direction;

  /// How children are positioned within each run.
  final WrapAlignment alignment;

  /// The space between adjacent children in a run.
  ///
  /// Must be non-negative.
  final double spacing;

  /// How the runs are positioned within the available cross-axis space.
  final WrapAlignment runAlignment;

  /// The space between adjacent runs.
  ///
  /// Must be non-negative.
  final double runSpacing;

  /// How children are aligned within each run along the cross axis.
  final WrapCrossAlignment crossAxisAlignment;

  /// The text direction used to determine the horizontal layout order.
  ///
  /// When null, the ambient [Directionality] is used.
  final TextDirection? textDirection;

  /// The direction in which runs are laid out along the cross axis.
  final VerticalDirection verticalDirection;

  /// How content that overflows the layout bounds is clipped.
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: direction,
      alignment: alignment,
      spacing: spacing,
      runAlignment: runAlignment,
      runSpacing: runSpacing,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      clipBehavior: clipBehavior,
      children: children,
    );
  }
}