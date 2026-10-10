
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

void main() {
  group('PCheckbox', () {
    testWidgets('renders unchecked state', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          PCheckbox(
            value: false,
            onChanged: (_) {},
          ),
        ),
      );

      final checkbox = tester.widget<Checkbox>(
        find.byType(Checkbox),
      );

      expect(checkbox.value, isFalse);
      expect(checkbox.tristate, isFalse);
      expect(checkbox.onChanged, isNotNull);
    });

    testWidgets('renders checked state', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          PCheckbox(
            value: true,
            onChanged: (_) {},
          ),
        ),
      );

      final checkbox = tester.widget<Checkbox>(
        find.byType(Checkbox),
      );

      expect(checkbox.value, isTrue);
    });

    testWidgets('supports tristate indeterminate state', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          PCheckbox(
            value: null,
            tristate: true,
            onChanged: (_) {},
          ),
        ),
      );

      final checkbox = tester.widget<Checkbox>(
        find.byType(Checkbox),
      );

      expect(checkbox.value, isNull);
      expect(checkbox.tristate, isTrue);
    });

    testWidgets('calls onChanged when tapped', (tester) async {
      bool? changedValue;

      await tester.pumpWidget(
        buildTestApp(
          PCheckbox(
            value: false,
            onChanged: (value) {
              changedValue = value;
            },
          ),
        ),
      );

      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      expect(changedValue, isTrue);
    });

    testWidgets('supports tristate value changes', (tester) async {
      bool? changedValue;

      await tester.pumpWidget(
        buildTestApp(
          PCheckbox(
            value: false,
            tristate: true,
            onChanged: (value) {
              changedValue = value;
            },
          ),
        ),
      );

      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      expect(changedValue, isTrue);
    });

    testWidgets('is disabled when onChanged is null', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          PCheckbox(
            value: false,
            onChanged: null,
          ),
        ),
      );

      final checkbox = tester.widget<Checkbox>(
        find.byType(Checkbox),
      );

      expect(checkbox.onChanged, isNull);
    });

    testWidgets('renders label when provided', (tester) async {
      const label = Text('گزینه');

      await tester.pumpWidget(
        buildTestApp(
          const PCheckbox(
            value: false,
            onChanged: null,
            label: label,
          ),
        ),
      );

      expect(find.text('گزینه'), findsOneWidget);
      expect(find.byType(Wrap), findsOneWidget);
    });

    testWidgets('works without label', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          PCheckbox(
            value: false,
            onChanged: (_) {},
          ),
        ),
      );

      expect(find.byType(Checkbox), findsOneWidget);
      expect(find.byType(Wrap), findsNothing);
    });

    testWidgets('applies padding when provided', (tester) async {
      const padding = EdgeInsets.all(16);

      await tester.pumpWidget(
        buildTestApp(
          const PCheckbox(
            value: false,
            onChanged: null,
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
        buildTestApp(
          const Directionality(
            textDirection: TextDirection.rtl,
            child: PCheckbox(
              value: false,
              onChanged: null,
              label: Text('گزینه'),
            ),
          ),
        ),
      );

      expect(find.text('گزینه'), findsOneWidget);
      expect(find.byType(Checkbox), findsOneWidget);
    });

    testWidgets('supports LTR layout', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: PCheckbox(
              value: false,
              onChanged: null,
              label: Text('Option'),
            ),
          ),
        ),
      );

      expect(find.text('Option'), findsOneWidget);
      expect(find.byType(Checkbox), findsOneWidget);
    });

    testWidgets('does not impose a fixed width', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          const SizedBox(
            width: 200,
            child: PCheckbox(
              value: false,
              onChanged: null,
              label: Text('گزینه'),
            ),
          ),
        ),
      );

      expect(find.byType(PCheckbox), findsOneWidget);
      expect(find.text('گزینه'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('supports long label text', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          const SizedBox(
            width: 240,
            child: PCheckbox(
              value: false,
              onChanged: null,
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

    testWidgets('forwards tristate configuration', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          PCheckbox(
            value: true,
            tristate: true,
            onChanged: (_) {},
          ),
        ),
      );

      final checkbox = tester.widget<Checkbox>(
        find.byType(Checkbox),
      );

      expect(checkbox.tristate, isTrue);
      expect(checkbox.value, isTrue);
    });

    testWidgets('forwards value correctly', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          PCheckbox(
            value: true,
            onChanged: (_) {},
          ),
        ),
      );

      final checkbox = tester.widget<Checkbox>(
        find.byType(Checkbox),
      );

      expect(checkbox.value, isTrue);
    });

    testWidgets('forwards onChanged callback', (tester) async {
      void callback(bool? value) {}

      await tester.pumpWidget(
        buildTestApp(
          PCheckbox(
            value: false,
            onChanged: callback,
          ),
        ),
      );

      final checkbox = tester.widget<Checkbox>(
        find.byType(Checkbox),
      );

      expect(checkbox.onChanged, same(callback));
    });

    testWidgets('uses padding with label', (tester) async {
      const padding = EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      );

      await tester.pumpWidget(
        buildTestApp(
          const PCheckbox(
            value: false,
            onChanged: null,
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

    testWidgets('accepts a custom label widget', (tester) async {
      const labelKey = Key('custom-label');

      await tester.pumpWidget(
        buildTestApp(
          const PCheckbox(
            value: false,
            onChanged: null,
            label: SizedBox(
              key: labelKey,
              child: Text('برچسب'),
            ),
          ),
        ),
      );

      expect(find.byKey(labelKey), findsOneWidget);
      expect(find.text('برچسب'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('supports rebuilding with a changed value', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          const PCheckbox(
            value: false,
            onChanged: null,
          ),
        ),
      );

      Checkbox checkbox = tester.widget<Checkbox>(
        find.byType(Checkbox),
      );

      expect(checkbox.value, isFalse);

      await tester.pumpWidget(
        buildTestApp(
          const PCheckbox(
            value: true,
            onChanged: null,
          ),
        ),
      );

      checkbox = tester.widget<Checkbox>(
        find.byType(Checkbox),
      );

      expect(checkbox.value, isTrue);
    });

    testWidgets('does not throw with constrained layout', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          const SizedBox(
            width: 120,
            height: 80,
            child: PCheckbox(
              value: false,
              onChanged: null,
              label: Text('گزینه'),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
    });
  });
}
