import 'package:flutter/material.dart';

/// A reusable key-value presentation component.
///
/// [PKeyValue] is designed for displaying descriptive information such as
/// labels, statuses, counts, and other read-only data.
///
/// The component is presentation-only and contains no business logic.
/// It adapts naturally to the constraints provided by its parent and respects
/// the ambient text direction.
class PKeyValue extends StatelessWidget {
  const PKeyValue({
    super.key,
    required this.label,
    required this.value,
    this.direction = Axis.horizontal,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.padding,
  });

  /// The descriptive label of the value.
  final Widget label;

  /// The value associated with [label].
  final Widget value;

  /// Determines whether the label and value are arranged horizontally
  /// or vertically.
  final Axis direction;

  /// Controls the main-axis alignment of the content.
  final MainAxisAlignment mainAxisAlignment;

  /// Controls the cross-axis alignment of the content.
  final CrossAxisAlignment crossAxisAlignment;

  /// Optional padding around the entire component.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final content = Flex(
      direction: direction,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        if (direction == Axis.horizontal) ...[
          Flexible(
            child: label,
          ),
          const SizedBox(width: 16),
          Flexible(
            child: value,
          ),
        ] else ...[
          label,
          const SizedBox(height: 8),
          value,
        ],
      ],
    );

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: content,
    );
  }
}