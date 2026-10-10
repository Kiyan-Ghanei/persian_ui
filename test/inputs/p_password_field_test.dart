import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PPasswordField', () {
    testWidgets('should display label and hint', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PPasswordField(
              label: 'رمز عبور',
              hint: 'رمز عبور خود را وارد کنید',
            ),
          ),
        ),
      );

      expect(find.text('رمز عبور'), findsOneWidget);
      expect(
        find.text('رمز عبور خود را وارد کنید'),
        findsOneWidget,
      );
    });

    testWidgets('should accept password input', (
      WidgetTester tester,
    ) async {
      final TextEditingController controller =
          TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PPasswordField(
              controller: controller,
            ),
          ),
        ),
      );

      await tester.enterText(
        find.byType(TextField),
        '123456',
      );

      expect(controller.text, '123456');

      controller.dispose();
    });

    testWidgets('should call onChanged', (
      WidgetTester tester,
    ) async {
      String? value;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PPasswordField(
              onChanged: (String text) {
                value = text;
              },
            ),
          ),
        ),
      );

      await tester.enterText(
        find.byType(TextField),
        '123456',
      );

      expect(value, '123456');
    });

    testWidgets('should support error text', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PPasswordField(
              errorText: 'رمز عبور الزامی است',
            ),
          ),
        ),
      );

      expect(
        find.text('رمز عبور الزامی است'),
        findsOneWidget,
      );
    });

    testWidgets('should obscure password by default', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PPasswordField(),
          ),
        ),
      );

      final TextField textField = tester.widget<TextField>(
        find.byType(TextField),
      );

      expect(textField.obscureText, isTrue);
    });

    testWidgets('should toggle password visibility', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PPasswordField(),
          ),
        ),
      );

      TextField textField = tester.widget<TextField>(
        find.byType(TextField),
      );

      expect(textField.obscureText, isTrue);

      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pump();

      textField = tester.widget<TextField>(
        find.byType(TextField),
      );

      expect(textField.obscureText, isFalse);

      expect(
        find.byIcon(Icons.visibility_off),
        findsOneWidget,
      );
    });

    testWidgets('should support RTL direction', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PPasswordField(
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
            body: PPasswordField(
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
            body: PPasswordField(
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