import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PCard', () {
    testWidgets('should display child', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PCard(
              child: const Text('محتوای کارت'),
            ),
          ),
        ),
      );

      expect(find.text('محتوای کارت'), findsOneWidget);
    });

    testWidgets('should use default padding', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PCard(
              child: const Text('کارت'),
            ),
          ),
        ),
      );

      final PCard card = tester.widget<PCard>(
        find.byType(PCard),
      );

      expect(
        card.padding,
        const EdgeInsets.all(PSpacing.lg),
      );
    });

    testWidgets('should support custom padding', (
      WidgetTester tester,
    ) async {
      const EdgeInsets customPadding = EdgeInsets.all(24);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PCard(
              padding: customPadding,
              child: const Text('کارت'),
            ),
          ),
        ),
      );

      final PCard card = tester.widget<PCard>(
        find.byType(PCard),
      );

      expect(
        card.padding,
        customPadding,
      );
    });

    testWidgets('should support custom margin', (
      WidgetTester tester,
    ) async {
      const EdgeInsets customMargin = EdgeInsets.all(20);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PCard(
              margin: customMargin,
              child: const Text('کارت'),
            ),
          ),
        ),
      );

      final PCard card = tester.widget<PCard>(
        find.byType(PCard),
      );

      expect(
        card.margin,
        customMargin,
      );
    });

    testWidgets('should support custom color', (
      WidgetTester tester,
    ) async {
      const Color customColor = Color(0xFFFF0000);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PCard(
              color: customColor,
              child: const Text('کارت'),
            ),
          ),
        ),
      );

      final PCard card = tester.widget<PCard>(
        find.byType(PCard),
      );

      expect(
        card.color,
        customColor,
      );
    });

    testWidgets('should support custom border radius', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PCard(
              borderRadius: 20,
              child: const Text('کارت'),
            ),
          ),
        ),
      );

      final PCard card = tester.widget<PCard>(
        find.byType(PCard),
      );

      expect(
        card.borderRadius,
        20,
      );
    });

    testWidgets('should support custom border', (
      WidgetTester tester,
    ) async {
      const Border customBorder = Border.fromBorderSide(
        BorderSide(
          color: PColors.primary,
          width: 2,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PCard(
              border: customBorder,
              child: const Text('کارت'),
            ),
          ),
        ),
      );

      final PCard card = tester.widget<PCard>(
        find.byType(PCard),
      );

      expect(
        card.border,
        customBorder,
      );
    });

    testWidgets('should have no shadow when elevation is zero', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PCard(
              elevation: 0,
              child: const Text('کارت'),
            ),
          ),
        ),
      );

      final PCard card = tester.widget<PCard>(
        find.byType(PCard),
      );

      expect(card.elevation, 0);
    });

    testWidgets(
      'should create shadow when elevation is greater than zero',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PCard(
                elevation: 4,
                child: const Text('کارت'),
              ),
            ),
          ),
        );

        final PCard card = tester.widget<PCard>(
          find.byType(PCard),
        );

        expect(card.elevation, greaterThan(0));

        final Container container = tester.widget<Container>(
          find.descendant(
            of: find.byType(PCard),
            matching: find.byType(Container),
          ),
        );

        final BoxDecoration decoration =
            container.decoration! as BoxDecoration;

        expect(decoration.boxShadow, isNotNull);
        expect(decoration.boxShadow, hasLength(1));
      },
    );
  });
}