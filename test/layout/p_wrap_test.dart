
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PWrap', () {
    testWidgets('renders its children', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PWrap(
              children: const [
                Text('First'),
                Text('Second'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('First'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);
      expect(find.byType(Wrap), findsOneWidget);
    });

    testWidgets('forwards layout properties to Wrap', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PWrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              spacing: 8,
              runAlignment: WrapAlignment.end,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              textDirection: TextDirection.rtl,
              verticalDirection: VerticalDirection.up,
              clipBehavior: Clip.hardEdge,
              children: const [
                Text('First'),
                Text('Second'),
              ],
            ),
          ),
        ),
      );

      final wrap = tester.widget<Wrap>(find.byType(Wrap));

      expect(wrap.direction, Axis.vertical);
      expect(wrap.alignment, WrapAlignment.center);
      expect(wrap.spacing, 8);
      expect(wrap.runAlignment, WrapAlignment.end);
      expect(wrap.runSpacing, 12);
      expect(wrap.crossAxisAlignment, WrapCrossAlignment.center);
      expect(wrap.textDirection, TextDirection.rtl);
      expect(wrap.verticalDirection, VerticalDirection.up);
      expect(wrap.clipBehavior, Clip.hardEdge);
    });

    testWidgets('uses ambient text direction when not specified', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: PWrap(
                children: const [
                  Text('First'),
                  Text('Second'),
                ],
              ),
            ),
          ),
        ),
      );

      final wrap = tester.widget<Wrap>(find.byType(Wrap));

      expect(wrap.textDirection, isNull);
      expect(
        Directionality.of(tester.element(find.byType(PWrap))),
        TextDirection.rtl,
      );
    });

    testWidgets('moves children to another run when space is insufficient', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 100,
              child: PWrap(
                spacing: 0,
                runSpacing: 8,
                children: const [
                  SizedBox(
                    key: Key('first'),
                    width: 60,
                    height: 20,
                  ),
                  SizedBox(
                    key: Key('second'),
                    width: 60,
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final firstPosition = tester.getTopLeft(
        find.byKey(const Key('first')),
      );
      final secondPosition = tester.getTopLeft(
        find.byKey(const Key('second')),
      );

      expect(secondPosition.dy, greaterThan(firstPosition.dy));
      expect(secondPosition.dy - firstPosition.dy, 28);
    });

    testWidgets('lays out children in RTL order', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: SizedBox(
                width: 100,
                child: PWrap(
                  children: const [
                    SizedBox(
                      key: Key('first'),
                      width: 40,
                      height: 20,
                    ),
                    SizedBox(
                      key: Key('second'),
                      width: 40,
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      final firstPosition = tester.getTopLeft(
        find.byKey(const Key('first')),
      );
      final secondPosition = tester.getTopLeft(
        find.byKey(const Key('second')),
      );

      expect(firstPosition.dx, greaterThan(secondPosition.dx));
      expect(firstPosition.dy, secondPosition.dy);
    });

    testWidgets('lays out children in LTR order', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Directionality(
              textDirection: TextDirection.ltr,
              child: SizedBox(
                width: 100,
                child: PWrap(
                  children: const [
                    SizedBox(
                      key: Key('first'),
                      width: 40,
                      height: 20,
                    ),
                    SizedBox(
                      key: Key('second'),
                      width: 40,
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      final firstPosition = tester.getTopLeft(
        find.byKey(const Key('first')),
      );
      final secondPosition = tester.getTopLeft(
        find.byKey(const Key('second')),
      );

      expect(firstPosition.dx, lessThan(secondPosition.dx));
      expect(firstPosition.dy, secondPosition.dy);
    });

    testWidgets('supports an empty children list', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PWrap(children: []),
          ),
        ),
      );

      expect(find.byType(PWrap), findsOneWidget);
      expect(find.byType(Wrap), findsOneWidget);
    });

    testWidgets('supports vertical wrapping', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 100,
              child: PWrap(
                direction: Axis.vertical,
                spacing: 8,
                children: const [
                  SizedBox(
                    key: Key('first'),
                    width: 20,
                    height: 60,
                  ),
                  SizedBox(
                    key: Key('second'),
                    width: 20,
                    height: 60,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final firstPosition = tester.getTopLeft(
        find.byKey(const Key('first')),
      );
      final secondPosition = tester.getTopLeft(
        find.byKey(const Key('second')),
      );

      expect(secondPosition.dx, greaterThan(firstPosition.dx));
    });

    test('rejects negative spacing', () {
      expect(
        () => PWrap(
          spacing: -1,
          children: const [],
        ),
        throwsAssertionError,
      );
    });

    test('rejects negative runSpacing', () {
      expect(
        () => PWrap(
          runSpacing: -1,
          children: const [],
        ),
        throwsAssertionError,
      );
    });
  });
}
