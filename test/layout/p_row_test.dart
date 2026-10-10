
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/src/layout/p_row.dart';

void main() {
  group('PRow', () {
    testWidgets('renders all children', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PRow(
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
          home: PRow(
            children: [
              Text('Content'),
            ],
          ),
        ),
      );

      final row = tester.widget<Row>(find.byType(Row));

      expect(row.mainAxisAlignment, MainAxisAlignment.start);
      expect(row.mainAxisSize, MainAxisSize.max);
      expect(row.crossAxisAlignment, CrossAxisAlignment.center);
      expect(row.verticalDirection, VerticalDirection.down);
      expect(row.textDirection, isNull);
      expect(row.textBaseline, isNull);
    });

    testWidgets('applies custom main axis alignment', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('First'),
              Text('Second'),
            ],
          ),
        ),
      );

      final row = tester.widget<Row>(find.byType(Row));

      expect(
        row.mainAxisAlignment,
        MainAxisAlignment.spaceBetween,
      );
    });

    testWidgets('applies custom main axis size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PRow(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Content'),
            ],
          ),
        ),
      );

      final row = tester.widget<Row>(find.byType(Row));

      expect(row.mainAxisSize, MainAxisSize.min);
    });

    testWidgets('applies custom cross axis alignment', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PRow(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Content'),
            ],
          ),
        ),
      );

      final row = tester.widget<Row>(find.byType(Row));

      expect(
        row.crossAxisAlignment,
        CrossAxisAlignment.end,
      );
    });

    testWidgets('applies explicit text direction', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PRow(
            textDirection: TextDirection.rtl,
            children: [
              Text('Right'),
              Text('Left'),
            ],
          ),
        ),
      );

      final row = tester.widget<Row>(find.byType(Row));

      expect(row.textDirection, TextDirection.rtl);
    });

    testWidgets('supports ambient RTL directionality', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: PRow(
              children: [
                Text('First'),
                Text('Second'),
              ],
            ),
          ),
        ),
      );

      final row = tester.widget<Row>(find.byType(Row));

      expect(row.textDirection, isNull);

      final directionality = tester.widget<Directionality>(
        find
            .ancestor(
              of: find.byType(PRow),
              matching: find.byType(Directionality),
            )
            .first,
      );

      expect(directionality.textDirection, TextDirection.rtl);
    });

    testWidgets('supports ambient LTR directionality', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: PRow(
              children: [
                Text('First'),
                Text('Second'),
              ],
            ),
          ),
        ),
      );

      final row = tester.widget<Row>(find.byType(Row));

      expect(row.textDirection, isNull);

      final directionality = tester.widget<Directionality>(
        find
            .ancestor(
              of: find.byType(PRow),
              matching: find.byType(Directionality),
            )
            .first,
      );

      expect(directionality.textDirection, TextDirection.ltr);
    });

    testWidgets('lays out children in RTL order', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: Align(
              alignment: Alignment.topLeft,
              child: PRow(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    key: ValueKey('first'),
                    width: 40,
                    height: 20,
                  ),
                  SizedBox(
                    key: ValueKey('second'),
                    width: 40,
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final firstRect = tester.getRect(find.byKey(const ValueKey('first')));
      final secondRect = tester.getRect(find.byKey(const ValueKey('second')));

      expect(firstRect.left, greaterThan(secondRect.left));
    });

    testWidgets('lays out children in LTR order', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: Align(
              alignment: Alignment.topLeft,
              child: PRow(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    key: ValueKey('first'),
                    width: 40,
                    height: 20,
                  ),
                  SizedBox(
                    key: ValueKey('second'),
                    width: 40,
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final firstRect = tester.getRect(find.byKey(const ValueKey('first')));
      final secondRect = tester.getRect(find.byKey(const ValueKey('second')));

      expect(firstRect.left, lessThan(secondRect.left));
    });

    testWidgets('applies vertical direction', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PRow(
            verticalDirection: VerticalDirection.up,
            children: [
              Text('Content'),
            ],
          ),
        ),
      );

      final row = tester.widget<Row>(find.byType(Row));

      expect(row.verticalDirection, VerticalDirection.up);
    });

    testWidgets('supports baseline alignment and text baseline', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PRow(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('Text'),
              Text('Content'),
            ],
          ),
        ),
      );

      final row = tester.widget<Row>(find.byType(Row));

      expect(
        row.crossAxisAlignment,
        CrossAxisAlignment.baseline,
      );
      expect(row.textBaseline, TextBaseline.alphabetic);
    });

    testWidgets('supports empty children list', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PRow(children: []),
        ),
      );

      final row = tester.widget<Row>(find.byType(Row));

      expect(row.children, isEmpty);
    });
  });
}