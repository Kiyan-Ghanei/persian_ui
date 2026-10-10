import 'package:flutter/material.dart';

import '../foundation/colors/p_colors.dart';
import '../foundation/radius/p_radius.dart';
import '../foundation/spacing/p_spacing.dart';
import '../foundation/typography/p_typography.dart';

/// The semantic status displayed by [PStatusCard].
enum PStatus {
  success,
  warning,
  error,
  info,
}

/// A reusable status card for PersianUI.
///
/// [PStatusCard] displays a title, optional description,
/// and an icon using colors associated with the selected status.
class PStatusCard extends StatelessWidget {
  const PStatusCard({
    super.key,
    required this.title,
    required this.status,
    this.description,
    this.icon,
    this.padding = const EdgeInsets.all(PSpacing.lg),
    this.borderRadius = PRadius.lg,
  });

  final String title;
  final PStatus status;
  final String? description;
  final IconData? icon;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  Color get _statusColor {
    switch (status) {
      case PStatus.success:
        return PColors.success;
      case PStatus.warning:
        return PColors.warning;
      case PStatus.error:
        return PColors.error;
      case PStatus.info:
        return PColors.info;
    }
  }

  Color get _backgroundColor {
    switch (status) {
      case PStatus.success:
        return PColors.success.withValues(alpha: 0.08);
      case PStatus.warning:
        return PColors.warning.withValues(alpha: 0.08);
      case PStatus.error:
        return PColors.error.withValues(alpha: 0.08);
      case PStatus.info:
        return PColors.info.withValues(alpha: 0.08);
    }
  }

  IconData get _defaultIcon {
    switch (status) {
      case PStatus.success:
        return Icons.check_circle_outline;
      case PStatus.warning:
        return Icons.warning_amber_outlined;
      case PStatus.error:
        return Icons.error_outline;
      case PStatus.info:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            icon ?? _defaultIcon,
            color: _statusColor,
          ),
          const SizedBox(width: PSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: PTypography.fontSizeLg,
                    fontWeight: PTypography.semiBold,
                    color: _statusColor,
                  ),
                ),
                if (description != null) ...<Widget>[
                  const SizedBox(height: PSpacing.xs),
                  Text(
                    description!,
                    style: const TextStyle(
                      fontSize: PTypography.fontSizeMd,
                      fontWeight: PTypography.regular,
                      color: PColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}