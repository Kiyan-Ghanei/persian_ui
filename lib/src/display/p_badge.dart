import 'package:flutter/material.dart';

/// A compact visual indicator for displaying short status or count information.
///
/// [PBadge] supports both compact circular badges and content-sized
/// pill-shaped badges.
///
/// Example:
/// ```dart
/// PBadge(
///   label: '3',
/// )
/// ```
///
/// For a text badge:
/// ```dart
/// PBadge(
///   label: 'NEW',
///   shape: PBadgeShape.pill,
/// )
/// ```
class PBadge extends StatelessWidget {
  const PBadge({
    super.key,
    required this.label,
    this.shape = PBadgeShape.pill,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.minSize = 20,
    this.textStyle,
    this.semanticLabel,
  });

  /// Text displayed inside the badge.
  final String label;

  /// Defines the visual shape of the badge.
  final PBadgeShape shape;

  /// Background color of the badge.
  final Color? backgroundColor;

  /// Text/icon color of the badge.
  final Color? foregroundColor;

  /// Custom internal padding.
  final EdgeInsetsGeometry? padding;

  /// Minimum width and height of the badge.
  final double minSize;

  /// Custom text style.
  final TextStyle? textStyle;

  /// Optional accessibility label.
  final String? semanticLabel;

  EdgeInsetsGeometry _defaultPadding() {
    switch (shape) {
      case PBadgeShape.circle:
        return const EdgeInsets.all(4);
      case PBadgeShape.pill:
        return const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        );
    }
  }

  BorderRadius _borderRadius() {
    switch (shape) {
      case PBadgeShape.circle:
        return BorderRadius.circular(999);
      case PBadgeShape.pill:
        return BorderRadius.circular(999);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveForegroundColor =
        foregroundColor ?? theme.colorScheme.onError;
    final effectiveBackgroundColor =
        backgroundColor ?? theme.colorScheme.error;

    final badge = Container(
      constraints: BoxConstraints(
        minWidth: minSize,
        minHeight: minSize,
      ),
      padding: padding ?? _defaultPadding(),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: _borderRadius(),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: textStyle ??
            TextStyle(
              color: effectiveForegroundColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1,
            ),
      ),
    );

    if (semanticLabel == null || semanticLabel!.isEmpty) {
      return badge;
    }

    return Semantics(
      label: semanticLabel,
      child: badge,
    );
  }
}

/// Defines the visual shape of a [PBadge].
enum PBadgeShape {
  /// A compact circular badge, suitable for short numeric values.
  circle,

  /// A content-sized pill badge, suitable for text and status labels.
  pill,
}