
import 'package:flutter/material.dart';

import '../foundation/radius/p_radius.dart';
import '../foundation/spacing/p_spacing.dart';
import 'p_button.dart';

/// A reusable button with a loading state for PersianUI.
///
/// [PLoadingButton] uses the active theme's color scheme and supports
/// different sizes and visual variants.
///
/// Set [fullWidth] to `true` to expand the button to the available width.
class PLoadingButton extends StatelessWidget {
  /// Creates a PersianUI loading button.
  const PLoadingButton({
    required this.text,
    required this.onPressed,
    this.loading = false,
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

  /// Whether the button is currently performing an operation.
  ///
  /// When `true`, the button is disabled and a progress indicator
  /// is displayed instead of the button text.
  final bool loading;

  /// Determines the visual style of the button.
  final PButtonVariant variant;

  /// Determines the internal spacing and loading indicator size.
  ///
  /// Defaults to [PButtonSize.medium].
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

  double _indicatorSize() {
    switch (size) {
      case PButtonSize.small:
        return PSpacing.md;
      case PButtonSize.medium:
        return PSpacing.lg;
      case PButtonSize.large:
        return PSpacing.xl;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color foregroundColor = _foregroundColor(colorScheme);
    final double indicatorSize = _indicatorSize();

    final button = ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _backgroundColor(colorScheme),
        foregroundColor: foregroundColor,
        padding: _padding(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PRadius.md),
        ),
      ),
      child: loading
          ? SizedBox(
              width: indicatorSize,
              height: indicatorSize,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: foregroundColor,
              ),
            )
          : Text(text),
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
