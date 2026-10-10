import 'package:flutter/material.dart';

/// A reusable Material 3 radio control designed for Persian and RTL
/// interfaces.
///
/// [PRadio] is intended to be used inside a Flutter [RadioGroup].
/// The [value] identifies the option represented by this radio.
///
/// Selection state and selection changes are managed by the nearest
/// [RadioGroup] ancestor. This follows the modern Flutter radio API.
///
/// An optional [label] can be provided to display content next to the radio.
/// The component does not impose a fixed width or height and supports
/// constrained and responsive layouts.
class PRadio<T> extends StatelessWidget {
  const PRadio({
    super.key,
    required this.value,
    this.label,
    this.enabled,
    this.padding,
  });

  /// The value represented by this radio option.
  final T value;

  /// Optional content displayed next to the radio.
  final Widget? label;

  /// Whether this radio is interactive.
  ///
  /// A null value allows the surrounding [RadioGroup] or Flutter's
  /// default behavior to determine the enabled state.
  final bool? enabled;

  /// Optional outer padding around the radio content.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final radio = Radio<T>(
      value: value,
      enabled: enabled,
    );

    final Widget content;

    if (label == null) {
      content = radio;
    } else {
      content = Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          radio,
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