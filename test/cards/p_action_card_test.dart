import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PActionCard', () {
    testWidgets('should display title and action button', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PActionCard(
              title: 'تکمیل پروفایل',
              actionLabel: 'تکمیل کردن',
              onAction: () {},
            ),
          ),
        ),
      );

      expect(find.text('تکمیل پروفایل'), findsOneWidget);
      expect(find.text('تکمیل کردن'), findsOneWidget);
    });

    testWidgets('should display description when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PActionCard(
              title: 'عنوان',
              description: 'توضیحات کارت',
              actionLabel: 'ادامه',
              onAction: () {},
            ),
          ),
        ),
      );

      expect(find.text('توضیحات کارت'), findsOneWidget);
    });

    testWidgets('should not display description when not provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PActionCard(
              title: 'عنوان',
              actionLabel: 'ادامه',
              onAction: () {},
            ),
          ),
        ),
      );

      expect(find.text('توضیحات کارت'), findsNothing);
    });

    testWidgets('should display icon when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PActionCard(
              title: 'عنوان',
              icon: Icons.person,
              actionLabel: 'ادامه',
              onAction: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('should not display icon when not provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PActionCard(
              title: 'عنوان',
              actionLabel: 'ادامه',
              onAction: () {},
            ),
          ),
        ),
      );

      expect(find.byType(Icon), findsNothing);
    });

    testWidgets('should support custom color', (
      WidgetTester tester,
    ) async {
      const Color customColor = Color(0xFFE3F2FD);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PActionCard(
              title: 'عنوان',
              actionLabel: 'ادامه',
              onAction: () {},
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
            body: PActionCard(
              title: 'عنوان',
              icon: Icons.check,
              iconColor: customIconColor,
              actionLabel: 'ادامه',
              onAction: () {},
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
            body: PActionCard(
              title: 'عنوان',
              actionLabel: 'ادامه',
              onAction: () {},
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
            body: PActionCard(
              title: 'عنوان',
              actionLabel: 'ادامه',
              onAction: () {},
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

    testWidgets('should trigger action callback', (
      WidgetTester tester,
    ) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PActionCard(
              title: 'عنوان',
              actionLabel: 'انجام',
              onAction: () {
                pressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('انجام'));
      await tester.pump();

      expect(pressed, isTrue);
    });
  });
}