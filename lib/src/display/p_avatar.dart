import 'package:flutter/material.dart';

/// A reusable avatar component for PersianUI.
///
/// The avatar can display an image, fallback text, or a fallback icon.
///
/// Fallback priority:
/// 1. [imageProvider]
/// 2. [fallbackText]
/// 3. [fallbackIcon]
/// 4. Empty avatar
class PAvatar extends StatelessWidget {
  const PAvatar({
    super.key,
    this.imageProvider,
    this.fallbackText,
    this.fallbackIcon,
    this.size = 40,
    this.backgroundColor,
    this.foregroundColor,
    this.semanticLabel,
  });

  /// The image displayed inside the avatar.
  final ImageProvider<Object>? imageProvider;

  /// Text displayed when [imageProvider] is unavailable or fails.
  final String? fallbackText;

  /// Icon displayed when both image and [fallbackText] are unavailable.
  final Widget? fallbackIcon;

  /// The diameter of the avatar.
  final double size;

  /// Background color of the avatar.
  final Color? backgroundColor;

  /// Foreground color used by fallback content.
  final Color? foregroundColor;

  /// Semantic label announced by accessibility services.
  final String? semanticLabel;

  Widget _buildFallback(BuildContext context) {
    if (fallbackText != null && fallbackText!.isNotEmpty) {
      return Text(
        fallbackText!,
        maxLines: 1,
        overflow: TextOverflow.clip,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: foregroundColor ?? Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.w600,
          fontSize: size * 0.4,
        ),
      );
    }

    if (fallbackIcon != null) {
      return IconTheme(
        data: IconThemeData(
          color: foregroundColor ?? Theme.of(context).colorScheme.onSurface,
          size: size * 0.5,
        ),
        child: fallbackIcon!,
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildContent(BuildContext context) {
    if (imageProvider == null) {
      return _buildFallback(context);
    }

    return Image(
      image: imageProvider!,
      width: size,
      height: size,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return _buildFallback(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final avatar = Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
      ),
      clipBehavior: Clip.antiAlias,
      child: _buildContent(context),
    );

    if (semanticLabel == null || semanticLabel!.isEmpty) {
      return avatar;
    }

    return Semantics(
      label: semanticLabel,
      image: imageProvider != null,
      child: avatar,
    );
  }
}