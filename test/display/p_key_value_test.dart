import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PKeyValue', () {
    testWidgets('displays label and value', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PKeyValue(
              label: Text('نام'),
              value: Text('کیان'),
            ),
          ),
        ),
      );

      expect(find.text('نام'), findsOneWidget);
      expect(find.text('کیان'), findsOneWidget);
    });

    testWidgets('uses horizontal direction by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PKeyValue(
              label: Text('نام'),
              value: Text('کیان'),
            ),
          ),
        ),
      );

      final flex = tester.widget<Flex>(
        find.descendant(
          of: find.byType(PKeyValue),
          matching: find.byType(Flex),
        ),
      );

      expect(flex.direction, Axis.horizontal);
    });

    testWidgets('supports vertical direction', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PKeyValue(
              label: Text('نام'),
              value: Text('کیان'),
              direction: Axis.vertical,
            ),
          ),
        ),
      );

      final flex = tester.widget<Flex>(
        find.descendant(
          of: find.byType(PKeyValue),
          matching: find.byType(Flex),
        ),
      );

      expect(flex.direction, Axis.vertical);
    });

    testWidgets('supports custom label widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PKeyValue(
              label: Icon(
                Icons.person,
                key: ValueKey('label-icon'),
              ),
              value: Text('کیان'),
            ),
          ),
        ),
      );

      expect(
        find.byKey(const ValueKey('label-icon')),
        findsOneWidget,
      );
    });

    testWidgets('supports custom value widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PKeyValue(
              label: Text('وضعیت'),
              value: Icon(
                Icons.check,
                key: ValueKey('value-icon'),
              ),
            ),
          ),
        ),
      );

      expect(
        find.byKey(const ValueKey('value-icon')),
        findsOneWidget,
      );
    });

    testWidgets('supports custom padding', (tester) async {
      const padding = EdgeInsets.all(24);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PKeyValue(
              label: Text('نام'),
              value: Text('کیان'),
              padding: padding,
            ),
          ),
        ),
      );

      final paddingWidget = tester.widget<Padding>(
        find.descendant(
          of: find.byType(PKeyValue),
          matching: find.byType(Padding),
        ),
      );

      expect(paddingWidget.padding, padding);
    });

    testWidgets('uses zero padding by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PKeyValue(
              label: Text('نام'),
              value: Text('کیان'),
            ),
          ),
        ),
      );

      final paddingWidget = tester.widget<Padding>(
        find.descendant(
          of: find.byType(PKeyValue),
          matching: find.byType(Padding),
        ),
      );

      expect(paddingWidget.padding, EdgeInsets.zero);
    });

    testWidgets('supports main axis alignment', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PKeyValue(
              label: Text('نام'),
              value: Text('کیان'),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
        ),
      );

      final flex = tester.widget<Flex>(
        find.descendant(
          of: find.byType(PKeyValue),
          matching: find.byType(Flex),
        ),
      );

      expect(
        flex.mainAxisAlignment,
        MainAxisAlignment.spaceBetween,
      );
    });

    testWidgets('supports cross axis alignment', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PKeyValue(
              label: Text('نام'),
              value: Text('کیان'),
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
        ),
      );

      final flex = tester.widget<Flex>(
        find.descendant(
          of: find.byType(PKeyValue),
          matching: find.byType(Flex),
        ),
      );

      expect(
        flex.crossAxisAlignment,
        CrossAxisAlignment.center,
      );
    });

    testWidgets('handles long content without overflow', (tester) async {
      await tester.binding.setSurfaceSize(
        const Size(320, 480),
      );

      addTearDown(
        () => tester.binding.setSurfaceSize(null),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: PKeyValue(
                label: Text(
                  'این یک برچسب بسیار طولانی برای بررسی رفتار واکنش‌گرا است',
                ),
                value: Text(
                  'این مقدار نیز بسیار طولانی است و باید بدون ایجاد overflow '
                  'در فضای موجود نمایش داده شود.',
                ),
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
    });

    testWidgets('works inside a narrow parent', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 120,
              child: PKeyValue(
                label: Text('وضعیت'),
                value: Text('فعال'),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(PKeyValue), findsOneWidget);
      expect(find.text('وضعیت'), findsOneWidget);
      expect(find.text('فعال'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('supports RTL layout', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: PKeyValue(
                label: Text('نام'),
                value: Text('کیان'),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(PKeyValue), findsOneWidget);
      expect(find.text('نام'), findsOneWidget);
      expect(find.text('کیان'), findsOneWidget);
    });

    testWidgets('supports LTR layout', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              body: PKeyValue(
                label: Text('Name'),
                value: Text('Kian'),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(PKeyValue), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Kian'), findsOneWidget);
    });

    testWidgets('works inside Row', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                Expanded(
                  child: PKeyValue(
                    label: Text('نام'),
                    value: Text('کیان'),
                  ),
                ),
                Expanded(
                  child: PKeyValue(
                    label: Text('وضعیت'),
                    value: Text('فعال'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(PKeyValue), findsNWidgets(2));
      expect(find.text('کیان'), findsOneWidget);
      expect(find.text('فعال'), findsOneWidget);
    });

    testWidgets('supports complex widgets as value', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PKeyValue(
              label: Text('وضعیت'),
              value: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check),
                  SizedBox(width: 4),
                  Text('فعال'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.text('فعال'), findsOneWidget);
    });

    testWidgets('does not produce exceptions with empty text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PKeyValue(
              label: Text(''),
              value: Text(''),
            ),
          ),
        ),
      );

      expect(find.byType(PKeyValue), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}