
import 'package:flutter/material.dart';

/// A reusable expandable content component.
///
/// [PExpandable] displays a tappable header and optionally reveals its
/// associated content with an animated transition.
///
/// The component manages its own expanded state after initialization and
/// exposes [onExpansionChanged] for observing state changes.
class PExpandable extends StatefulWidget {
  const PExpandable({
    super.key,
    required this.title,
    required this.child,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.leading,
    this.trailing,
    this.padding,
  });

  /// The title displayed in the expandable header.
  final Widget title;

  /// The content displayed when the component is expanded.
  final Widget child;

  /// Determines the initial expansion state.
  final bool initiallyExpanded;

  /// Called whenever the expansion state changes.
  final ValueChanged<bool>? onExpansionChanged;

  /// An optional widget displayed before the title.
  final Widget? leading;

  /// An optional custom trailing widget.
  ///
  /// When omitted, an animated expansion indicator is displayed.
  final Widget? trailing;

  /// Optional outer padding around the expandable component.
  final EdgeInsetsGeometry? padding;

  @override
  State<PExpandable> createState() => _PExpandableState();
}

class _PExpandableState extends State<PExpandable> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  void _toggleExpanded() {
    final nextValue = !_isExpanded;

    setState(() {
      _isExpanded = nextValue;
    });

    widget.onExpansionChanged?.call(nextValue);
  }

  @override
  Widget build(BuildContext context) {
    final indicator = widget.trailing ??
        AnimatedRotation(
          turns: _isExpanded ? 0.5 : 0,
          duration: const Duration(milliseconds: 200),
          child: const Icon(Icons.expand_more),
        );

    final header = Semantics(
      container: true,
      button: true,
      expanded: _isExpanded,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: _toggleExpanded,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.leading != null) ...[
                  widget.leading!,
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: widget.title,
                ),
                const SizedBox(width: 12),
                indicator,
              ],
            ),
          ),
        ),
      ),
    );

    final content = AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: _isExpanded
          ? Padding(
              padding: const EdgeInsets.only(
                bottom: 12,
              ),
              child: widget.child,
            )
          : const SizedBox.shrink(),
    );

    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header,
          content,
        ],
      ),
    );
  }
}
