import 'package:flutter/material.dart';

import '../foundation/colors/p_colors.dart';
import '../foundation/radius/p_radius.dart';
import '../foundation/spacing/p_spacing.dart';

/// A reusable card component for PersianUI.
///
/// [PCard] provides a consistent surface, spacing, radius, border,
/// and elevation system for content containers.
class PCard extends StatelessWidget {
  const PCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(PSpacing.lg),
    this.margin = EdgeInsets.zero,
    this.color = PColors.surface,
    this.borderRadius = PRadius.lg,
    this.elevation = 0,
    this.border,
  });

  /// Content displayed inside the card.
  final Widget child;

  /// Internal spacing between the card and its content.
  final EdgeInsetsGeometry padding;

  /// External spacing around the card.
  final EdgeInsetsGeometry margin;

  /// Background color of the card.
  final Color color;

  /// Corner radius of the card.
  final double borderRadius;

  /// Elevation of the card.
  final double elevation;

  /// Optional border displayed around the card.
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border,
        boxShadow: elevation > 0
            ? <BoxShadow>[
                BoxShadow(
                  blurRadius: elevation * 2,
                  spreadRadius: 0,
                  offset: Offset(0, elevation),
                  color: Colors.black.withValues(
                    alpha: 0.12,
                  ),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}