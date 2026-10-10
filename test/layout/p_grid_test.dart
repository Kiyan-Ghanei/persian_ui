
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PGrid', () {
    testWidgets('renders all children', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PGrid(
            crossAxisCount: 2,
            children: [
              Text('First'),
              Text('Second'),
              Text('Third'),
              Text('Fourth'),
            ],
          ),
        ),
      );

      expect(find.text('First'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);
      expect(find.text('Third'), findsOneWidget);
      expect(find.text('Fourth'), findsOneWidget);
    });

    testWidgets('uses default values', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PGrid(
            crossAxisCount: 2,
            children: [Text('Content')],
          ),
        ),
      );

      final grid = tester.widget<PGrid>(find.byType(PGrid));

      expect(grid.crossAxisCount, 2);
      expect(grid.mainAxisSpacing, 0);
      expect(grid.crossAxisSpacing, 0);
      expect(grid.childAspectRatio, 1.0);
      expect(grid.padding, isNull);
      expect(grid.physics, isNull);
      expect(grid.shrinkWrap, isTrue);
    });

    testWidgets('configures cross axis count', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PGrid(
            crossAxisCount: 3,
            children: [
              Text('First'),
              Text('Second'),
              Text('Third'),
            ],
          ),
        ),
      );

      final grid = tester.widget<GridView>(
        find.descendant(
          of: find.byType(PGrid),
          matching: find.byType(GridView),
        ),
      );

      final delegate =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

      expect(delegate.crossAxisCount, 3);
    });

    testWidgets('configures main axis spacing', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PGrid(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            children: [Text('First'), Text('Second')],
          ),
        ),
      );

      final grid = tester.widget<GridView>(
        find.descendant(
          of: find.byType(PGrid),
          matching: find.byType(GridView),
        ),
      );

      final delegate =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

      expect(delegate.mainAxisSpacing, 16);
    });

    testWidgets('configures cross axis spacing', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PGrid(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            children: [Text('First'), Text('Second')],
          ),
        ),
      );

      final grid = tester.widget<GridView>(
        find.descendant(
          of: find.byType(PGrid),
          matching: find.byType(GridView),
        ),
      );

      final delegate =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

      expect(delegate.crossAxisSpacing, 20);
    });

    testWidgets('configures child aspect ratio', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PGrid(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            children: [Text('First'), Text('Second')],
          ),
        ),
      );

      final grid = tester.widget<GridView>(
        find.descendant(
          of: find.byType(PGrid),
          matching: find.byType(GridView),
        ),
      );

      final delegate =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

      expect(delegate.childAspectRatio, 1.5);
    });

    testWidgets('lays out items in the configured number of columns', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SizedBox(
            width: 400,
            height: 500,
            child: PGrid(
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              children: [
                SizedBox(key: ValueKey('item-1')),
                SizedBox(key: ValueKey('item-2')),
                SizedBox(key: ValueKey('item-3')),
                SizedBox(key: ValueKey('item-4')),
              ],
            ),
          ),
        ),
      );

      final first = tester.getRect(find.byKey(const ValueKey('item-1')));
      final second = tester.getRect(find.byKey(const ValueKey('item-2')));
      final third = tester.getRect(find.byKey(const ValueKey('item-3')));
      final fourth = tester.getRect(find.byKey(const ValueKey('item-4')));

      expect(first.top, closeTo(second.top, 0.01));
      expect(third.top, closeTo(fourth.top, 0.01));
      expect(third.top, greaterThan(first.top));
      expect(fourth.top, greaterThan(second.top));
    });

    testWidgets('applies cross axis spacing to item geometry', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SizedBox(
            width: 400,
            height: 500,
            child: PGrid(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              padding: EdgeInsets.zero,
              children: [
                SizedBox(key: ValueKey('item-1')),
                SizedBox(key: ValueKey('item-2')),
              ],
            ),
          ),
        ),
      );

      final first = tester.getRect(find.byKey(const ValueKey('item-1')));
      final second = tester.getRect(find.byKey(const ValueKey('item-2')));

      final leftItem = first.left < second.left ? first : second;
      final rightItem = first.left < second.left ? second : first;

      expect(
        rightItem.left - leftItem.right,
        closeTo(20, 0.01),
      );
    });

    testWidgets('applies main axis spacing to item geometry', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SizedBox(
            width: 400,
            height: 500,
            child: PGrid(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              padding: EdgeInsets.zero,
              children: [
                SizedBox(key: ValueKey('item-1')),
                SizedBox(key: ValueKey('item-2')),
                SizedBox(key: ValueKey('item-3')),
              ],
            ),
          ),
        ),
      );

      final first = tester.getRect(find.byKey(const ValueKey('item-1')));
      final third = tester.getRect(find.byKey(const ValueKey('item-3')));

      expect(
        third.top - first.bottom,
        closeTo(12, 0.01),
      );
    });

    testWidgets('applies child aspect ratio to item geometry', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SizedBox(
            width: 400,
            height: 500,
            child: PGrid(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              childAspectRatio: 2,
              padding: EdgeInsets.zero,
              children: [
                SizedBox(key: ValueKey('item-1')),
              ],
            ),
          ),
        ),
      );

      final item = tester.getSize(
        find.byKey(const ValueKey('item-1')),
      );

      expect(item.width, greaterThan(0));
      expect(item.height, greaterThan(0));
      expect(item.width / item.height, closeTo(2, 0.01));
    });

    testWidgets('supports padding', (tester) async {
      const padding = EdgeInsets.all(16);

      await tester.pumpWidget(
        const MaterialApp(
          home: PGrid(
            crossAxisCount: 2,
            padding: padding,
            children: [Text('Content')],
          ),
        ),
      );

      final grid = tester.widget<PGrid>(find.byType(PGrid));

      expect(grid.padding, padding);
    });

    testWidgets('supports custom physics', (tester) async {
      const physics = NeverScrollableScrollPhysics();

      await tester.pumpWidget(
        const MaterialApp(
          home: PGrid(
            crossAxisCount: 2,
            physics: physics,
            children: [Text('Content')],
          ),
        ),
      );

      final pGrid = tester.widget<PGrid>(find.byType(PGrid));

      expect(pGrid.physics, same(physics));

      final grid = tester.widget<GridView>(
        find.descendant(
          of: find.byType(PGrid),
          matching: find.byType(GridView),
        ),
      );

      expect(grid.physics, same(physics));
    });

    testWidgets('supports shrinkWrap configuration', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PGrid(
            crossAxisCount: 2,
            shrinkWrap: false,
            children: [Text('Content')],
          ),
        ),
      );

      final pGrid = tester.widget<PGrid>(find.byType(PGrid));

      expect(pGrid.shrinkWrap, isFalse);

      final grid = tester.widget<GridView>(
        find.descendant(
          of: find.byType(PGrid),
          matching: find.byType(GridView),
        ),
      );

      expect(grid.shrinkWrap, isFalse);
    });

    testWidgets('supports empty children list', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PGrid(
            crossAxisCount: 2,
            children: [],
          ),
        ),
      );

      expect(find.byType(PGrid), findsOneWidget);

      expect(
        find.descendant(
          of: find.byType(PGrid),
          matching: find.byType(GridView),
        ),
        findsOneWidget,
      );
    });

    test('rejects zero crossAxisCount', () {
      expect(
        () => PGrid(
          crossAxisCount: 0,
          children: const [],
        ),
        throwsAssertionError,
      );
    });

    test('rejects negative mainAxisSpacing', () {
      expect(
        () => PGrid(
          crossAxisCount: 2,
          mainAxisSpacing: -1,
          children: const [],
        ),
        throwsAssertionError,
      );
    });

    test('rejects negative crossAxisSpacing', () {
      expect(
        () => PGrid(
          crossAxisCount: 2,
          crossAxisSpacing: -1,
          children: const [],
        ),
        throwsAssertionError,
      );
    });

    test('rejects zero childAspectRatio', () {
      expect(
        () => PGrid(
          crossAxisCount: 2,
          childAspectRatio: 0,
          children: const [],
        ),
        throwsAssertionError,
      );
    });

    test('allows zero spacing values', () {
      const grid = PGrid(
        crossAxisCount: 2,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        children: [],
      );

      expect(grid.mainAxisSpacing, 0);
      expect(grid.crossAxisSpacing, 0);
    });

    testWidgets('works with RTL directionality', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: PGrid(
              crossAxisCount: 2,
              children: [Text('اول'), Text('دوم')],
            ),
          ),
        ),
      );

      expect(find.text('اول'), findsOneWidget);
      expect(find.text('دوم'), findsOneWidget);
    });

    testWidgets('places the first item on the right in RTL', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: SizedBox(
              width: 400,
              height: 300,
              child: PGrid(
                crossAxisCount: 2,
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(key: ValueKey('first')),
                  SizedBox(key: ValueKey('second')),
                ],
              ),
            ),
          ),
        ),
      );

      final first = tester.getRect(find.byKey(const ValueKey('first')));
      final second = tester.getRect(find.byKey(const ValueKey('second')));

      expect(first.top, closeTo(second.top, 0.01));
      expect(first.left, greaterThan(second.left));
    });

    testWidgets('places the first item on the left in LTR', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: SizedBox(
              width: 400,
              height: 300,
              child: PGrid(
                crossAxisCount: 2,
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(key: ValueKey('first')),
                  SizedBox(key: ValueKey('second')),
                ],
              ),
            ),
          ),
        ),
      );

      final first = tester.getRect(find.byKey(const ValueKey('first')));
      final second = tester.getRect(find.byKey(const ValueKey('second')));

      expect(first.top, closeTo(second.top, 0.01));
      expect(first.left, lessThan(second.left));
    });
  });
}