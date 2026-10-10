import 'package:flutter/material.dart';

import '../foundation/spacing/p_spacing.dart';

/// A reusable responsive list tile for displaying content or handling
/// user interaction.
///
/// The component supports leading, title, subtitle, and trailing content.
/// Interaction is optional and can be provided through [onTap] and
/// [onLongPress].
///
/// The layout adapts naturally to the available horizontal constraints and
/// respects the ambient [TextDirection], making it suitable for both RTL
/// and LTR interfaces.
class PListTile extends StatelessWidget {
  const PListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.padding,
    this.enabled = true,
  });

  /// Optional widget displayed before the main content.
  final Widget? leading;

  /// The primary content of the tile.
  final Widget title;

  /// Optional secondary content displayed below [title].
  final Widget? subtitle;

  /// Optional widget displayed after the main content.
  final Widget? trailing;

  /// Called when the tile is tapped.
  final VoidCallback? onTap;

  /// Called when the tile is long-pressed.
  final VoidCallback? onLongPress;

  /// The internal padding of the tile.
  final EdgeInsetsGeometry? padding;

  /// Whether the tile is enabled for interaction.
  final bool enabled;

  bool get _isInteractive => onTap != null || onLongPress != null;

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (leading != null) ...[
          leading!,
          const SizedBox(width: PSpacing.md),
        ],
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title,
              if (subtitle != null) ...[
                const SizedBox(height: PSpacing.xs),
                subtitle!,
              ],
            ],
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: PSpacing.md),
          trailing!,
        ],
      ],
    );

    final tile = Padding(
      padding: padding ?? const EdgeInsetsDirectional.all(PSpacing.md),
      child: content,
    );

    return Semantics(
      enabled: enabled,
      button: _isInteractive,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: enabled ? onTap : null,
          onLongPress: enabled ? onLongPress : null,
          child: tile,
        ),
      ),
    );
  }
}