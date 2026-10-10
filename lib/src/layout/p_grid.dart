
import 'package:flutter/material.dart';

/// A reusable grid layout component for PersianUI.
///
/// [PGrid] provides a simple and consistent API around Flutter's
/// [GridView] for displaying a fixed number of columns.
///
/// The component focuses only on grid layout responsibilities and does not
/// introduce custom item rendering, responsive breakpoints, or custom
/// grid delegates.
class PGrid extends StatelessWidget {
  /// Creates a grid with a fixed number of columns.
  ///
  /// [crossAxisCount] must be greater than zero.
  /// Spacing values must be non-negative.
  /// [childAspectRatio] must be greater than zero.
  const PGrid({
    super.key,
    required this.children,
    required this.crossAxisCount,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.childAspectRatio = 1.0,
    this.padding,
    this.physics,
    this.shrinkWrap = true,
  }) : assert(
         crossAxisCount > 0,
         'crossAxisCount must be greater than zero.',
       ),
       assert(
         mainAxisSpacing >= 0,
         'mainAxisSpacing must be non-negative.',
       ),
       assert(
         crossAxisSpacing >= 0,
         'crossAxisSpacing must be non-negative.',
       ),
       assert(
         childAspectRatio > 0,
         'childAspectRatio must be greater than zero.',
       );

  /// The widgets displayed inside the grid.
  final List<Widget> children;

  /// The number of columns in the grid.
  final int crossAxisCount;

  /// The vertical space between grid items.
  final double mainAxisSpacing;

  /// The horizontal space between grid items.
  final double crossAxisSpacing;

  /// The ratio of the width to the height of each grid item.
  final double childAspectRatio;

  /// The padding around the grid contents.
  final EdgeInsetsGeometry? padding;

  /// The scroll physics used by the grid.
  final ScrollPhysics? physics;

  /// Whether the grid should size itself based on its children.
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      childAspectRatio: childAspectRatio,
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      children: children,
    );
  }
}
