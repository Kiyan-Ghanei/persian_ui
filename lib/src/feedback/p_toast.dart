import 'package:flutter/material.dart';

import '../foundation/colors/p_colors.dart';
import '../foundation/radius/p_radius.dart';
import '../foundation/spacing/p_spacing.dart';
import '../foundation/typography/p_typography.dart';

/// The semantic type of a [PToast].
enum PToastType {
  success,
  warning,
  error,
  info,
}

/// A reusable toast message for PersianUI.
///
/// [PToast] displays a short message with an icon and
/// a color based on its semantic type.
class PToast extends StatelessWidget {
  const PToast({
    super.key,
    required this.message,
    required this.type,
    this.icon,
    this.padding = const EdgeInsets.symmetric(
      horizontal: PSpacing.lg,
      vertical: PSpacing.md,
    ),
    this.borderRadius = PRadius.lg,
  });

  final String message;
  final PToastType type;
  final IconData? icon;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  Color get _color {
    switch (type) {
      case PToastType.success:
        return PColors.success;
      case PToastType.warning:
        return PColors.warning;
      case PToastType.error:
        return PColors.error;
      case PToastType.info:
        return PColors.info;
    }
  }

  IconData get _defaultIcon {
    switch (type) {
      case PToastType.success:
        return Icons.check_circle_outline;
      case PToastType.warning:
        return Icons.warning_amber_outlined;
      case PToastType.error:
        return Icons.error_outline;
      case PToastType.info:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon ?? _defaultIcon,
            color: PColors.white,
          ),
          const SizedBox(width: PSpacing.sm),
          Flexible(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: PTypography.fontSizeMd,
                fontWeight: PTypography.medium,
                color: PColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}