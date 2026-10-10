import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  const List<PBottomNavigationItem> items = <PBottomNavigationItem>[
    PBottomNavigationItem(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'خانه',
    ),
    PBottomNavigationItem(
      icon: Icon(Icons.search_outlined),
      selectedIcon: Icon(Icons.search),
      label: 'جستجو',
    ),
    PBottomNavigationItem(
      icon: Icon(Icons.person_outline),
      selectedIcon: Icon(Icons.person),
      label: 'پروفایل',
    ),
  ];

  Widget buildTestApp({
    int selectedIndex = 0,
    ValueChanged<int>? onChanged,
    Color? backgroundColor,
    Color? indicatorColor,
    double? height,
    NavigationDestinationLabelBehavior? labelBehavior,
  }) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: PBottomNavigation(
          items: items,
          selectedIndex: selectedIndex,
          onChanged: onChanged ?? (_) {},
          backgroundColor: backgroundColor,
          indicatorColor: indicatorColor,
          height: height,
          labelBehavior: labelBehavior,
        ),
      ),
    );
  }

  testWidgets(
    'PBottomNavigation displays all items',
    (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp());

      expect(find.text('خانه'), findsOneWidget);
      expect(find.text('جستجو'), findsOneWidget);
      expect(find.text('پروفایل'), findsOneWidget);
    },
  );

  testWidgets(
    'PBottomNavigation displays selected index',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          selectedIndex: 1,
        ),
      );

      final NavigationBar navigationBar =
          tester.widget<NavigationBar>(
        find.byType(NavigationBar),
      );

      expect(navigationBar.selectedIndex, 1);
    },
  );

  testWidgets(
    'PBottomNavigation calls onChanged',
    (WidgetTester tester) async {
      int? selectedIndex;

      await tester.pumpWidget(
        buildTestApp(
          onChanged: (int index) {
            selectedIndex = index;
          },
        ),
      );

      await tester.tap(find.text('جستجو'));
      await tester.pump();

      expect(selectedIndex, 1);
    },
  );

  testWidgets(
    'PBottomNavigation displays selected icon',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          selectedIndex: 0,
        ),
      );

      expect(
        find.byIcon(Icons.home),
        findsOneWidget,
      );

      expect(
        find.byIcon(Icons.search_outlined),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'PBottomNavigation supports background color',
    (WidgetTester tester) async {
      const Color backgroundColor = Colors.black;

      await tester.pumpWidget(
        buildTestApp(
          backgroundColor: backgroundColor,
        ),
      );

      final NavigationBar navigationBar =
          tester.widget<NavigationBar>(
        find.byType(NavigationBar),
      );

      expect(
        navigationBar.backgroundColor,
        backgroundColor,
      );
    },
  );

  testWidgets(
    'PBottomNavigation supports indicator color',
    (WidgetTester tester) async {
      const Color indicatorColor = Colors.orange;

      await tester.pumpWidget(
        buildTestApp(
          indicatorColor: indicatorColor,
        ),
      );

      final NavigationBar navigationBar =
          tester.widget<NavigationBar>(
        find.byType(NavigationBar),
      );

      expect(
        navigationBar.indicatorColor,
        indicatorColor,
      );
    },
  );

  testWidgets(
    'PBottomNavigation supports custom height',
    (WidgetTester tester) async {
      const double height = 80;

      await tester.pumpWidget(
        buildTestApp(
          height: height,
        ),
      );

      final NavigationBar navigationBar =
          tester.widget<NavigationBar>(
        find.byType(NavigationBar),
      );

      expect(
        navigationBar.height,
        height,
      );
    },
  );

  testWidgets(
    'PBottomNavigation supports label behavior',
    (WidgetTester tester) async {
      const NavigationDestinationLabelBehavior labelBehavior =
          NavigationDestinationLabelBehavior.alwaysHide;

      await tester.pumpWidget(
        buildTestApp(
          labelBehavior: labelBehavior,
        ),
      );

      final NavigationBar navigationBar =
          tester.widget<NavigationBar>(
        find.byType(NavigationBar),
      );

      expect(
        navigationBar.labelBehavior,
        labelBehavior,
      );
    },
  );

  testWidgets(
    'PBottomNavigation renders inside RTL directionality',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.rtl,
          child: MaterialApp(
            home: Scaffold(
              bottomNavigationBar: PBottomNavigation(
                items: items,
                selectedIndex: 0,
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      expect(
        find.byType(PBottomNavigation),
        findsOneWidget,
      );

      expect(
        find.byType(NavigationBar),
        findsOneWidget,
      );
    },
  );
}