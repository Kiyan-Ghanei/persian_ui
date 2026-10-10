
import 'package:flutter/material.dart';

/// A reusable section layout component for PersianUI.
///
/// [PSection] provides a consistent structure for a section with an
/// optional title, optional trailing action, and required content.
///
/// The component is intentionally focused on layout and does not provide
/// visual decoration such as colors, borders, shadows, or backgrounds.
class PSection extends StatelessWidget {
  /// Creates a PersianUI section.
  const PSection({
    super.key,
    this.title,
    this.trailing,
    required this.child,
    this.padding,
    this.margin,
  });

  /// Optional title displayed at the top of the section.
  final Widget? title;

  /// Optional widget displayed opposite the [title].
  ///
  /// This is useful for actions such as "View all", an icon button,
  /// or another contextual action.
  final Widget? trailing;

  /// The main content of the section.
  final Widget child;

  /// Empty space inside the section.
  final EdgeInsetsGeometry? padding;

  /// Empty space outside the section.
  final EdgeInsetsGeometry? margin;

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (title != null)
          Flexible(
            child: title!,
          ),
        if (trailing != null) ...[
          if (title != null)
            const SizedBox(width: 8),
          trailing!,
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasHeader = title != null || trailing != null;

    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (hasHeader) _buildHeader(),
        if (hasHeader) const SizedBox(height: 12),
        child,
      ],
    );

    if (padding != null) {
      content = Padding(
        padding: padding!,
        child: content,
      );
    }

    if (margin != null) {
      content = Padding(
        padding: margin!,
        child: content,
      );
    }

    return content;
  }
}
