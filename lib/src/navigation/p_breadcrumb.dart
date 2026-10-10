import 'package:flutter/material.dart';

import '../foundation/colors/p_colors.dart';
import '../foundation/radius/p_radius.dart';
import '../foundation/spacing/p_spacing.dart';

/// Represents a single item in a [PBreadcrumb].
///
/// A breadcrumb item can optionally define an [onTap] callback.
/// Items without an [onTap] callback are displayed as non-interactive items.
@immutable
class PBreadcrumbItem {
  /// Creates a breadcrumb item.
  const PBreadcrumbItem({
    required this.label,
    this.onTap,
  });

  /// The text displayed for this breadcrumb item.
  final String label;

  /// Called when the breadcrumb item is tapped.
  ///
  /// If null, the item is rendered as non-interactive.
  final VoidCallback? onTap;
}

/// A reusable breadcrumb navigation component for PersianUI.
///
/// [PBreadcrumb] displays a hierarchical navigation path using a list of
/// [PBreadcrumbItem] objects.
///
/// The last item represents the current page and is non-interactive.
class PBreadcrumb extends StatelessWidget {
  /// Creates a breadcrumb navigation component.
  const PBreadcrumb({
    super.key,
    required this.items,
    this.separator,
    this.textStyle,
    this.currentTextStyle,
    this.spacing = PSpacing.sm,
    this.padding = EdgeInsets.zero,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
  });

  /// The breadcrumb items displayed in order.
  final List<PBreadcrumbItem> items;

  /// Widget displayed between breadcrumb items.
  ///
  /// If null, a directional chevron is used.
  final Widget? separator;

  /// Text style used for non-current breadcrumb items.
  final TextStyle? textStyle;

  /// Text style used for the current breadcrumb item.
  final TextStyle? currentTextStyle;

  /// Horizontal spacing between items and separators.
  final double spacing;

  /// Padding around the entire breadcrumb.
  final EdgeInsetsGeometry padding;

  /// Maximum number of lines for each breadcrumb label.
  final int maxLines;

  /// Overflow behavior for breadcrumb labels.
  final TextOverflow overflow;

  TextStyle _defaultTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: PColors.primary,
        ) ??
        const TextStyle(
          color: PColors.primary,
        );
  }

  TextStyle _defaultCurrentTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: PColors.textPrimary,
        ) ??
        const TextStyle(
          fontWeight: FontWeight.w600,
          color: PColors.textPrimary,
        );
  }

  Widget _buildSeparator(BuildContext context) {
    if (separator != null) {
      return separator!;
    }

    final direction = Directionality.of(context);

    return Icon(
      direction == TextDirection.rtl
          ? Icons.chevron_left
          : Icons.chevron_right,
      size: 18,
      color: PColors.textSecondary,
    );
  }

  Widget _buildItem(
    BuildContext context,
    PBreadcrumbItem item,
    bool isCurrent,
  ) {
    final style = isCurrent
        ? (currentTextStyle ?? _defaultCurrentTextStyle(context))
        : (textStyle ?? _defaultTextStyle(context));

    final text = Text(
      item.label,
      style: style,
      maxLines: maxLines,
      overflow: overflow,
    );

    if (isCurrent || item.onTap == null) {
      return Semantics(
        label: item.label,
        child: text,
      );
    }

    return Semantics(
      label: item.label,
      link: true,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(PRadius.sm),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: PSpacing.xs,
            vertical: PSpacing.xxs,
          ),
          child: text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Padding(
        padding: padding,
        child: const SizedBox.shrink(),
      );
    }

    return Padding(
      padding: padding,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: spacing,
        runSpacing: spacing,
        children: [
          for (var index = 0; index < items.length; index++) ...[
            _buildItem(
              context,
              items[index],
              index == items.length - 1,
            ),
            if (index < items.length - 1) _buildSeparator(context),
          ],
        ],
      ),
    );
  }
}