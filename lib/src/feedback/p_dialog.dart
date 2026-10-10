import 'package:flutter/material.dart';

import '../buttons/p_button.dart';
import '../foundation/colors/p_colors.dart';
import '../foundation/radius/p_radius.dart';
import '../foundation/typography/p_typography.dart';

/// A reusable dialog component for PersianUI.
///
/// [PDialog] provides a consistent dialog layout with an optional
/// content widget, confirm action, and cancel action.
class PDialog extends StatelessWidget {
  const PDialog({
    super.key,
    required this.title,
    required this.confirmLabel,
    this.content,
    this.cancelLabel,
    this.onConfirm,
    this.onCancel,
    this.confirmEnabled = true,
  });

  final String title;
  final String confirmLabel;
  final Widget? content;
  final String? cancelLabel;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool confirmEnabled;

  /// Displays a [PDialog] using Flutter's standard dialog route.
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String confirmLabel,
    Widget? content,
    String? cancelLabel,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool confirmEnabled = true,
  }) {
    return showDialog<T>(
      context: context,
      builder: (BuildContext context) {
        return PDialog(
          title: title,
          confirmLabel: confirmLabel,
          content: content,
          cancelLabel: cancelLabel,
          onConfirm: onConfirm,
          onCancel: onCancel,
          confirmEnabled: confirmEnabled,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PRadius.lg),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: PTypography.fontSizeXl,
          fontWeight: PTypography.semiBold,
          color: PColors.textPrimary,
        ),
      ),
      content: content,
      actions: <Widget>[
        if (cancelLabel != null)
          TextButton(
            onPressed: onCancel ?? () => Navigator.of(context).pop(),
            child: Text(cancelLabel!),
          ),
        PButton(
          text: confirmLabel,
          onPressed: confirmEnabled
              ? () {
                  onConfirm?.call();
                  Navigator.of(context).pop();
                }
              : null,
        ),
      ],
    );
  }
}