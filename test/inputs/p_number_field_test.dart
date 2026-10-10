import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PNumberField', () {
    testWidgets('should display label and hint', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PNumberField(
              label: 'سن',
              hint: 'سن خود را وارد کنید',
            ),
          ),
        ),
      );

      expect(find.text('سن'), findsOneWidget);
      expect(
        find.text('سن خود را وارد کنید'),
        findsOneWidget,
      );
    });

    testWidgets('should accept numeric input', (
      WidgetTester tester,
    ) async {
      final TextEditingController controller =
          TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PNumberField(
              controller: controller,
            ),
          ),
        ),
      );

      await tester.enterText(
        find.byType(TextField),
        '123',
      );

      expect(controller.text, '123');

      controller.dispose();
    });

    testWidgets('should call onChanged', (
      WidgetTester tester,
    ) async {
      String? value;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PNumberField(
              onChanged: (String text) {
                value = text;
              },
            ),
          ),
        ),
      );

      await tester.enterText(
        find.byType(TextField),
        '25',
      );

      expect(value, '25');
    });

    testWidgets('should support Persian digits', (
      WidgetTester tester,
    ) async {
      final TextEditingController controller =
          TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PNumberField(
              controller: controller,
            ),
          ),
        ),
      );

      await tester.enterText(
        find.byType(TextField),
        '۱۲۳',
      );

      expect(controller.text, '۱۲۳');

      controller.dispose();
    });

    testWidgets('should support decimal numbers', (
      WidgetTester tester,
    ) async {
      final TextEditingController controller =
          TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PNumberField(
              controller: controller,
            ),
          ),
        ),
      );

      await tester.enterText(
        find.byType(TextField),
        '12.5',
      );

      expect(controller.text, '12.5');

      controller.dispose();
    });

    testWidgets('should support error text', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PNumberField(
              errorText: 'عدد نامعتبر است',
            ),
          ),
        ),
      );

      expect(
        find.text('عدد نامعتبر است'),
        findsOneWidget,
      );
    });

    testWidgets('should support RTL direction', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PNumberField(
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
      );

      final TextField textField = tester.widget<TextField>(
        find.byType(TextField),
      );

      expect(
        textField.textDirection,
        TextDirection.rtl,
      );
    });

    testWidgets('should support LTR direction', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PNumberField(
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
      );

      final TextField textField = tester.widget<TextField>(
        find.byType(TextField),
      );

      expect(
        textField.textDirection,
        TextDirection.ltr,
      );
    });

    testWidgets('should support disabled state', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PNumberField(
              enabled: false,
            ),
          ),
        ),
      );

      final TextField textField = tester.widget<TextField>(
        find.byType(TextField),
      );

      expect(textField.enabled, isFalse);
    });
  });
}