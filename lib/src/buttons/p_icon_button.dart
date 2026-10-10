
import 'package:flutter/material.dart';

import '../foundation/radius/p_radius.dart';
import '../foundation/spacing/p_spacing.dart';
import 'p_button.dart';

/// A reusable icon-only button for PersianUI.
///
/// [PIconButton] uses the active theme's color scheme and supports
/// different sizes and the same visual variants as [PButton].
class PIconButton extends StatelessWidget {
  /// Creates a PersianUI icon button.
  const PIconButton({
    required this.icon,
    required this.onPressed,
    this.variant = PButtonVariant.primary,
    this.size = PButtonSize.medium,
    this.tooltip,
    super.key,
  });

  /// Icon displayed inside the button.
  final IconData icon;

  /// Called when the button is pressed.
  ///
  /// Set this to `null` to disable the button.
  final VoidCallback? onPressed;

  /// Determines the visual style of the button.
  final PButtonVariant variant;

  /// Determines the button's padding and icon size.
  ///
  /// Defaults to [PButtonSize.medium].
  final PButtonSize size;

  /// Optional tooltip shown when the user hovers over the button
  /// or requests its tooltip.
  final String? tooltip;

  Color _backgroundColor(ColorScheme colorScheme) {
    switch (variant) {
      case PButtonVariant.primary:
        return colorScheme.primary;
      case PButtonVariant.secondary:
        return colorScheme.surfaceContainerHighest;
      case PButtonVariant.danger:
        return colorScheme.error;
    }
  }

  Color _foregroundColor(ColorScheme colorScheme) {
    switch (variant) {
      case PButtonVariant.primary:
        return colorScheme.onPrimary;
      case PButtonVariant.secondary:
        return colorScheme.onSurface;
      case PButtonVariant.danger:
        return colorScheme.onError;
    }
  }

  double _iconSize() {
    switch (size) {
      case PButtonSize.small:
        return 18;
      case PButtonSize.medium:
        return 24;
      case PButtonSize.large:
        return 30;
    }
  }

  double _padding() {
    switch (size) {
      case PButtonSize.small:
        return PSpacing.sm;
      case PButtonSize.medium:
        return PSpacing.md;
      case PButtonSize.large:
        return PSpacing.lg;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final button = IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: _iconSize(),
      ),
      color: _foregroundColor(colorScheme),
      style: IconButton.styleFrom(
        backgroundColor: _backgroundColor(colorScheme),
        padding: EdgeInsets.all(_padding()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PRadius.md),
        ),
      ),
    );

    if (tooltip == null) {
      return button;
    }

    return Tooltip(
      message: tooltip!,
      child: button,
    );
  }
}
