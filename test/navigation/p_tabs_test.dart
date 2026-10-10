import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  Widget buildTestApp({
    int initialIndex = 0,
    bool isScrollable = false,
    Color? indicatorColor,
    Color? labelColor,
    Color? unselectedLabelColor,
    ValueChanged<int>? onChanged,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: PTabs(
          tabs: const <String>[
            'اطلاعات',
            'فعالیت‌ها',
            'تنظیمات',
          ],
          views: const <Widget>[
            Center(child: Text('محتوای اطلاعات')),
            Center(child: Text('محتوای فعالیت‌ها')),
            Center(child: Text('محتوای تنظیمات')),
          ],
          initialIndex: initialIndex,
          isScrollable: isScrollable,
          indicatorColor: indicatorColor,
          labelColor: labelColor,
          unselectedLabelColor: unselectedLabelColor,
          onChanged: onChanged,
        ),
      ),
    );
  }

  testWidgets(
    'PTabs displays all tab labels',
    (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp());

      expect(find.text('اطلاعات'), findsOneWidget);
      expect(find.text('فعالیت‌ها'), findsOneWidget);
      expect(find.text('تنظیمات'), findsOneWidget);
    },
  );

  testWidgets(
    'PTabs displays initial tab content',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          initialIndex: 1,
        ),
      );

      expect(
        find.text('محتوای فعالیت‌ها'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'PTabs changes content when tab is tapped',
    (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp());

      await tester.tap(find.text('تنظیمات'));
      await tester.pumpAndSettle();

      expect(
        find.text('محتوای تنظیمات'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'PTabs calls onChanged',
    (WidgetTester tester) async {
      int? selectedIndex;

      await tester.pumpWidget(
        buildTestApp(
          onChanged: (int index) {
            selectedIndex = index;
          },
        ),
      );

      await tester.tap(find.text('فعالیت‌ها'));
      await tester.pumpAndSettle();

      expect(selectedIndex, 1);
    },
  );

  testWidgets(
    'PTabs supports scrollable mode',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          isScrollable: true,
        ),
      );

      final TabBar tabBar =
          tester.widget<TabBar>(find.byType(TabBar));

      expect(tabBar.isScrollable, isTrue);
    },
  );

  testWidgets(
    'PTabs supports indicator color',
    (WidgetTester tester) async {
      const Color indicatorColor = Colors.red;

      await tester.pumpWidget(
        buildTestApp(
          indicatorColor: indicatorColor,
        ),
      );

      final TabBar tabBar =
          tester.widget<TabBar>(find.byType(TabBar));

      expect(tabBar.indicatorColor, indicatorColor);
    },
  );

  testWidgets(
    'PTabs supports label color',
    (WidgetTester tester) async {
      const Color labelColor = Colors.green;

      await tester.pumpWidget(
        buildTestApp(
          labelColor: labelColor,
        ),
      );

      final TabBar tabBar =
          tester.widget<TabBar>(find.byType(TabBar));

      expect(tabBar.labelColor, labelColor);
    },
  );

  testWidgets(
    'PTabs supports unselected label color',
    (WidgetTester tester) async {
      const Color unselectedLabelColor = Colors.grey;

      await tester.pumpWidget(
        buildTestApp(
          unselectedLabelColor: unselectedLabelColor,
        ),
      );

      final TabBar tabBar =
          tester.widget<TabBar>(find.byType(TabBar));

      expect(
        tabBar.unselectedLabelColor,
        unselectedLabelColor,
      );
    },
  );

  testWidgets(
    'PTabs works in RTL direction',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.rtl,
          child: MaterialApp(
            home: Scaffold(
              body: PTabs(
                tabs: const <String>[
                  'اطلاعات',
                  'فعالیت‌ها',
                  'تنظیمات',
                ],
                views: const <Widget>[
                  Text('اطلاعات'),
                  Text('فعالیت‌ها'),
                  Text('تنظیمات'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(PTabs), findsOneWidget);
      expect(find.byType(TabBar), findsOneWidget);
      expect(find.byType(TabBarView), findsOneWidget);
    },
  );
}