import 'package:flutter/material.dart';

/// A reusable Material 3 checkbox designed for Persian and RTL interfaces.
///
/// The checkbox is controlled by its parent through [value] and
/// [onChanged]. When [tristate] is enabled, [value] may also be `null`
/// to represent an indeterminate state.
///
/// The component does not impose a fixed width or height and supports
/// constrained and responsive layouts.
class PCheckbox extends StatelessWidget {
  /// Creates a [PCheckbox].
  const PCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.tristate = false,
    this.padding,
  });

  /// The current checkbox value.
  ///
  /// When [tristate] is `false`, the value should normally be either
  /// `true` or `false`.
  ///
  /// When [tristate] is `true`, `null` represents the indeterminate state.
  final bool? value;

  /// Called when the checkbox value changes.
  ///
  /// A `null` callback makes the checkbox disabled, following the
  /// standard Flutter checkbox behavior.
  final ValueChanged<bool?>? onChanged;

  /// Optional content displayed next to the checkbox.
  ///
  /// The layout follows the ambient [TextDirection].
  final Widget? label;

  /// Whether the checkbox supports the indeterminate state.
  final bool tristate;

  /// Optional padding around the checkbox content.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final checkbox = Checkbox(
      value: value,
      onChanged: onChanged,
      tristate: tristate,
    );

    final Widget content;

    if (label == null) {
      content = checkbox;
    } else {
      content = Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          checkbox,
          label!,
        ],
      );
    }

    if (padding == null) {
      return content;
    }

    return Padding(
      padding: padding!,
      child: content,
    );
  }
}