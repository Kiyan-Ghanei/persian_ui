import 'package:flutter/material.dart';

/// A reusable content container for PersianUI.
///
/// [PContainer] provides a simple way to control content width, spacing,
/// and alignment without introducing visual decoration responsibilities.
///
/// This component is intentionally focused on layout concerns and does not
/// provide colors, borders, shadows, or other decorative properties.
class PContainer extends StatelessWidget {
  /// Creates a PersianUI content container.
  ///
  /// When provided, [maxWidth] must be non-negative.
  const PContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.maxWidth,
    this.alignment = Alignment.topCenter,
  }) : assert(
         maxWidth == null || maxWidth >= 0,
         'maxWidth must be non-negative.',
       );

  /// The widget displayed inside the container.
  final Widget child;

  /// Empty space inside the container around [child].
  final EdgeInsetsGeometry? padding;

  /// Empty space outside the container.
  final EdgeInsetsGeometry? margin;

  /// The maximum width of the constrained content area.
  ///
  /// When null, no additional maximum-width constraint is imposed.
  /// Padding and margin are applied outside this constraint.
  ///
  /// Must be non-negative when provided.
  final double? maxWidth;

  /// The alignment of [child] within the available space.
  ///
  /// Defaults to [Alignment.topCenter].
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    Widget content = Align(
      alignment: alignment,
      child: child,
    );

    if (maxWidth != null) {
      content = ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth!,
        ),
        child: content,
      );
    }

    if (padding != null) {
      content = Padding(
        padding: padding!,
        child: content,
      );
    }

    if (margin != null) {
      content = Padding(
        padding: margin!,
        child: content,
      );
    }

    return content;
  }
}