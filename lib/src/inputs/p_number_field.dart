import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../foundation/colors/p_colors.dart';
import '../foundation/radius/p_radius.dart';
import '../foundation/spacing/p_spacing.dart';
import '../foundation/typography/p_typography.dart';

/// A reusable numeric input field for PersianUI.
///
/// [PNumberField] is designed for numeric values and supports both
/// right-to-left and left-to-right text directions.
class PNumberField extends StatelessWidget {
  const PNumberField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.onChanged,
    this.enabled = true,
    this.errorText,
    this.textDirection = TextDirection.rtl,
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// Label displayed above or inside the input field.
  final String? label;

  /// Hint displayed when the field is empty.
  final String? hint;

  /// Called whenever the input value changes.
  final ValueChanged<String>? onChanged;

  /// Whether the field can be edited.
  final bool enabled;

  /// Error message displayed below the field.
  final String? errorText;

  /// Direction of the entered text.
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      onChanged: onChanged,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9۰-۹.]'),
        ),
      ],
      textDirection: textDirection,
      style: const TextStyle(
        fontSize: PTypography.fontSizeMd,
        fontWeight: PTypography.regular,
        color: PColors.textPrimary,
      ),
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