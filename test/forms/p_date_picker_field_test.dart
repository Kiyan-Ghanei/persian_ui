import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PDatePickerField', () {
    Widget buildTestWidget({
      DateTime? value,
      ValueChanged<DateTime?>? onChanged,
      Widget? label,
      String? hintText,
      DateTime? firstDate,
      DateTime? lastDate,
      bool enabled = true,
      EdgeInsetsGeometry? padding,
      Locale? locale,
      TextDirection textDirection = TextDirection.ltr,
    }) {
      return MaterialApp(
        locale: locale,
        home: Directionality(
          textDirection: textDirection,
          child: Scaffold(
            body: PDatePickerField(
              value: value,
              onChanged: onChanged,
              label: label,
              hintText: hintText,
              firstDate: firstDate,
              lastDate: lastDate,
              enabled: enabled,
              padding: padding,
            ),
          ),
        ),
      );
    }

    testWidgets('renders the date picker field', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(value: DateTime(2026, 5, 10), onChanged: (_) {}),
      );

      expect(find.byType(PDatePickerField), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('supports a null value', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: null,
          onChanged: (_) {},
          hintText: 'تاریخ را انتخاب کنید',
        ),
      );

      final field = tester.widget<TextField>(find.byType(TextField));

      expect(field.controller?.text, isEmpty);
      expect(field.decoration?.hintText, 'تاریخ را انتخاب کنید');
    });

    testWidgets('passes label to the field decoration', (tester) async {
      const label = Text('تاریخ تولد');

      await tester.pumpWidget(
        buildTestWidget(value: null, onChanged: (_) {}, label: label),
      );

      final field = tester.widget<TextField>(find.byType(TextField));

      expect(field.decoration?.label, same(label));
    });

    testWidgets('passes hint text to the field decoration', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: null,
          onChanged: (_) {},
          hintText: 'انتخاب تاریخ',
        ),
      );

      final field = tester.widget<TextField>(find.byType(TextField));

      expect(field.decoration?.hintText, 'انتخاب تاریخ');
    });

    testWidgets('renders calendar icon', (tester) async {
      await tester.pumpWidget(buildTestWidget(value: null, onChanged: (_) {}));

      expect(find.byIcon(Icons.calendar_today_outlined), findsOneWidget);
    });

    testWidgets('is enabled when enabled is true and onChanged is provided', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: DateTime(2026, 5, 10),
          onChanged: (_) {},
          enabled: true,
        ),
      );

      final field = tester.widget<TextField>(find.byType(TextField));

      expect(field.enabled, isTrue);
      expect(field.readOnly, isTrue);
    });

    testWidgets('is disabled when onChanged is null', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(value: DateTime(2026, 5, 10), onChanged: null),
      );

      final field = tester.widget<TextField>(find.byType(TextField));

      expect(field.enabled, isFalse);
    });

    testWidgets('is disabled when enabled is false', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: DateTime(2026, 5, 10),
          onChanged: (_) {},
          enabled: false,
        ),
      );

      final field = tester.widget<TextField>(find.byType(TextField));

      expect(field.enabled, isFalse);
    });

    testWidgets('is read only', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(value: DateTime(2026, 5, 10), onChanged: (_) {}),
      );

      final field = tester.widget<TextField>(find.byType(TextField));

      expect(field.readOnly, isTrue);
    });

    testWidgets('formats a non-null date using MaterialLocalizations', (
      tester,
    ) async {
      final date = DateTime(2026, 5, 10);

      await tester.pumpWidget(buildTestWidget(value: date, onChanged: (_) {}));

      final expectedText = MaterialLocalizations.of(
        tester.element(find.byType(TextField)),
      ).formatMediumDate(date);

      final field = tester.widget<TextField>(find.byType(TextField));

      expect(field.controller?.text, expectedText);
    });

    testWidgets('applies provided padding', (tester) async {
      const padding = EdgeInsets.all(24);

      await tester.pumpWidget(
        buildTestWidget(
          value: DateTime(2026, 5, 10),
          onChanged: (_) {},
          padding: padding,
        ),
      );

      final paddingFinder = find.descendant(
        of: find.byType(PDatePickerField),
        matching: find.byType(Padding),
      );

      final paddingWidgets = tester.widgetList<Padding>(paddingFinder);

      expect(
        paddingWidgets.where((widget) => widget.padding == padding),
        hasLength(1),
      );
    });

    testWidgets('stores null padding when padding is not provided', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(value: DateTime(2026, 5, 10), onChanged: (_) {}),
      );

      final datePickerField = tester.widget<PDatePickerField>(
        find.byType(PDatePickerField),
      );

      expect(datePickerField.padding, isNull);
    });

    testWidgets('supports RTL directionality', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: DateTime(2026, 5, 10),
          onChanged: (_) {},
          textDirection: TextDirection.rtl,
        ),
      );

      final directionality = tester.widget<Directionality>(
        find
            .ancestor(
              of: find.byType(PDatePickerField),
              matching: find.byType(Directionality),
            )
            .first,
      );

      expect(directionality.textDirection, TextDirection.rtl);
    });

    testWidgets('supports LTR directionality', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: DateTime(2026, 5, 10),
          onChanged: (_) {},
          textDirection: TextDirection.ltr,
        ),
      );

      final directionality = tester.widget<Directionality>(
        find
            .ancestor(
              of: find.byType(PDatePickerField),
              matching: find.byType(Directionality),
            )
            .first,
      );

      expect(directionality.textDirection, TextDirection.ltr);
    });

    testWidgets('opens the date picker when tapped', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(value: DateTime(2026, 5, 10), onChanged: (_) {}),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(find.byType(DatePickerDialog), findsOneWidget);
    });

    testWidgets('does not open the date picker when disabled', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(value: DateTime(2026, 5, 10), onChanged: null),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(find.byType(DatePickerDialog), findsNothing);
    });

    testWidgets('uses firstDate and lastDate', (tester) async {
      final firstDate = DateTime(2026, 1, 1);
      final lastDate = DateTime(2026, 12, 31);

      await tester.pumpWidget(
        buildTestWidget(
          value: DateTime(2026, 5, 10),
          onChanged: (_) {},
          firstDate: firstDate,
          lastDate: lastDate,
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(find.byType(DatePickerDialog), findsOneWidget);
    });

    testWidgets('supports a custom initial value', (tester) async {
      final value = DateTime(2026, 8, 15);

      await tester.pumpWidget(buildTestWidget(value: value, onChanged: (_) {}));

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(find.byType(DatePickerDialog), findsOneWidget);
      expect(find.text('15'), findsWidgets);
    });

    testWidgets('supports constrained layouts without throwing', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 220,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: PDatePickerField(
                  value: DateTime(2026, 5, 10),
                  onChanged: (_) {},
                  label: const Text('تاریخ مورد نظر'),
                  hintText: 'انتخاب تاریخ',
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.byType(PDatePickerField), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('supports rebuild with a changed value', (tester) async {
      var value = DateTime(2026, 5, 10);

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Scaffold(
                body: Column(
                  children: [
                    PDatePickerField(
                      value: value,
                      onChanged: (newValue) {
                        if (newValue == null) {
                          return;
                        }

                        setState(() {
                          value = newValue;
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          value = DateTime(2026, 6, 20);
                        });
                      },
                      child: const Text('Change date'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

      final initialField = tester.widget<TextField>(find.byType(TextField));

      final expectedInitialText = MaterialLocalizations.of(
        tester.element(find.byType(TextField)),
      ).formatMediumDate(value);

      expect(initialField.controller?.text, expectedInitialText);

      await tester.tap(find.text('Change date'));
      await tester.pump();

      final updatedField = tester.widget<TextField>(find.byType(TextField));

      final expectedUpdatedText = MaterialLocalizations.of(
        tester.element(find.byType(TextField)),
      ).formatMediumDate(DateTime(2026, 6, 20));

      expect(updatedField.controller?.text, expectedUpdatedText);
    });

    testWidgets('supports const construction', (tester) async {
      const field = PDatePickerField(value: null, onChanged: null);

      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: field)));

      expect(find.byType(PDatePickerField), findsOneWidget);
    });

    testWidgets('does not throw with empty label and hint', (tester) async {
      await tester.pumpWidget(buildTestWidget(value: null, onChanged: (_) {}));

      expect(tester.takeException(), isNull);
    });
  });
}
