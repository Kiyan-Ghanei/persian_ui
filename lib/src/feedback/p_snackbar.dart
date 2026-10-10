
import 'package:flutter/material.dart';

import '../foundation/colors/p_colors.dart';
import '../foundation/radius/p_radius.dart';
import '../foundation/spacing/p_spacing.dart';

/// The visual type of a [PSnackbar].
enum PSnackbarType {
  success,
  warning,
  error,
  info,
}

/// A reusable Snackbar component for PersianUI.
///
/// [PSnackbar] provides a consistent visual style for temporary feedback
/// messages and supports optional actions.
class PSnackbar extends SnackBar {
  PSnackbar({
    super.key,
    required String message,
    PSnackbarType type = PSnackbarType.info,
    String? actionLabel,
    VoidCallback? onAction,
    super.duration = const Duration(seconds: 4),
  }) : super(
          content: Row(
            children: <Widget>[
              Icon(
                _iconFor(type),
                color: PColors.white,
              ),
              const SizedBox(width: PSpacing.sm),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: PColors.white,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: _colorFor(type),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PRadius.md),
          ),
          action: actionLabel != null
              ? SnackBarAction(
                  label: actionLabel,
                  onPressed: onAction ?? () {},
                )
              : null,
        );

  /// Shows a [PSnackbar] using the nearest [ScaffoldMessenger].
  static void show({
    required BuildContext context,
    required String message,
    PSnackbarType type = PSnackbarType.info,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      PSnackbar(
        message: message,
        type: type,
        actionLabel: actionLabel,
        onAction: onAction,
        duration: duration,
      ),
    );
  }

  static Color _colorFor(PSnackbarType type) {
    switch (type) {
      case PSnackbarType.success:
        return PColors.success;
      case PSnackbarType.warning:
        return PColors.warning;
      case PSnackbarType.error:
        return PColors.error;
      case PSnackbarType.info:
        return PColors.info;
    }
  }

  static IconData _iconFor(PSnackbarType type) {
    switch (type) {
      case PSnackbarType.success:
        return Icons.check_circle_outline;
      case PSnackbarType.warning:
        return Icons.warning_amber_outlined;
      case PSnackbarType.error:
        return Icons.error_outline;
      case PSnackbarType.info:
        return Icons.info_outline;
    }
  }
}
