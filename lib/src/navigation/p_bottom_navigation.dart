import 'package:flutter/material.dart';

/// A single item used by [PBottomNavigation].
class PBottomNavigationItem {
  const PBottomNavigationItem({
    required this.icon,
    required this.label,
    this.selectedIcon,
  });

  final Widget icon;
  final String label;
  final Widget? selectedIcon;
}

/// A reusable bottom navigation component for PersianUI.
///
/// [PBottomNavigation] wraps Flutter's [NavigationBar] with a simple,
/// reusable API suitable for Persian and RTL applications.
class PBottomNavigation extends StatelessWidget {
  const PBottomNavigation({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
    this.backgroundColor,
    this.indicatorColor,
    this.height,
    this.labelBehavior,
  });

  final List<PBottomNavigationItem> items;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final double? height;
  final NavigationDestinationLabelBehavior? labelBehavior;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onChanged,
      backgroundColor: backgroundColor,
      indicatorColor: indicatorColor,
      height: height,
      labelBehavior: labelBehavior,
      destinations: items.map(
        (PBottomNavigationItem item) {
          return NavigationDestination(
            icon: item.icon,
            selectedIcon: item.selectedIcon,
            label: item.label,
          );
        },
      ).toList(),
    );
  }
}