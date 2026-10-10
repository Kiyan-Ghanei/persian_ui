import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PTextField', () {
    testWidgets(
      'display label and hint',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PTextField(
                label: 'نام',
                hint: 'نام خود را وارد کنید',
              ),
            ),
          ),
        );

        expect(find.text('نام'), findsOneWidget);
        expect(
          find.text('نام خود را وارد کنید'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'accept text input',
      (WidgetTester tester) async {
        final TextEditingController controller =
            TextEditingController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PTextField(
                controller: controller,
              ),
            ),
          ),
        );

        await tester.enterText(
          find.byType(TextField),
          'علی',
        );

        expect(controller.text, 'علی');
      },
    );

    testWidgets(
      'call onChanged when text changes',
      (WidgetTester tester) async {
        String? changedValue;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PTextField(
                onChanged: (String value) {
                  changedValue = value;
                },
              ),
            ),
          ),
        );

        await tester.enterText(
          find.byType(TextField),
          'سلام',
        );

        expect(changedValue, 'سلام');
      },
    );

    testWidgets(
      'display error text',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PTextField(
                errorText: 'ورودی نامعتبر است',
              ),
            ),
          ),
        );

        expect(
          find.text('ورودی نامعتبر است'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'support RTL text direction',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                body: PTextField(),
              ),
            ),
          ),
        );

        final BuildContext context =
            tester.element(find.byType(TextField));

        expect(
          Directionality.of(context),
          TextDirection.rtl,
        );
      },
    );

    testWidgets(
      'support LTR text direction',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Directionality(
              textDirection: TextDirection.ltr,
              child: Scaffold(
                body: PTextField(
                  textDirection: TextDirection.ltr,
                ),
              ),
            ),
          ),
        );

        final TextField textField =
            tester.widget<TextField>(
          find.byType(TextField),
        );

        expect(
          textField.textDirection,
          TextDirection.ltr,
        );
      },
    );

    testWidgets(
      'be disabled when enabled is false',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PTextField(
                enabled: false,
              ),
            ),
          ),
        );

        final TextField textField =
            tester.widget<TextField>(
          find.byType(TextField),
        );

        expect(textField.enabled, isFalse);
      },
    );
  });
}