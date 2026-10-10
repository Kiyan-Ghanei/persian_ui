
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PColumn', () {
    testWidgets('renders all children', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PColumn(
            children: [
              Text('First'),
              Text('Second'),
              Text('Third'),
            ],
          ),
        ),
      );

      expect(find.text('First'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);
      expect(find.text('Third'), findsOneWidget);
    });

    testWidgets('uses default alignment values', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PColumn(
            children: [
              Text('Content'),
            ],
          ),
        ),
      );

      final column = tester.widget<Column>(
        find.descendant(
          of: find.byType(PColumn),
          matching: find.byType(Column),
        ),
      );

      expect(column.mainAxisAlignment, MainAxisAlignment.start);
      expect(column.mainAxisSize, MainAxisSize.max);
      expect(column.crossAxisAlignment, CrossAxisAlignment.center);
      expect(column.verticalDirection, VerticalDirection.down);
      expect(column.textDirection, isNull);
      expect(column.textBaseline, isNull);
    });

    testWidgets('supports custom main axis alignment', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PColumn(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('First'),
              Text('Second'),
            ],
          ),
        ),
      );

      final column = tester.widget<Column>(
        find.descendant(
          of: find.byType(PColumn),
          matching: find.byType(Column),
        ),
      );

      expect(
        column.mainAxisAlignment,
        MainAxisAlignment.spaceBetween,
      );
    });

    testWidgets('supports custom main axis size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PColumn(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Content'),
            ],
          ),
        ),
      );

      final column = tester.widget<Column>(
        find.descendant(
          of: find.byType(PColumn),
          matching: find.byType(Column),
        ),
      );

      expect(column.mainAxisSize, MainAxisSize.min);
    });

    testWidgets('supports custom cross axis alignment', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PColumn(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Content'),
            ],
          ),
        ),
      );

      final column = tester.widget<Column>(
        find.descendant(
          of: find.byType(PColumn),
          matching: find.byType(Column),
        ),
      );

      expect(
        column.crossAxisAlignment,
        CrossAxisAlignment.stretch,
      );
    });

    testWidgets('supports explicit text direction', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PColumn(
            textDirection: TextDirection.rtl,
            children: [
              Text('RTL'),
            ],
          ),
        ),
      );

      final column = tester.widget<Column>(
        find.descendant(
          of: find.byType(PColumn),
          matching: find.byType(Column),
        ),
      );

      expect(column.textDirection, TextDirection.rtl);
    });

    testWidgets('inherits ambient RTL directionality', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: PColumn(
              children: [
                Text('RTL'),
              ],
            ),
          ),
        ),
      );

      final column = tester.widget<Column>(
        find.descendant(
          of: find.byType(PColumn),
          matching: find.byType(Column),
        ),
      );

      expect(column.textDirection, isNull);

      final pColumnElement = tester.element(find.byType(PColumn));
      final directionality =
          pColumnElement.findAncestorWidgetOfExactType<Directionality>();

      expect(directionality, isNotNull);
      expect(directionality!.textDirection, TextDirection.rtl);
    });

    testWidgets('inherits ambient LTR directionality', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: PColumn(
              children: [
                Text('LTR'),
              ],
            ),
          ),
        ),
      );

      final column = tester.widget<Column>(
        find.descendant(
          of: find.byType(PColumn),
          matching: find.byType(Column),
        ),
      );

      expect(column.textDirection, isNull);

      final pColumnElement = tester.element(find.byType(PColumn));
      final directionality =
          pColumnElement.findAncestorWidgetOfExactType<Directionality>();

      expect(directionality, isNotNull);
      expect(directionality!.textDirection, TextDirection.ltr);
    });

    testWidgets('aligns children to start in RTL', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 200,
                height: 100,
                child: PColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      key: ValueKey('first'),
                      width: 40,
                      height: 20,
                    ),
                    SizedBox(
                      key: ValueKey('second'),
                      width: 60,
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      final columnRect = tester.getRect(find.byType(PColumn));
      final firstRect = tester.getRect(
        find.byKey(const ValueKey('first')),
      );
      final secondRect = tester.getRect(
        find.byKey(const ValueKey('second')),
      );

      expect(columnRect.width, 200);
      expect(firstRect.right, closeTo(columnRect.right, 0.01));
      expect(secondRect.right, closeTo(columnRect.right, 0.01));
    });

    testWidgets('aligns children to start in LTR', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 200,
                height: 100,
                child: PColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      key: ValueKey('first'),
                      width: 40,
                      height: 20,
                    ),
                    SizedBox(
                      key: ValueKey('second'),
                      width: 60,
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      final columnRect = tester.getRect(find.byType(PColumn));
      final firstRect = tester.getRect(
        find.byKey(const ValueKey('first')),
      );
      final secondRect = tester.getRect(
        find.byKey(const ValueKey('second')),
      );

      expect(columnRect.width, 200);
      expect(firstRect.left, closeTo(columnRect.left, 0.01));
      expect(secondRect.left, closeTo(columnRect.left, 0.01));
    });

    testWidgets('supports custom vertical direction', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PColumn(
            verticalDirection: VerticalDirection.up,
            children: [
              Text('Content'),
            ],
          ),
        ),
      );

      final column = tester.widget<Column>(
        find.descendant(
          of: find.byType(PColumn),
          matching: find.byType(Column),
        ),
      );

      expect(column.verticalDirection, VerticalDirection.up);
    });

    testWidgets('supports baseline configuration', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PColumn(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('First'),
              Text('Second'),
            ],
          ),
        ),
      );

      final column = tester.widget<Column>(
        find.descendant(
          of: find.byType(PColumn),
          matching: find.byType(Column),
        ),
      );

      expect(
        column.crossAxisAlignment,
        CrossAxisAlignment.baseline,
      );
      expect(column.textBaseline, TextBaseline.alphabetic);
    });

    testWidgets('supports empty children list', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PColumn(children: []),
        ),
      );

      expect(find.byType(PColumn), findsOneWidget);

      expect(
        find.descendant(
          of: find.byType(PColumn),
          matching: find.byType(Column),
        ),
        findsOneWidget,
      );
    });
  });
}