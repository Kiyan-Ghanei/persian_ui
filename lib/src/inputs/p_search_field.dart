
import 'package:flutter/material.dart';

import '../foundation/colors/p_colors.dart';
import '../foundation/radius/p_radius.dart';
import '../foundation/spacing/p_spacing.dart';

/// A reusable search field component for PersianUI.
///
/// [PSearchField] provides a consistent search input with a search icon,
/// optional text direction, and a clear button when text is present.
class PSearchField extends StatelessWidget {
  /// Creates a PersianUI search field.
  const PSearchField({
    this.controller,
    this.hint = 'جستجو',
    this.onChanged,
    this.enabled = true,
    this.textDirection,
    super.key,
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// Hint displayed when the field is empty.
  final String hint;

  /// Called whenever the search text changes.
  final ValueChanged<String>? onChanged;

  /// Whether the field is enabled.
  final bool enabled;

  /// Direction used for the entered text.
  ///
  /// Use [TextDirection.rtl] for Persian text and
  /// [TextDirection.ltr] for Latin text.
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      enabled: enabled,
      textDirection: textDirection,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _buildClearButton(),
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
      ),
    );
  }

  Widget? _buildClearButton() {
    if (controller == null || controller!.text.isEmpty) {
      return null;
    }

    return IconButton(
      onPressed: () {
        controller!.clear();
        onChanged?.call('');
      },
      icon: const Icon(Icons.clear),
      tooltip: 'پاک کردن',
    );
  }
}
