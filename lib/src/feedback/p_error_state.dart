import 'package:flutter/material.dart';

import '../foundation/spacing/p_spacing.dart';

/// A reusable error-state layout for displaying an error or failed state.
///
/// The component is presentation-only and does not contain business logic.
/// Any widget can be supplied as [action], making the component independent
/// from specific button implementations.
///
/// The layout adapts to the constraints provided by its parent and supports
/// constrained vertical spaces without causing a RenderFlex overflow.
class PErrorState extends StatelessWidget {
  /// Creates an error state.
  const PErrorState({
    super.key,
    this.icon,
    required this.title,
    this.description,
    this.action,
    this.padding,
  });

  /// Optional visual representation shown above the title.
  final Widget? icon;

  /// Main error-state title.
  final Widget title;

  /// Optional supporting description shown below the title.
  final Widget? description;

  /// Optional action widget shown below the description.
  final Widget? action;

  /// Optional outer padding.
  ///
  /// When omitted, the component uses the library's standard spacing.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          icon!,
          const SizedBox(height: PSpacing.lg),
        ],
        title,
        if (description != null) ...[
          const SizedBox(height: PSpacing.sm),
          description!,
        ],
        if (action != null) ...[
          const SizedBox(height: PSpacing.lg),
          action!,
        ],
      ],
    );

    return Padding(
      padding: padding ?? const EdgeInsets.all(PSpacing.lg),
      child: Center(
        child: SingleChildScrollView(
          child: content,
        ),
      ),
    );
  }
}