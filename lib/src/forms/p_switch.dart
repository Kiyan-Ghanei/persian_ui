
import 'package:flutter/material.dart';

/// A reusable Material 3 switch control designed for Persian and RTL
/// interfaces.
///
/// [PSwitch] is a controlled component. The current switch state is provided
/// through [value], and changes are reported through [onChanged].
///
/// When [onChanged] is null, the switch is disabled.
///
/// An optional [label] can be provided to display content next to the switch.
/// The component does not impose a fixed width or height and supports
/// constrained and responsive layouts.
///
/// Directionality is inherited from the surrounding Flutter context, so the
/// component works with both RTL and LTR layouts.
class PSwitch extends StatelessWidget {
  const PSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.padding,
  });

  /// The current selected state of the switch.
  final bool value;

  /// Called when the user changes the switch state.
  ///
  /// When null, the switch is disabled.
  final ValueChanged<bool>? onChanged;

  /// Optional content displayed next to the switch.
  final Widget? label;

  /// Optional outer padding around the switch content.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final switchControl = Switch(
      value: value,
      onChanged: onChanged,
    );

    final Widget content;

    if (label == null) {
      content = switchControl;
    } else {
      content = Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          switchControl,
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
