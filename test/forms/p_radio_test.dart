
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

Widget buildTestApp(Widget child) {
  return MaterialApp(
    home: Scaffold(
      body: child,
    ),
  );
}

Widget buildRadioApp({
  required String groupValue,
  required ValueChanged<String?> onChanged,
  required Widget child,
}) {
  return buildTestApp(
    RadioGroup<String>(
      groupValue: groupValue,
      onChanged: onChanged,
      child: child,
    ),
  );
}

void main() {
  group('PRadio', () {
    testWidgets('renders radio with the provided value', (tester) async {
      await tester.pumpWidget(
        buildRadioApp(
          groupValue: 'option-a',
          onChanged: (_) {},
          child: const PRadio<String>(
            value: 'option-a',
          ),
        ),
      );

      final radio = tester.widget<Radio<String>>(
        find.byType(Radio<String>),
      );

      expect(radio.value, 'option-a');
    });

    testWidgets('renders selected radio when group value matches', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildRadioApp(
          groupValue: 'option-a',
          onChanged: (_) {},
          child: const PRadio<String>(
            value: 'option-a',
          ),
        ),
      );

      final radio = tester.widget<Radio<String>>(
        find.byType(Radio<String>),
      );

      expect(radio.value, 'option-a');
    });

    testWidgets('renders unselected radio when group value differs', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildRadioApp(
          groupValue: 'option-b',
          onChanged: (_) {},
          child: const PRadio<String>(
            value: 'option-a',
          ),
        ),
      );

      final radio = tester.widget<Radio<String>>(
        find.byType(Radio<String>),
      );

      expect(radio.value, 'option-a');
    });

    testWidgets('supports selection through RadioGroup', (tester) async {
      String? selectedValue = 'option-a';

      await tester.pumpWidget(
        buildRadioApp(
          groupValue: selectedValue,
          onChanged: (value) {
            selectedValue = value;
          },
          child: const PRadio<String>(
            value: 'option-b',
          ),
        ),
      );

      await tester.tap(find.byType(Radio<String>));
      await tester.pump();

      expect(selectedValue, 'option-b');
    });

    testWidgets('renders custom label', (tester) async {
      const labelKey = Key('radio-label');

      await tester.pumpWidget(
        buildRadioApp(
          groupValue: 'option-a',
          onChanged: (_) {},
          child: const PRadio<String>(
            value: 'option-a',
            label: SizedBox(
              key: labelKey,
              child: Text('گزینه'),
            ),
          ),
        ),
      );

      expect(find.byKey(labelKey), findsOneWidget);
      expect(find.text('گزینه'), findsOneWidget);
      expect(find.byType(Wrap), findsOneWidget);
    });

    testWidgets('works without a label', (tester) async {
      await tester.pumpWidget(
        buildRadioApp(
          groupValue: 'option-a',
          onChanged: (_) {},
          child: const PRadio<String>(
            value: 'option-a',
          ),
        ),
      );

      expect(find.byType(Radio<String>), findsOneWidget);
      expect(find.byType(Wrap), findsNothing);
    });

    testWidgets('supports disabled state', (tester) async {
      await tester.pumpWidget(
        buildRadioApp(
          groupValue: 'option-a',
          onChanged: (_) {},
          child: const PRadio<String>(
            value: 'option-a',
            enabled: false,
          ),
        ),
      );

      final radio = tester.widget<Radio<String>>(
        find.byType(Radio<String>),
      );

      expect(radio.enabled, isFalse);
    });

    testWidgets('supports enabled state', (tester) async {
      await tester.pumpWidget(
        buildRadioApp(
          groupValue: 'option-a',
          onChanged: (_) {},
          child: const PRadio<String>(
            value: 'option-a',
            enabled: true,
          ),
        ),
      );

      final radio = tester.widget<Radio<String>>(
        find.byType(Radio<String>),
      );

      expect(radio.enabled, isTrue);
    });

    testWidgets('supports null enabled state', (tester) async {
      await tester.pumpWidget(
        buildRadioApp(
          groupValue: 'option-a',
          onChanged: (_) {},
          child: const PRadio<String>(
            value: 'option-a',
          ),
        ),
      );

      final radio = tester.widget<Radio<String>>(
        find.byType(Radio<String>),
      );

      expect(radio.enabled, isNull);
    });

    testWidgets('applies padding', (tester) async {
      const padding = EdgeInsets.all(16);

      await tester.pumpWidget(
        buildRadioApp(
          groupValue: 'option-a',
          onChanged: (_) {},
          child: const PRadio<String>(
            value: 'option-a',
            padding: padding,
          ),
        ),
      );

      final paddingWidget = tester.widget<Padding>(
        find.byType(Padding),
      );

      expect(paddingWidget.padding, padding);
    });

    testWidgets('supports RTL layout', (tester) async {
      await tester.pumpWidget(
        buildRadioApp(
          groupValue: 'option-a',
          onChanged: (_) {},
          child: const Directionality(
            textDirection: TextDirection.rtl,
            child: PRadio<String>(
              value: 'option-a',
              label: Text('گزینه'),
            ),
          ),
        ),
      );

      expect(find.text('گزینه'), findsOneWidget);
      expect(find.byType(Radio<String>), findsOneWidget);
    });

    testWidgets('supports LTR layout', (tester) async {
      await tester.pumpWidget(
        buildRadioApp(
          groupValue: 'option-a',
          onChanged: (_) {},
          child: const Directionality(
            textDirection: TextDirection.ltr,
            child: PRadio<String>(
              value: 'option-a',
              label: Text('Option'),
            ),
          ),
        ),
      );

      expect(find.text('Option'), findsOneWidget);
      expect(find.byType(Radio<String>), findsOneWidget);
    });

    testWidgets('supports long label text', (tester) async {
      await tester.pumpWidget(
        buildRadioApp(
          groupValue: 'option-a',
          onChanged: (_) {},
          child: const SizedBox(
            width: 240,
            child: PRadio<String>(
              value: 'option-a',
              label: Text(
                'این یک متن نسبتاً طولانی برای بررسی رفتار responsive است',
              ),
            ),
          ),
        ),
      );

      expect(
        find.text(
          'این یک متن نسبتاً طولانی برای بررسی رفتار responsive است',
        ),
        findsOneWidget,
      );

      expect(tester.takeException(), isNull);
    });

    testWidgets('does not impose a fixed width', (tester) async {
      await tester.pumpWidget(
        buildRadioApp(
          groupValue: 'option-a',
          onChanged: (_) {},
          child: const SizedBox(
            width: 200,
            child: PRadio<String>(
              value: 'option-a',
              label: Text('گزینه'),
            ),
          ),
        ),
      );

      expect(find.byType(PRadio<String>), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('supports rebuilding with a changed group value', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildRadioApp(
          groupValue: 'option-a',
          onChanged: (_) {},
          child: const PRadio<String>(
            value: 'option-a',
          ),
        ),
      );

      Radio<String> radio = tester.widget<Radio<String>>(
        find.byType(Radio<String>),
      );

      expect(radio.value, 'option-a');

      await tester.pumpWidget(
        buildRadioApp(
          groupValue: 'option-b',
          onChanged: (_) {},
          child: const PRadio<String>(
            value: 'option-a',
          ),
        ),
      );

      radio = tester.widget<Radio<String>>(
        find.byType(Radio<String>),
      );

      expect(radio.value, 'option-a');
      expect(tester.takeException(), isNull);
    });

    testWidgets('supports integer values', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          RadioGroup<int>(
            groupValue: 2,
            onChanged: (_) {},
            child: const PRadio<int>(
              value: 2,
            ),
          ),
        ),
      );

      final radio = tester.widget<Radio<int>>(
        find.byType(Radio<int>),
      );

      expect(radio.value, 2);
    });

    testWidgets('supports enum values', (tester) async {
      const options = <TestOption>[
        TestOption.first,
        TestOption.second,
      ];

      await tester.pumpWidget(
        buildTestApp(
          RadioGroup<TestOption>(
            groupValue: options.first,
            onChanged: (_) {},
            child: const PRadio<TestOption>(
              value: TestOption.second,
            ),
          ),
        ),
      );

      final radio = tester.widget<Radio<TestOption>>(
        find.byType(Radio<TestOption>),
      );

      expect(radio.value, TestOption.second);
    });

    testWidgets('supports padding with a label', (tester) async {
      const padding = EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      );

      await tester.pumpWidget(
        buildRadioApp(
          groupValue: 'option-a',
          onChanged: (_) {},
          child: const PRadio<String>(
            value: 'option-a',
            label: Text('گزینه'),
            padding: padding,
          ),
        ),
      );

      final paddingWidget = tester.widget<Padding>(
        find.byType(Padding),
      );

      expect(paddingWidget.padding, padding);
      expect(find.text('گزینه'), findsOneWidget);
    });

    testWidgets('does not throw with constrained layout', (tester) async {
      await tester.pumpWidget(
        buildRadioApp(
          groupValue: 'option-a',
          onChanged: (_) {},
          child: const SizedBox(
            width: 120,
            height: 80,
            child: PRadio<String>(
              value: 'option-a',
              label: Text('گزینه'),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
    });
  });
}

enum TestOption {
  first,
  second,
}
