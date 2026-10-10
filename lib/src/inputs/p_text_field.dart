
import 'package:flutter/material.dart';

import '../foundation/colors/p_colors.dart';
import '../foundation/radius/p_radius.dart';
import '../foundation/spacing/p_spacing.dart';

/// A reusable text field component for PersianUI.
///
/// [PTextField] provides a consistent input appearance while supporting
/// common Persian and RTL text-entry scenarios.
class PTextField extends StatelessWidget {
  /// Creates a PersianUI text field.
  const PTextField({
    this.controller,
    this.label,
    this.hint,
    this.onChanged,
    this.enabled = true,
    this.textDirection,
    this.errorText,
    super.key,
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// Optional label displayed above or inside the input decoration.
  final String? label;

  /// Optional hint displayed when the field is empty.
  final String? hint;

  /// Called whenever the field value changes.
  final ValueChanged<String>? onChanged;

  /// Whether the field is enabled.
  final bool enabled;

  /// Direction used for the text entered into the field.
  ///
  /// Use [TextDirection.rtl] for Persian or other right-to-left content.
  /// Use [TextDirection.ltr] for Latin or left-to-right content.
  final TextDirection? textDirection;

  /// Optional validation error displayed below the field.
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      enabled: enabled,
      textDirection: textDirection,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
        filled: true,
        fillColor: PColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: PSpacing.lg,
          vertical: PSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(PRadius.md),
          borderSide: const BorderSide(
            color: PColors.border,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(PRadius.md),
          borderSide: const BorderSide(
            color: PColors.border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(PRadius.md),
          borderSide: const BorderSide(
            color: PColors.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(PRadius.md),
          borderSide: const BorderSide(
            color: PColors.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(PRadius.md),
          borderSide: const BorderSide(
            color: PColors.error,
            width: 2,
          ),
        ),
      ),
    );
  }
}
