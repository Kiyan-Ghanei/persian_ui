import 'package:flutter/material.dart';

import '../foundation/colors/p_colors.dart';
import '../foundation/radius/p_radius.dart';
import '../foundation/spacing/p_spacing.dart';
import '../foundation/typography/p_typography.dart';

/// A reusable informational card for PersianUI.
///
/// [PInfoCard] displays an optional icon, title, and description
/// inside a consistent card layout.
class PInfoCard extends StatelessWidget {
  const PInfoCard({
    super.key,
    this.title,
    this.description,
    this.icon,
    this.color = PColors.primaryLight,
    this.iconColor = PColors.primary,
    this.borderRadius = PRadius.lg,
    this.padding = const EdgeInsets.all(PSpacing.lg),
  });

  final String? title;
  final String? description;
  final IconData? icon;
  final Color color;
  final Color iconColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(
              icon,
              color: iconColor,
            ),
            const SizedBox(width: PSpacing.md),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (title != null)
                  Text(
                    title!,
                    style: const TextStyle(
                      fontSize: PTypography.fontSizeLg,
                      fontWeight: PTypography.semiBold,
                      color: PColors.textPrimary,
                    ),
                  ),
                if (title != null && description != null)
                  const SizedBox(height: PSpacing.xs),
                if (description != null)
                  Text(
                    description!,
                    style: const TextStyle(
                      fontSize: PTypography.fontSizeMd,
                      fontWeight: PTypography.regular,
                      color: PColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}