import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PToast', () {
    testWidgets('should display message', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PToast(
              message: 'عملیات موفق بود',
              type: PToastType.success,
            ),
          ),
        ),
      );

      expect(find.text('عملیات موفق بود'), findsOneWidget);
    });

    testWidgets('should display success icon by default', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PToast(
              message: 'موفق',
              type: PToastType.success,
            ),
          ),
        ),
      );

      expect(
        find.byIcon(Icons.check_circle_outline),
        findsOneWidget,
      );
    });

    testWidgets('should display warning icon by default', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PToast(
              message: 'هشدار',
              type: PToastType.warning,
            ),
          ),
        ),
      );

      expect(
        find.byIcon(Icons.warning_amber_outlined),
        findsOneWidget,
      );
    });

    testWidgets('should display error icon by default', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PToast(
              message: 'خطا',
              type: PToastType.error,
            ),
          ),
        ),
      );

      expect(
        find.byIcon(Icons.error_outline),
        findsOneWidget,
      );
    });

    testWidgets('should display info icon by default', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PToast(
              message: 'اطلاعات',
              type: PToastType.info,
            ),
          ),
        ),
      );

      expect(
        find.byIcon(Icons.info_outline),
        findsOneWidget,
      );
    });

    testWidgets('should support custom icon', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PToast(
              message: 'پیام',
              type: PToastType.info,
              icon: Icons.star,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(
        find.byIcon(Icons.info_outline),
        findsNothing,
      );
    });

    testWidgets('should support custom border radius', (
      WidgetTester tester,
    ) async {
      const double customRadius = 20.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PToast(
              message: 'پیام',
              type: PToastType.info,
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
            body: PToast(
              message: 'پیام',
              type: PToastType.info,
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

    testWidgets('should use white text', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PToast(
              message: 'پیام',
              type: PToastType.success,
            ),
          ),
        ),
      );

      final Text text = tester.widget<Text>(
        find.text('پیام'),
      );

      expect(text.style?.color, PColors.white);
    });
  });
}