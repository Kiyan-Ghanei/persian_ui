import 'package:flutter/material.dart';

/// Represents a single destination in a [PNavigationRail].
///
/// Each item contains an icon, a label, and optionally a different icon
/// for the selected state.
@immutable
class PNavigationRailItem {
  /// Creates a navigation rail item.
  const PNavigationRailItem({
    required this.icon,
    required this.label,
    this.selectedIcon,
    this.enabled = true,
  });

  /// Icon displayed when the item is not selected.
  final Widget icon;

  /// Icon displayed when the item is selected.
  ///
  /// If null, [icon] is used for both states.
  final Widget? selectedIcon;

  /// Text displayed for this destination.
  final String label;

  /// Whether this destination is interactive.
  final bool enabled;
}

/// A reusable Navigation Rail component for PersianUI.
///
/// [PNavigationRail] is a PersianUI wrapper around Flutter's
/// [NavigationRail], providing a consistent public API.
class PNavigationRail extends StatelessWidget {
  /// Creates a navigation rail.
  const PNavigationRail({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
    this.extended = false,
    this.labelType,
    this.backgroundColor,
    this.indicatorColor,
    this.minWidth,
    this.minExtendedWidth,
    this.groupAlignment,
    this.leading,
    this.trailing,
  });

  /// Navigation destinations displayed in the rail.
  final List<PNavigationRailItem> items;

  /// Index of the currently selected destination.
  final int selectedIndex;

  /// Called when an enabled destination is selected.
  final ValueChanged<int> onChanged;

  /// Whether the rail is displayed in its extended form.
  final bool extended;

  /// Controls how destination labels are displayed.
  final NavigationRailLabelType? labelType;

  /// Background color of the rail.
  final Color? backgroundColor;

  /// Color of the selected destination indicator.
  final Color? indicatorColor;

  /// Minimum width of the rail when it is not extended.
  final double? minWidth;

  /// Minimum width of the rail when it is extended.
  final double? minExtendedWidth;

  /// Alignment of the navigation destinations.
  final double? groupAlignment;

  /// Widget displayed above the navigation destinations.
  final Widget? leading;

  /// Widget displayed below the navigation destinations.
  final Widget? trailing;

  List<NavigationRailDestination> _buildDestinations() {
    return items
        .map(
          (item) => NavigationRailDestination(
            icon: item.icon,
            selectedIcon: item.selectedIcon,
            label: Text(item.label),
            disabled: !item.enabled,
          ),
        )
        .toList(growable: false);
  }

  int? _getSelectedIndex() {
    if (items.isEmpty) {
      return null;
    }

    return selectedIndex.clamp(0, items.length - 1);
  }

  void _handleDestinationSelected(int index) {
    if (items[index].enabled) {
      onChanged(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      extended: extended,
      labelType: labelType,
      backgroundColor: backgroundColor,
      indicatorColor: indicatorColor,
      minWidth: minWidth,
      minExtendedWidth: minExtendedWidth,
      groupAlignment: groupAlignment,
      leading: leading,
      trailing: trailing,
      selectedIndex: _getSelectedIndex(),
      destinations: _buildDestinations(),
      onDestinationSelected: _handleDestinationSelected,
    );
  }
}