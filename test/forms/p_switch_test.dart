
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PSwitch', () {
    Widget buildTestWidget({
      required bool value,
      ValueChanged<bool>? onChanged,
      Widget? label,
      EdgeInsetsGeometry? padding,
      TextDirection textDirection = TextDirection.ltr,
    }) {
      return MaterialApp(
        home: Directionality(
          textDirection: textDirection,
          child: Scaffold(
            body: PSwitch(
              value: value,
              onChanged: onChanged,
              label: label,
              padding: padding,
            ),
          ),
        ),
      );
    }

    testWidgets('renders a Switch', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: false,
          onChanged: (_) {},
        ),
      );

      expect(find.byType(PSwitch), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('renders with value false', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: false,
          onChanged: (_) {},
        ),
      );

      final switchWidget = tester.widget<Switch>(
        find.byType(Switch),
      );

      expect(switchWidget.value, isFalse);
    });

    testWidgets('renders with value true', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: true,
          onChanged: (_) {},
        ),
      );

      final switchWidget = tester.widget<Switch>(
        find.byType(Switch),
      );

      expect(switchWidget.value, isTrue);
    });

    testWidgets('passes onChanged callback to Switch', (tester) async {
      bool? receivedValue;

      await tester.pumpWidget(
        buildTestWidget(
          value: false,
          onChanged: (value) {
            receivedValue = value;
          },
        ),
      );

      await tester.tap(find.byType(Switch));
      await tester.pump();

      expect(receivedValue, isTrue);
    });

    testWidgets('supports changing from true to false', (tester) async {
      bool? receivedValue;

      await tester.pumpWidget(
        buildTestWidget(
          value: true,
          onChanged: (value) {
            receivedValue = value;
          },
        ),
      );

      await tester.tap(find.byType(Switch));
      await tester.pump();

      expect(receivedValue, isFalse);
    });

    testWidgets('is disabled when onChanged is null', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: false,
          onChanged: null,
        ),
      );

      final switchWidget = tester.widget<Switch>(
        find.byType(Switch),
      );

      expect(switchWidget.onChanged, isNull);
    });

    testWidgets('is enabled when onChanged is provided', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: false,
          onChanged: (_) {},
        ),
      );

      final switchWidget = tester.widget<Switch>(
        find.byType(Switch),
      );

      expect(switchWidget.onChanged, isNotNull);
    });

    testWidgets('renders without a label', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: false,
          onChanged: (_) {},
        ),
      );

      expect(find.byType(Switch), findsOneWidget);
      expect(find.text('Switch label'), findsNothing);
    });

    testWidgets('renders an optional label', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: false,
          onChanged: (_) {},
          label: const Text('Switch label'),
        ),
      );

      expect(find.text('Switch label'), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('supports a widget label', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: true,
          onChanged: (_) {},
          label: const Icon(Icons.settings),
        ),
      );

      expect(find.byIcon(Icons.settings), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('uses Wrap when label is provided', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: false,
          onChanged: (_) {},
          label: const Text('Settings'),
        ),
      );

      expect(find.byType(Wrap), findsOneWidget);
    });

    testWidgets('does not add Wrap when label is absent', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: false,
          onChanged: (_) {},
        ),
      );

      expect(find.byType(Wrap), findsNothing);
    });

    testWidgets('applies padding when provided', (tester) async {
      const padding = EdgeInsets.all(24);

      await tester.pumpWidget(
        buildTestWidget(
          value: false,
          onChanged: (_) {},
          padding: padding,
        ),
      );

      final paddingWidget = tester.widget<Padding>(
        find.byType(Padding),
      );

      expect(paddingWidget.padding, padding);
    });

    testWidgets('does not add Padding when padding is null', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: false,
          onChanged: (_) {},
        ),
      );

      expect(find.byType(Padding), findsNothing);
    });

    testWidgets('supports RTL directionality', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: false,
          onChanged: (_) {},
          label: const Text('فعال'),
          textDirection: TextDirection.rtl,
        ),
      );

      final directionality = tester.widget<Directionality>(
        find.ancestor(
          of: find.byType(PSwitch),
          matching: find.byType(Directionality),
        ).first,
      );

      expect(directionality.textDirection, TextDirection.rtl);
      expect(find.text('فعال'), findsOneWidget);
    });

    testWidgets('supports LTR directionality', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: false,
          onChanged: (_) {},
          label: const Text('Enabled'),
          textDirection: TextDirection.ltr,
        ),
      );

      final directionality = tester.widget<Directionality>(
        find.ancestor(
          of: find.byType(PSwitch),
          matching: find.byType(Directionality),
        ).first,
      );

      expect(directionality.textDirection, TextDirection.ltr);
      expect(find.text('Enabled'), findsOneWidget);
    });

    testWidgets('supports long labels without throwing', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: true,
          onChanged: (_) {},
          label: const Text(
            'این یک متن طولانی برای بررسی رفتار PSwitch در '
            'محدودیت‌های مختلف صفحه است',
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('supports constrained layouts', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 180,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: PSwitch(
                  value: false,
                  onChanged: (_) {},
                  label: const Text(
                    'گزینه بسیار طولانی برای تست',
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.byType(PSwitch), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('rebuilds correctly when value changes', (tester) async {
      bool value = false;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Scaffold(
                body: PSwitch(
                  value: value,
                  onChanged: (newValue) {
                    setState(() {
                      value = newValue;
                    });
                  },
                ),
              ),
            );
          },
        ),
      );

      expect(
        tester.widget<Switch>(find.byType(Switch)).value,
        isFalse,
      );

      await tester.tap(find.byType(Switch));
      await tester.pump();

      expect(
        tester.widget<Switch>(find.byType(Switch)).value,
        isTrue,
      );
    });

    testWidgets('supports const construction', (tester) async {
      const switchWidget = PSwitch(
        value: true,
        onChanged: null,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: switchWidget,
          ),
        ),
      );

      expect(find.byType(PSwitch), findsOneWidget);
      expect(
        tester.widget<PSwitch>(find.byType(PSwitch)).value,
        isTrue,
      );
    });

    testWidgets('preserves generic Flutter widget labels', (tester) async {
      final labelKey = UniqueKey();

      await tester.pumpWidget(
        buildTestWidget(
          value: false,
          onChanged: (_) {},
          label: SizedBox(
            key: labelKey,
            width: 20,
            height: 20,
          ),
        ),
      );

      expect(find.byKey(labelKey), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });
  });
}
