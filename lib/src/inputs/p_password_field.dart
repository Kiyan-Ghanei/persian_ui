
import 'package:flutter/material.dart';

import '../foundation/colors/p_colors.dart';
import '../foundation/radius/p_radius.dart';
import '../foundation/spacing/p_spacing.dart';

/// A reusable password field component for PersianUI.
///
/// [PPasswordField] provides a secure text input with a visibility toggle,
/// validation error support, and RTL/LTR text direction support.
class PPasswordField extends StatefulWidget {
  /// Creates a PersianUI password field.
  const PPasswordField({
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

  /// Called whenever the password value changes.
  final ValueChanged<String>? onChanged;

  /// Whether the field is enabled.
  final bool enabled;

  /// Direction used for the text entered into the field.
  ///
  /// Use [TextDirection.rtl] for Persian content.
  /// Use [TextDirection.ltr] for Latin content such as passwords.
  final TextDirection? textDirection;

  /// Optional validation error displayed below the field.
  final String? errorText;

  @override
  State<PPasswordField> createState() => _PPasswordFieldState();
}

class _PPasswordFieldState extends State<PPasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      enabled: widget.enabled,
      textDirection: widget.textDirection,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        errorText: widget.errorText,
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
        suffixIcon: IconButton(
          onPressed: widget.enabled ? _toggleVisibility : null,
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          tooltip: _obscureText ? 'نمایش رمز عبور' : 'مخفی کردن رمز عبور',
        ),
      ),
    );
  }
}
