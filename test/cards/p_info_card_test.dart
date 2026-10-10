import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PInfoCard', () {
    testWidgets('should display title and description', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PInfoCard(
              title: 'اطلاعات',
              description: 'این یک پیام اطلاعاتی است.',
            ),
          ),
        ),
      );

      expect(find.text('اطلاعات'), findsOneWidget);
      expect(
        find.text('این یک پیام اطلاعاتی است.'),
        findsOneWidget,
      );
    });

    testWidgets('should display icon when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PInfoCard(
              title: 'اطلاعات',
              icon: Icons.info_outline,
            ),
          ),
        ),
      );

      expect(
        find.byIcon(Icons.info_outline),
        findsOneWidget,
      );
    });

    testWidgets('should not display icon when not provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PInfoCard(
              title: 'اطلاعات',
            ),
          ),
        ),
      );

      expect(
        find.byType(Icon),
        findsNothing,
      );
    });

    testWidgets('should support custom color', (
      WidgetTester tester,
    ) async {
      const Color customColor = Color(0xFFE8F5E9);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PInfoCard(
              title: 'اطلاعات',
              color: customColor,
            ),
          ),
        ),
      );

      final Container container = tester.widget<Container>(
        find.byType(Container).first,
      );

      final BoxDecoration decoration =
          container.decoration! as BoxDecoration;

      expect(decoration.color, customColor);
    });

    testWidgets('should support custom icon color', (
      WidgetTester tester,
    ) async {
      const Color customIconColor = Color(0xFF2E7D32);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PInfoCard(
              icon: Icons.check,
              iconColor: customIconColor,
            ),
          ),
        ),
      );

      final Icon icon = tester.widget<Icon>(
        find.byIcon(Icons.check),
      );

      expect(icon.color, customIconColor);
    });

    testWidgets('should support custom border radius', (
      WidgetTester tester,
    ) async {
      const double customRadius = 20.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PInfoCard(
              title: 'اطلاعات',
              borderRadius: customRadius,
            ),
          ),
        ),
      );

      final Container container = tester.widget<Container>(
        find.byType(Container).first,
      );

      final BoxDecoration decoration =
          container.decoration! as BoxDecoration;

      expect(
        decoration.borderRadius,
        BorderRadius.circular(customRadius),
      );
    });

    testWidgets('should support custom padding', (
      WidgetTester tester,
    ) async {
      const EdgeInsets customPadding = EdgeInsets.all(24.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PInfoCard(
              title: 'اطلاعات',
              padding: customPadding,
            ),
          ),
        ),
      );

      final Container container = tester.widget<Container>(
        find.byType(Container).first,
      );

      expect(container.padding, customPadding);
    });

    testWidgets('should support title without description', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PInfoCard(
              title: 'عنوان',
            ),
          ),
        ),
      );

      expect(find.text('عنوان'), findsOneWidget);
    });

    testWidgets('should support description without title', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PInfoCard(
              description: 'توضیحات',
            ),
          ),
        ),
      );

      expect(find.text('توضیحات'), findsOneWidget);
    });
  });
}