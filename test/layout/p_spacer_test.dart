
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PSpacer', () {
    testWidgets('renders as SizedBox', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PSpacer(),
        ),
      );

      expect(find.byType(PSpacer), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(PSpacer),
          matching: find.byType(SizedBox),
        ),
        findsOneWidget,
      );
    });

    testWidgets('uses null dimensions by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PSpacer(),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(PSpacer),
          matching: find.byType(SizedBox),
        ),
      );

      expect(sizedBox.height, isNull);
      expect(sizedBox.width, isNull);
    });

    testWidgets('supports fixed height', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PSpacer(height: 24),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(PSpacer),
          matching: find.byType(SizedBox),
        ),
      );

      expect(sizedBox.height, 24);
      expect(sizedBox.width, isNull);
    });

    testWidgets('supports fixed width', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PSpacer(width: 32),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(PSpacer),
          matching: find.byType(SizedBox),
        ),
      );

      expect(sizedBox.width, 32);
      expect(sizedBox.height, isNull);
    });

    testWidgets('supports both width and height', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PSpacer(
            width: 16,
            height: 24,
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(PSpacer),
          matching: find.byType(SizedBox),
        ),
      );

      expect(sizedBox.width, 16);
      expect(sizedBox.height, 24);
    });

    testWidgets('supports zero dimensions', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PSpacer(
            width: 0,
            height: 0,
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(PSpacer),
          matching: find.byType(SizedBox),
        ),
      );

      expect(sizedBox.width, 0);
      expect(sizedBox.height, 0);
    });

    testWidgets('applies fixed dimensions to rendered layout', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Align(
            alignment: Alignment.topLeft,
            child: PSpacer(
              width: 32,
              height: 24,
            ),
          ),
        ),
      );

      final spacerRect = tester.getRect(find.byType(PSpacer));

      expect(spacerRect.width, 32);
      expect(spacerRect.height, 24);
    });

    testWidgets('works inside PColumn', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PColumn(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('First'),
              PSpacer(height: 16),
              Text('Second'),
            ],
          ),
        ),
      );

      expect(find.text('First'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);
      expect(find.byType(PSpacer), findsOneWidget);

      final firstRect = tester.getRect(find.text('First'));
      final spacerRect = tester.getRect(find.byType(PSpacer));
      final secondRect = tester.getRect(find.text('Second'));

      expect(
        spacerRect.top,
        closeTo(firstRect.bottom, 0.01),
      );
      expect(
        secondRect.top,
        closeTo(spacerRect.bottom, 0.01),
      );
    });

    testWidgets('works inside PRow', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PRow(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: ColoredBox(color: Colors.red),
              ),
              PSpacer(width: 16),
              SizedBox(
                width: 20,
                height: 20,
                child: ColoredBox(color: Colors.blue),
              ),
            ],
          ),
        ),
      );

      expect(find.byType(PSpacer), findsOneWidget);

      final firstRect = tester.getRect(
        find.byWidgetPredicate(
          (widget) =>
              widget is SizedBox &&
              widget.width == 20 &&
              widget.height == 20,
        ).first,
      );
      final spacerRect = tester.getRect(find.byType(PSpacer));
      final secondRect = tester.getRect(
        find.byWidgetPredicate(
          (widget) =>
              widget is SizedBox &&
              widget.width == 20 &&
              widget.height == 20,
        ).last,
      );

      expect(
        spacerRect.left,
        closeTo(firstRect.right, 0.01),
      );
      expect(
        secondRect.left,
        closeTo(spacerRect.right, 0.01),
      );
    });

    testWidgets('preserves fixed dimensions in RTL', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: PSpacer(
              width: 20,
              height: 12,
            ),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(PSpacer),
          matching: find.byType(SizedBox),
        ),
      );

      expect(sizedBox.width, 20);
      expect(sizedBox.height, 12);
    });

    testWidgets('preserves fixed dimensions in LTR', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: PSpacer(
              width: 20,
              height: 12,
            ),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(PSpacer),
          matching: find.byType(SizedBox),
        ),
      );

      expect(sizedBox.width, 20);
      expect(sizedBox.height, 12);
    });
  });
}