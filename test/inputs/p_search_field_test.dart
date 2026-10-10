import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PSearchField', () {
    testWidgets('should display search icon and hint', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PSearchField(
              hint: 'جستجو کنید',
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.text('جستجو کنید'), findsOneWidget);
    });

    testWidgets('should accept text input', (
      WidgetTester tester,
    ) async {
      final TextEditingController controller =
          TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PSearchField(
              controller: controller,
            ),
          ),
        ),
      );

      await tester.enterText(
        find.byType(TextField),
        'فلاتر',
      );

      expect(controller.text, 'فلاتر');

      controller.dispose();
    });

    testWidgets('should call onChanged', (
      WidgetTester tester,
    ) async {
      String? value;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PSearchField(
              onChanged: (String text) {
                value = text;
              },
            ),
          ),
        ),
      );

      await tester.enterText(
        find.byType(TextField),
        'Flutter',
      );

      expect(value, 'Flutter');
    });

    testWidgets('should display clear button when text exists', (
      WidgetTester tester,
    ) async {
      final TextEditingController controller =
          TextEditingController(text: 'فلاتر');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PSearchField(
              controller: controller,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.clear), findsOneWidget);

      controller.dispose();
    });

    testWidgets('should clear text when clear button is tapped', (
      WidgetTester tester,
    ) async {
      final TextEditingController controller =
          TextEditingController(text: 'فلاتر');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PSearchField(
              controller: controller,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump();

      expect(controller.text, isEmpty);

      controller.dispose();
    });

    testWidgets('should support RTL direction', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PSearchField(
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
            body: PSearchField(
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
            body: PSearchField(
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

    testWidgets('should hide clear button when text is empty', (
      WidgetTester tester,
    ) async {
      final TextEditingController controller =
          TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PSearchField(
              controller: controller,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.clear), findsNothing);

      controller.dispose();
    });
  });
}