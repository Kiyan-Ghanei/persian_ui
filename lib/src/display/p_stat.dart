import 'package:flutter/material.dart';

/// A compact, responsive statistic display for presenting a value and label.
///
/// The component is presentation-only and does not contain business logic.
/// It adapts naturally to the constraints provided by its parent and respects
/// the ambient text direction.
class PStat extends StatelessWidget {
  const PStat({
    super.key,
    required this.value,
    required this.label,
    this.icon,
    this.color,
    this.subtitle,
  });

  /// The primary statistic value, such as `125`, `85%`, or `4.8`.
  final String value;

  /// The label describing [value].
  final String label;

  /// Optional visual icon displayed above the statistic value.
  final Widget? icon;

  /// Optional accent color used for the icon and statistic value.
  final Color? color;

  /// Optional secondary content displayed below the label.
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final valueStyle = theme.textTheme.headlineSmall?.copyWith(
      color: color,
      fontWeight: FontWeight.bold,
    );

    final iconColor = color ?? theme.colorScheme.primary;

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null) ...[
          IconTheme(
            data: IconThemeData(
              color: iconColor,
            ),
            child: icon!,
          ),
          const SizedBox(height: 8),
        ],
        Text(
          value,
          textAlign: TextAlign.center,
          style: valueStyle,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          softWrap: true,
          style: theme.textTheme.bodyMedium,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          subtitle!,
        ],
      ],
    );

    return Semantics(
      container: true,
      explicitChildNodes: false,
      label: '$value، $label',
      child: SingleChildScrollView(
        child: content,
      ),
    );
  }
}