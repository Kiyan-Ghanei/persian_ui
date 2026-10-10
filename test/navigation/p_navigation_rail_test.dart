import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  Widget buildTestWidget({
    required Widget child,
    TextDirection textDirection = TextDirection.rtl,
  }) {
    return MaterialApp(
      home: Directionality(
        textDirection: textDirection,
        child: Scaffold(
          body: child,
        ),
      ),
    );
  }

  const items = [
    PNavigationRailItem(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'خانه',
    ),
    PNavigationRailItem(
      icon: Icon(Icons.settings_outlined),
      selectedIcon: Icon(Icons.settings),
      label: 'تنظیمات',
    ),
    PNavigationRailItem(
      icon: Icon(Icons.person_outline),
      selectedIcon: Icon(Icons.person),
      label: 'پروفایل',
    ),
  ];

  testWidgets('renders navigation rail', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        child: PNavigationRail(
          items: items,
          selectedIndex: 0,
          onChanged: (_) {},
        ),
      ),
    );

    expect(find.byType(PNavigationRail), findsOneWidget);
    expect(find.byType(NavigationRail), findsOneWidget);
  });

  testWidgets('renders all destination labels', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        child: PNavigationRail(
          items: items,
          selectedIndex: 0,
          onChanged: (_) {},
          labelType: NavigationRailLabelType.all,
        ),
      ),
    );

    expect(find.text('خانه'), findsOneWidget);
    expect(find.text('تنظیمات'), findsOneWidget);
    expect(find.text('پروفایل'), findsOneWidget);
  });

  testWidgets('uses selected index', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        child: PNavigationRail(
          items: items,
          selectedIndex: 1,
          onChanged: (_) {},
        ),
      ),
    );

    final rail = tester.widget<NavigationRail>(
      find.byType(NavigationRail),
    );

    expect(rail.selectedIndex, 1);
  });

  testWidgets('calls onChanged when enabled destination is selected', (
    tester,
  ) async {
    var selectedIndex = -1;

    await tester.pumpWidget(
      buildTestWidget(
        child: PNavigationRail(
          items: items,
          selectedIndex: 0,
          onChanged: (index) {
            selectedIndex = index;
          },
          labelType: NavigationRailLabelType.all,
        ),
      ),
    );

    await tester.tap(find.text('تنظیمات'));
    await tester.pump();

    expect(selectedIndex, 1);
  });

  testWidgets('does not call onChanged for disabled destination', (
    tester,
  ) async {
    var selectedIndex = -1;

    const disabledItems = [
      PNavigationRailItem(
        icon: Icon(Icons.home_outlined),
        label: 'خانه',
      ),
      PNavigationRailItem(
        icon: Icon(Icons.settings_outlined),
        label: 'تنظیمات',
        enabled: false,
      ),
    ];

    await tester.pumpWidget(
      buildTestWidget(
        child: PNavigationRail(
          items: disabledItems,
          selectedIndex: 0,
          onChanged: (index) {
            selectedIndex = index;
          },
          labelType: NavigationRailLabelType.all,
        ),
      ),
    );

    final rail = tester.widget<NavigationRail>(
      find.byType(NavigationRail),
    );

    expect(rail.destinations[1].disabled, isTrue);

    await tester.tap(find.text('تنظیمات'));
    await tester.pump();

    expect(selectedIndex, -1);
  });

  testWidgets('renders selected icon configuration', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        child: PNavigationRail(
          items: items,
          selectedIndex: 0,
          onChanged: (_) {},
        ),
      ),
    );

    final rail = tester.widget<NavigationRail>(
      find.byType(NavigationRail),
    );

    expect(rail.destinations[0].selectedIcon, isNotNull);
    expect(rail.destinations[1].selectedIcon, isNotNull);
  });

  testWidgets('supports extended mode', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        child: PNavigationRail(
          items: items,
          selectedIndex: 0,
          onChanged: (_) {},
          extended: true,
        ),
      ),
    );

    final rail = tester.widget<NavigationRail>(
      find.byType(NavigationRail),
    );

    expect(rail.extended, isTrue);
  });

  testWidgets('supports label type', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        child: PNavigationRail(
          items: items,
          selectedIndex: 0,
          onChanged: (_) {},
          labelType: NavigationRailLabelType.selected,
        ),
      ),
    );

    final rail = tester.widget<NavigationRail>(
      find.byType(NavigationRail),
    );

    expect(
      rail.labelType,
      NavigationRailLabelType.selected,
    );
  });

  testWidgets('supports custom colors', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        child: PNavigationRail(
          items: items,
          selectedIndex: 0,
          onChanged: (_) {},
          backgroundColor: Colors.black,
          indicatorColor: Colors.white,
        ),
      ),
    );

    final rail = tester.widget<NavigationRail>(
      find.byType(NavigationRail),
    );

    expect(rail.backgroundColor, Colors.black);
    expect(rail.indicatorColor, Colors.white);
  });

  testWidgets('supports leading and trailing widgets', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        child: PNavigationRail(
          items: items,
          selectedIndex: 0,
          onChanged: (_) {},
          leading: const Icon(Icons.menu),
          trailing: const Icon(Icons.logout),
        ),
      ),
    );

    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.byIcon(Icons.logout), findsOneWidget);
  });

  testWidgets('clamps selected index above the valid range', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        child: PNavigationRail(
          items: items,
          selectedIndex: 100,
          onChanged: (_) {},
        ),
      ),
    );

    final rail = tester.widget<NavigationRail>(
      find.byType(NavigationRail),
    );

    expect(rail.selectedIndex, 2);
  });

  testWidgets('clamps negative selected index to zero', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        child: PNavigationRail(
          items: items,
          selectedIndex: -10,
          onChanged: (_) {},
        ),
      ),
    );

    final rail = tester.widget<NavigationRail>(
      find.byType(NavigationRail),
    );

    expect(rail.selectedIndex, 0);
  });

  testWidgets('supports empty items safely', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        child: const PNavigationRail(
          items: [],
          selectedIndex: 0,
          onChanged: _noop,
        ),
      ),
    );

    final rail = tester.widget<NavigationRail>(
      find.byType(NavigationRail),
    );

    expect(rail.destinations, isEmpty);
    expect(rail.selectedIndex, isNull);
  });

  testWidgets('supports LTR direction', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        textDirection: TextDirection.ltr,
        child: const PNavigationRail(
          items: [
            PNavigationRailItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            PNavigationRailItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Settings',
            ),
          ],
          selectedIndex: 0,
          onChanged: _noop,
          labelType: NavigationRailLabelType.all,
        ),
      ),
    );

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });

  testWidgets('supports RTL direction', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        textDirection: TextDirection.rtl,
        child: const PNavigationRail(
          items: [
            PNavigationRailItem(
              icon: Icon(Icons.home_outlined),
              label: 'خانه',
            ),
            PNavigationRailItem(
              icon: Icon(Icons.settings_outlined),
              label: 'تنظیمات',
            ),
          ],
          selectedIndex: 0,
          onChanged: _noop,
          labelType: NavigationRailLabelType.all,
        ),
      ),
    );

    expect(find.text('خانه'), findsOneWidget);
    expect(find.text('تنظیمات'), findsOneWidget);
  });
}

void _noop(int index) {}