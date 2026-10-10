import 'package:flutter/material.dart';

/// A compact component for displaying labels, tags, filters, or selections.
///
/// [PChip] can optionally support:
/// - a leading widget,
/// - a trailing widget,
/// - tap interaction,
/// - delete interaction,
/// - selected state,
/// - disabled state.
///
/// Example:
/// ```dart
/// PChip(
///   label: 'هوش مصنوعی',
///   onTap: () {},
/// )
/// ```
class PChip extends StatelessWidget {
  const PChip({
    super.key,
    required this.label,
    this.leading,
    this.trailing,
    this.onTap,
    this.onDeleted,
    this.selected = false,
    this.enabled = true,
    this.backgroundColor,
    this.foregroundColor,
    this.selectedBackgroundColor,
    this.selectedForegroundColor,
    this.borderColor,
    this.padding,
    this.borderRadius = 999,
    this.textStyle,
    this.semanticLabel,
  });

  /// Text displayed inside the chip.
  final String label;

  /// Optional widget displayed before the label.
  final Widget? leading;

  /// Optional widget displayed after the label.
  final Widget? trailing;

  /// Called when the chip is tapped.
  final VoidCallback? onTap;

  /// Called when the chip's delete action is triggered.
  final VoidCallback? onDeleted;

  /// Whether the chip is currently selected.
  final bool selected;

  /// Whether the chip is enabled.
  final bool enabled;

  /// Background color when the chip is not selected.
  final Color? backgroundColor;

  /// Foreground color when the chip is not selected.
  final Color? foregroundColor;

  /// Background color when the chip is selected.
  final Color? selectedBackgroundColor;

  /// Foreground color when the chip is selected.
  final Color? selectedForegroundColor;

  /// Border color of the chip.
  final Color? borderColor;

  /// Internal padding of the chip.
  final EdgeInsetsGeometry? padding;

  /// Border radius of the chip.
  final double borderRadius;

  /// Custom text style.
  final TextStyle? textStyle;

  /// Optional accessibility label.
  final String? semanticLabel;

  Color _backgroundColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (selected) {
      return selectedBackgroundColor ?? colorScheme.primaryContainer;
    }

    return backgroundColor ?? colorScheme.surfaceContainerHighest;
  }

  Color _foregroundColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (selected) {
      return selectedForegroundColor ?? colorScheme.onPrimaryContainer;
    }

    return foregroundColor ?? colorScheme.onSurfaceVariant;
  }

  Border? _border(BuildContext context) {
    if (borderColor == null) {
      return null;
    }

    return Border.all(
      color: borderColor!,
    );
  }

  EdgeInsetsGeometry _defaultPadding() {
    return const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8,
    );
  }

  Widget _buildLabel(BuildContext context) {
    return Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: textStyle ??
          TextStyle(
            color: _foregroundColor(context),
            fontSize: 14,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final children = <Widget>[
      if (leading != null) ...[
        IconTheme(
          data: IconThemeData(
            color: _foregroundColor(context),
            size: 18,
          ),
          child: leading!,
        ),
        const SizedBox(width: 6),
      ],
      Flexible(
        child: _buildLabel(context),
      ),
      if (trailing != null) ...[
        const SizedBox(width: 6),
        IconTheme(
          data: IconThemeData(
            color: _foregroundColor(context),
            size: 18,
          ),
          child: trailing!,
        ),
      ],
    ];

    return Padding(
      padding: padding ?? _defaultPadding(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }

  Widget _buildChip(BuildContext context) {
    final chip = Container(
      constraints: const BoxConstraints(
        minHeight: 32,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor(context),
        borderRadius: BorderRadius.circular(borderRadius),
        border: _border(context),
      ),
      child: _buildContent(context),
    );

    if (!enabled) {
      return Opacity(
        opacity: 0.5,
        child: chip,
      );
    }

    if (onTap == null) {
      return chip;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: chip,
      ),
    );
  }

  Widget _buildDeleteAction(BuildContext context, Widget child) {
    if (onDeleted == null) {
      return child;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        const SizedBox(width: 4),
        Semantics(
          button: true,
          label: 'حذف $label',
          child: InkWell(
            onTap: enabled ? onDeleted : null,
            borderRadius: BorderRadius.circular(999),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Icon(
                Icons.close,
                size: 16,
                color: _foregroundColor(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget result = _buildChip(context);

    result = _buildDeleteAction(context, result);

    if (semanticLabel == null || semanticLabel!.isEmpty) {
      return result;
    }

    return Semantics(
      label: semanticLabel,
      enabled: enabled,
      selected: selected,
      child: result,
    );
  }
}