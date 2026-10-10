import 'package:flutter/material.dart';

/// A reusable Material 3 slider designed for Persian and RTL interfaces.
///
/// [PSlider] is a controlled component. The current slider value is provided
/// through [value], and changes are reported through [onChanged].
///
/// The [min] and [max] properties define the allowed value range.
/// [divisions] can be provided to create a discrete slider.
///
/// When [onChanged] is null or [enabled] is false, the slider is disabled.
///
/// The [label] is passed to Flutter's Material [Slider] and can be used to
/// display a value label while the user interacts with the slider.
///
/// Directionality is inherited from the surrounding Flutter context, so the
/// component works with both RTL and LTR layouts.
///
/// The component does not impose a fixed width or height and supports
/// constrained and responsive layouts.
class PSlider extends StatelessWidget {
  const PSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.enabled = true,
    this.padding,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final bool enabled;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final slider = Slider(
      value: value,
      min: min,
      max: max,
      divisions: divisions,
      label: label,
      onChanged: enabled ? onChanged : null,
    );

    if (padding == null) {
      return slider;
    }

    return Padding(
      padding: padding!,
      child: slider,
    );
  }
}