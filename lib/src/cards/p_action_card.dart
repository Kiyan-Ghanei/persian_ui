import 'package:flutter/material.dart';

import '../buttons/p_button.dart';
import '../foundation/colors/p_colors.dart';
import '../foundation/radius/p_radius.dart';
import '../foundation/spacing/p_spacing.dart';
import '../foundation/typography/p_typography.dart';

/// A reusable action card for PersianUI.
///
/// [PActionCard] displays an optional icon, title, description,
/// and a primary action button.
class PActionCard extends StatelessWidget {
  const PActionCard({
    super.key,
    required this.title,
    required this.actionLabel,
    required this.onAction,
    this.description,
    this.icon,
    this.color = PColors.surface,
    this.iconColor = PColors.primary,
    this.borderRadius = PRadius.lg,
    this.padding = const EdgeInsets.all(PSpacing.lg),
  });

  final String title;
  final String actionLabel;
  final VoidCallback? onAction;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(
              icon,
              color: iconColor,
            ),
            const SizedBox(height: PSpacing.md),
          ],
          Text(
            title,
            style: const TextStyle(
              fontSize: PTypography.fontSizeLg,
              fontWeight: PTypography.semiBold,
              color: PColors.textPrimary,
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
          const SizedBox(height: PSpacing.lg),
          PButton(
            text: actionLabel,
            onPressed: onAction,
          ),
        ],
      ),
    );
  }
}