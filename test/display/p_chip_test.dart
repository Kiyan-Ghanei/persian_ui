import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: child,
        ),
      ),
    );
  }

  group('PChip', () {
    testWidgets(
      'renders label',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            const PChip(label: 'هوش مصنوعی'),
          ),
        );

        expect(find.text('هوش مصنوعی'), findsOneWidget);
      },
    );

    testWidgets(
      'renders leading widget',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            const PChip(
              label: 'خانه',
              leading: Icon(Icons.home),
            ),
          ),
        );

        expect(find.byIcon(Icons.home), findsOneWidget);
      },
    );

    testWidgets(
      'renders trailing widget',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            const PChip(
              label: 'تنظیمات',
              trailing: Icon(Icons.settings),
            ),
          ),
        );

        expect(find.byIcon(Icons.settings), findsOneWidget);
      },
    );

    testWidgets(
      'calls onTap when enabled',
      (tester) async {
        var tapped = false;

        await tester.pumpWidget(
          buildTestWidget(
            PChip(
              label: 'فعال',
              onTap: () {
                tapped = true;
              },
            ),
          ),
        );

        await tester.tap(find.text('فعال'));
        await tester.pump();

        expect(tapped, isTrue);
      },
    );

    testWidgets(
      'does not call onTap when disabled',
      (tester) async {
        var tapped = false;

        await tester.pumpWidget(
          buildTestWidget(
            PChip(
              label: 'غیرفعال',
              enabled: false,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        );

        await tester.tap(find.text('غیرفعال'));
        await tester.pump();

        expect(tapped, isFalse);
      },
    );

    testWidgets(
      'supports selected state',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            const PChip(
              label: 'انتخاب شده',
              selected: true,
            ),
          ),
        );

        final chipFinder = find.byType(PChip);
        final semanticsFinder = find.descendant(
          of: chipFinder,
          matching: find.byType(Semantics),
        );

        expect(find.text('انتخاب شده'), findsOneWidget);
        expect(semanticsFinder, findsNothing);
      },
    );

    testWidgets(
      'applies custom background color',
      (tester) async {
        const backgroundColor = Colors.blue;

        await tester.pumpWidget(
          buildTestWidget(
            const PChip(
              label: 'آبی',
              backgroundColor: backgroundColor,
            ),
          ),
        );

        final containers = find.descendant(
          of: find.byType(PChip),
          matching: find.byType(Container),
        );

        expect(containers, findsOneWidget);

        final container = tester.widget<Container>(
          containers.first,
        );

        final decoration = container.decoration! as BoxDecoration;

        expect(decoration.color, backgroundColor);
      },
    );

    testWidgets(
      'applies selected background color',
      (tester) async {
        const selectedColor = Colors.green;

        await tester.pumpWidget(
          buildTestWidget(
            const PChip(
              label: 'سبز',
              selected: true,
              selectedBackgroundColor: selectedColor,
            ),
          ),
        );

        final container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(PChip),
                matching: find.byType(Container),
              )
              .first,
        );

        final decoration = container.decoration! as BoxDecoration;

        expect(decoration.color, selectedColor);
      },
    );

    testWidgets(
      'applies custom foreground color',
      (tester) async {
        const foregroundColor = Colors.white;

        await tester.pumpWidget(
          buildTestWidget(
            const PChip(
              label: 'سفید',
              foregroundColor: foregroundColor,
            ),
          ),
        );

        final text = tester.widget<Text>(
          find.text('سفید'),
        );

        expect(text.style?.color, foregroundColor);
      },
    );

    testWidgets(
      'supports delete action',
      (tester) async {
        var deleted = false;

        await tester.pumpWidget(
          buildTestWidget(
            PChip(
              label: 'حذف',
              onDeleted: () {
                deleted = true;
              },
            ),
          ),
        );

        expect(find.byIcon(Icons.close), findsOneWidget);

        await tester.tap(find.byIcon(Icons.close));
        await tester.pump();

        expect(deleted, isTrue);
      },
    );

    testWidgets(
      'does not delete when disabled',
      (tester) async {
        var deleted = false;

        await tester.pumpWidget(
          buildTestWidget(
            PChip(
              label: 'غیرفعال',
              enabled: false,
              onDeleted: () {
                deleted = true;
              },
            ),
          ),
        );

        await tester.tap(find.byIcon(Icons.close));
        await tester.pump();

        expect(deleted, isFalse);
      },
    );

    testWidgets(
      'applies custom border color',
      (tester) async {
        const borderColor = Colors.red;

        await tester.pumpWidget(
          buildTestWidget(
            const PChip(
              label: 'مرز',
              borderColor: borderColor,
            ),
          ),
        );

        final container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(PChip),
                matching: find.byType(Container),
              )
              .first,
        );

        final decoration = container.decoration! as BoxDecoration;

        expect(decoration.border, isNotNull);

        expect(
          (decoration.border! as Border).top.color,
          borderColor,
        );
      },
    );
        testWidgets(
          'supports custom padding',
          (tester) async {
            const customPadding = EdgeInsets.all(16);

            await tester.pumpWidget(
              buildTestWidget(
                const PChip(
                  label: 'فاصله',
                  padding: customPadding,
                ),
              ),
            );

            final paddingFinder = find.byWidgetPredicate(
              (widget) =>
                  widget is Padding &&
                  widget.padding == customPadding,
            );

            expect(paddingFinder, findsOneWidget);

            final padding = tester.widget<Padding>(
              paddingFinder,
            );

            expect(padding.padding, customPadding);
          },
        );
    testWidgets(
      'supports semantic label',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            const PChip(
              label: 'وضعیت',
              semanticLabel: 'وضعیت فعال',
            ),
          ),
        );

        final semanticsFinder = find.descendant(
          of: find.byType(PChip),
          matching: find.byType(Semantics),
        );

        expect(semanticsFinder, findsOneWidget);

        final semantics = tester.widget<Semantics>(
          semanticsFinder,
        );

        expect(
          semantics.properties.label,
          'وضعیت فعال',
        );

        expect(
          semantics.properties.enabled,
          true,
        );

        expect(
          semantics.properties.selected,
          false,
        );
      },
    );

    testWidgets(
      'semantic properties reflect selected state',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            const PChip(
              label: 'انتخاب',
              selected: true,
              semanticLabel: 'گزینه انتخاب شده',
            ),
          ),
        );

        final semantics = tester.widget<Semantics>(
          find.descendant(
            of: find.byType(PChip),
            matching: find.byType(Semantics),
          ),
        );

        expect(
          semantics.properties.selected,
          true,
        );
      },
    );

    testWidgets(
      'works correctly in RTL',
      (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.rtl,
            child: const PChip(
              label: 'فارسی',
              leading: Icon(Icons.star),
            ),
          ),
        );

        expect(find.text('فارسی'), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
      },
    );

    testWidgets(
      'works correctly in LTR',
      (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: const PChip(
              label: 'English',
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
        );

        expect(find.text('English'), findsOneWidget);
        expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
      },
    );
  });
}