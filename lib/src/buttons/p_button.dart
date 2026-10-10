
import 'package:flutter/material.dart';

import '../foundation/radius/p_radius.dart';
import '../foundation/spacing/p_spacing.dart';

/// The visual variants available for [PButton].
enum PButtonVariant {
  /// Main action button.
  primary,

  /// Secondary action button.
  secondary,

  /// Destructive action button.
  danger,
}

/// The available sizes for [PButton].
enum PButtonSize {
  /// Compact button with less internal spacing.
  small,

  /// Standard button size.
  medium,

  /// Button with more internal spacing.
  large,
}

/// A reusable button component for PersianUI.
///
/// [PButton] uses the active theme's color scheme so that its appearance
/// adapts to custom themes and light or dark mode.
///
/// Set [fullWidth] to `true` to expand the button to the available width.
class PButton extends StatelessWidget {
  /// Creates a PersianUI button.
  const PButton({
    required this.text,
    required this.onPressed,
    this.variant = PButtonVariant.primary,
    this.size = PButtonSize.medium,
    this.fullWidth = false,
    super.key,
  });

  /// Text displayed inside the button.
  final String text;

  /// Called when the button is pressed.
  ///
  /// Set this to `null` to disable the button.
  final VoidCallback? onPressed;

  /// Determines the visual style of the button.
  final PButtonVariant variant;

  /// Determines the internal spacing of the button.
  ///
  /// Defaults to [PButtonSize.medium] to preserve the existing appearance.
  final PButtonSize size;

  /// Whether the button should fill the available width.
  ///
  /// Defaults to `false`, preserving the existing layout.
  final bool fullWidth;

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

  EdgeInsetsGeometry _padding() {
    switch (size) {
      case PButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: PSpacing.md,
          vertical: PSpacing.xs,
        );
      case PButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: PSpacing.lg,
          vertical: PSpacing.md,
        );
      case PButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: PSpacing.xl,
          vertical: PSpacing.lg,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _backgroundColor(colorScheme),
        foregroundColor: _foregroundColor(colorScheme),
        padding: _padding(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PRadius.md),
        ),
      ),
      child: Text(text),
    );

    if (!fullWidth) {
      return button;
    }

    return SizedBox(
      width: double.infinity,
      child: button,
    );
  }
}
