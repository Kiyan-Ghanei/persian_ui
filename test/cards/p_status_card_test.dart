import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PStatusCard', () {
    testWidgets('should display title', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PStatusCard(
              title: 'وضعیت حساب',
              status: PStatus.success,
            ),
          ),
        ),
      );

      expect(find.text('وضعیت حساب'), findsOneWidget);
    });

    testWidgets('should display description when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PStatusCard(
              title: 'وضعیت حساب',
              description: 'حساب شما فعال است.',
              status: PStatus.success,
            ),
          ),
        ),
      );

      expect(
        find.text('حساب شما فعال است.'),
        findsOneWidget,
      );
    });

    testWidgets('should not display description when not provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PStatusCard(
              title: 'وضعیت حساب',
              status: PStatus.success,
            ),
          ),
        ),
      );

      expect(
        find.text('حساب شما فعال است.'),
        findsNothing,
      );
    });

    testWidgets('should display default success icon', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PStatusCard(
              title: 'موفق',
              status: PStatus.success,
            ),
          ),
        ),
      );

      expect(
        find.byIcon(Icons.check_circle_outline),
        findsOneWidget,
      );
    });

    testWidgets('should display default warning icon', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PStatusCard(
              title: 'هشدار',
              status: PStatus.warning,
            ),
          ),
        ),
      );

      expect(
        find.byIcon(Icons.warning_amber_outlined),
        findsOneWidget,
      );
    });

    testWidgets('should display default error icon', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PStatusCard(
              title: 'خطا',
              status: PStatus.error,
            ),
          ),
        ),
      );

      expect(
        find.byIcon(Icons.error_outline),
        findsOneWidget,
      );
    });

    testWidgets('should display default info icon', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PStatusCard(
              title: 'اطلاعات',
              status: PStatus.info,
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
            body: PStatusCard(
              title: 'وضعیت',
              status: PStatus.success,
              icon: Icons.star,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(
        find.byIcon(Icons.check_circle_outline),
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
            body: PStatusCard(
              title: 'وضعیت',
              status: PStatus.info,
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
            body: PStatusCard(
              title: 'وضعیت',
              status: PStatus.info,
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
  });
}