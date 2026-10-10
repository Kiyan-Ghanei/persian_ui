import 'package:flutter/material.dart';

/// A single item displayed by [PDropdown].
///
/// [PDropdownItem] is immutable and supports both a plain text label and an
/// optional custom widget for the opened menu.
///
/// The [label] is used as the textual representation of the item and is also
/// displayed in the closed dropdown field after selection. [labelWidget], when
/// provided, customizes the item's appearance while the menu is open.
class PDropdownItem<T> {
  const PDropdownItem({
    required this.value,
    required this.label,
    this.labelWidget,
    this.enabled = true,
  });

  /// The value represented by this item.
  ///
  /// Values should be unique within a [PDropdown].
  final T value;

  /// The textual representation of this item.
  ///
  /// This text is displayed in the closed dropdown after the item is selected.
  final String label;

  /// Optional custom widget displayed for this item while the menu is open.
  final Widget? labelWidget;

  /// Whether this item can be selected.
  final bool enabled;
}

/// A reusable Material 3 dropdown designed for Persian and RTL interfaces.
///
/// [PDropdown] is a controlled component. The current selection is provided
/// through [value], and selection changes are reported through [onChanged].
///
/// When [onChanged] is null or [enabled] is false, the dropdown is disabled.
///
/// The component uses Flutter's Material 3 [DropdownMenu] internally and
/// inherits [Directionality] from its surrounding context, so it supports
/// both RTL and LTR layouts.
///
/// The component does not impose a fixed width or height.
class PDropdown<T> extends StatelessWidget {
  const PDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.label,
    this.hintText,
    this.padding,
    this.enabled = true,
  });

  /// The currently selected value.
  ///
  /// A null value means that no item is currently selected.
  final T? value;

  /// The items available for selection.
  ///
  /// Each item's [PDropdownItem.value] should be unique.
  final List<PDropdownItem<T>> items;

  /// Called when the user selects an item.
  ///
  /// The callback receives the selected item's value.
  ///
  /// When null, the dropdown is disabled.
  final ValueChanged<T?>? onChanged;

  /// Optional widget describing the dropdown field.
  final Widget? label;

  /// Optional text displayed when no item is selected.
  final String? hintText;

  /// Optional outer padding around the dropdown.
  final EdgeInsetsGeometry? padding;

  /// Whether the dropdown is interactive.
  ///
  /// When false, the dropdown is disabled regardless of [onChanged].
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final dropdown = DropdownMenu<T>(
      key: ValueKey<T?>(value),
      enabled: enabled && onChanged != null,
      label: label,
      hintText: hintText,
      initialSelection: value,
      onSelected: onChanged,
      selectOnly: true,
      enableFilter: false,
      enableSearch: true,
      dropdownMenuEntries: items
          .map(
            (item) => DropdownMenuEntry<T>(
              value: item.value,
              label: item.label,
              labelWidget: item.labelWidget,
              enabled: item.enabled,
            ),
          )
          .toList(growable: false),
    );

    if (padding == null) {
      return dropdown;
    }

    return Padding(
      padding: padding!,
      child: dropdown,
    );
  }
}