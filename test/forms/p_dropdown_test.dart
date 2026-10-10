import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PDropdownItem', () {
    test('stores required values', () {
      const item = PDropdownItem<String>(
        value: 'iran',
        label: 'ایران',
      );

      expect(item.value, 'iran');
      expect(item.label, 'ایران');
      expect(item.labelWidget, isNull);
      expect(item.enabled, isTrue);
    });

    test('supports disabled items', () {
      const item = PDropdownItem<String>(
        value: 'iran',
        label: 'ایران',
        enabled: false,
      );

      expect(item.enabled, isFalse);
    });

    test('supports a custom label widget', () {
      const item = PDropdownItem<String>(
        value: 'iran',
        label: 'ایران',
        labelWidget: Icon(Icons.flag),
      );

      expect(item.labelWidget, isA<Icon>());
    });

    test('supports generic integer values', () {
      const item = PDropdownItem<int>(
        value: 10,
        label: 'ده',
      );

      expect(item.value, 10);
      expect(item.label, 'ده');
    });

    test('supports const construction', () {
      const item = PDropdownItem<String>(
        value: 'test',
        label: 'Test',
      );

      expect(item.value, 'test');
    });
  });

  group('PDropdown', () {
    const items = <PDropdownItem<String>>[
      PDropdownItem<String>(
        value: 'iran',
        label: 'ایران',
      ),
      PDropdownItem<String>(
        value: 'germany',
        label: 'آلمان',
      ),
      PDropdownItem<String>(
        value: 'turkey',
        label: 'ترکیه',
      ),
    ];

    Widget buildTestWidget({
      String? value,
      ValueChanged<String?>? onChanged,
      Widget? label,
      String? hintText,
      EdgeInsetsGeometry? padding,
      bool enabled = true,
      List<PDropdownItem<String>> dropdownItems = items,
      TextDirection textDirection = TextDirection.ltr,
    }) {
      return MaterialApp(
        home: Directionality(
          textDirection: textDirection,
          child: Scaffold(
            body: PDropdown<String>(
              value: value,
              items: dropdownItems,
              onChanged: onChanged,
              label: label,
              hintText: hintText,
              padding: padding,
              enabled: enabled,
            ),
          ),
        ),
      );
    }

    testWidgets('renders PDropdown', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: 'iran',
          onChanged: (_) {},
        ),
      );

      expect(find.byType(PDropdown<String>), findsOneWidget);
      expect(find.byType(DropdownMenu<String>), findsOneWidget);
    });

    testWidgets('renders with selected value', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: 'iran',
          onChanged: (_) {},
        ),
      );

      final dropdown = tester.widget<DropdownMenu<String>>(
        find.byType(DropdownMenu<String>),
      );

      expect(dropdown.initialSelection, 'iran');
    });

    testWidgets('supports null value', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: null,
          onChanged: (_) {},
          hintText: 'انتخاب کنید',
        ),
      );

      final dropdown = tester.widget<DropdownMenu<String>>(
        find.byType(DropdownMenu<String>),
      );

      expect(dropdown.initialSelection, isNull);
      expect(dropdown.hintText, 'انتخاب کنید');
    });

    testWidgets('passes onChanged callback', (tester) async {
      String? selectedValue;

      await tester.pumpWidget(
        buildTestWidget(
          value: 'iran',
          onChanged: (value) {
            selectedValue = value;
          },
        ),
      );

      await tester.tap(find.byType(DropdownMenu<String>));
      await tester.pumpAndSettle();

      expect(find.text('آلمان'), findsNWidgets(2));

      await tester.tap(find.text('آلمان').last);
      await tester.pumpAndSettle();

      expect(selectedValue, 'germany');
    });

    testWidgets('supports selecting the third item', (tester) async {
      String? selectedValue;

      await tester.pumpWidget(
        buildTestWidget(
          value: 'iran',
          onChanged: (value) {
            selectedValue = value;
          },
        ),
      );

      await tester.tap(find.byType(DropdownMenu<String>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('ترکیه').last);
      await tester.pumpAndSettle();

      expect(selectedValue, 'turkey');
    });

    testWidgets('is disabled when onChanged is null', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: 'iran',
          onChanged: null,
        ),
      );

      final dropdown = tester.widget<DropdownMenu<String>>(
        find.byType(DropdownMenu<String>),
      );

      expect(dropdown.enabled, isFalse);
      expect(dropdown.onSelected, isNull);
    });

    testWidgets('is disabled when enabled is false', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: 'iran',
          onChanged: (_) {},
          enabled: false,
        ),
      );

      final dropdown = tester.widget<DropdownMenu<String>>(
        find.byType(DropdownMenu<String>),
      );

      expect(dropdown.enabled, isFalse);
    });

    testWidgets(
      'is enabled when enabled is true and onChanged is provided',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            value: 'iran',
            onChanged: (_) {},
            enabled: true,
          ),
        );

        final dropdown = tester.widget<DropdownMenu<String>>(
          find.byType(DropdownMenu<String>),
        );

        expect(dropdown.enabled, isTrue);
        expect(dropdown.onSelected, isNotNull);
      },
    );

    testWidgets('passes label to DropdownMenu', (tester) async {
      const label = Text('کشور');

      await tester.pumpWidget(
        buildTestWidget(
          value: null,
          onChanged: (_) {},
          label: label,
        ),
      );

      final dropdown = tester.widget<DropdownMenu<String>>(
        find.byType(DropdownMenu<String>),
      );

      expect(dropdown.label, same(label));
    });

    testWidgets('supports hint text', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: null,
          onChanged: (_) {},
          hintText: 'یک کشور انتخاب کنید',
        ),
      );

      final dropdown = tester.widget<DropdownMenu<String>>(
        find.byType(DropdownMenu<String>),
      );

      expect(dropdown.hintText, 'یک کشور انتخاب کنید');
    });

    testWidgets('applies padding when provided', (tester) async {
      const padding = EdgeInsets.all(24);

      await tester.pumpWidget(
        buildTestWidget(
          value: 'iran',
          onChanged: (_) {},
          padding: padding,
        ),
      );

      final dropdown = tester.widget<PDropdown<String>>(
        find.byType(PDropdown<String>),
      );

      expect(dropdown.padding, padding);
    });

    testWidgets('does not add outer Padding when padding is null', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: 'iran',
          onChanged: (_) {},
        ),
      );

      final dropdown = tester.widget<PDropdown<String>>(
        find.byType(PDropdown<String>),
      );

      expect(dropdown.padding, isNull);
    });

    testWidgets('supports RTL directionality', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: 'iran',
          onChanged: (_) {},
          label: const Text('کشور'),
          textDirection: TextDirection.rtl,
        ),
      );

      final directionality = tester.widget<Directionality>(
        find.ancestor(
          of: find.byType(PDropdown<String>),
          matching: find.byType(Directionality),
        ).first,
      );

      expect(directionality.textDirection, TextDirection.rtl);
    });

    testWidgets('supports LTR directionality', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: 'iran',
          onChanged: (_) {},
          label: const Text('Country'),
          textDirection: TextDirection.ltr,
        ),
      );

      final directionality = tester.widget<Directionality>(
        find.ancestor(
          of: find.byType(PDropdown<String>),
          matching: find.byType(Directionality),
        ).first,
      );

      expect(directionality.textDirection, TextDirection.ltr);
    });

    testWidgets('supports disabled items', (tester) async {
      const dropdownItems = <PDropdownItem<String>>[
        PDropdownItem<String>(
          value: 'enabled',
          label: 'فعال',
        ),
        PDropdownItem<String>(
          value: 'disabled',
          label: 'غیرفعال',
          enabled: false,
        ),
      ];

      await tester.pumpWidget(
        buildTestWidget(
          value: 'enabled',
          onChanged: (_) {},
          dropdownItems: dropdownItems,
        ),
      );

      final dropdown = tester.widget<DropdownMenu<String>>(
        find.byType(DropdownMenu<String>),
      );

      final enabledEntry = dropdown.dropdownMenuEntries.firstWhere(
        (entry) => entry.value == 'enabled',
      );

      final disabledEntry = dropdown.dropdownMenuEntries.firstWhere(
        (entry) => entry.value == 'disabled',
      );

      expect(enabledEntry.enabled, isTrue);
      expect(disabledEntry.enabled, isFalse);
    });

    testWidgets('passes custom label widget to menu entry', (tester) async {
      const customKey = Key('custom-label');

      const dropdownItems = <PDropdownItem<String>>[
        PDropdownItem<String>(
          value: 'iran',
          label: 'ایران',
          labelWidget: SizedBox(
            key: customKey,
            width: 80,
            height: 40,
            child: Text('ایران'),
          ),
        ),
      ];

      await tester.pumpWidget(
        buildTestWidget(
          value: 'iran',
          onChanged: (_) {},
          dropdownItems: dropdownItems,
        ),
      );

      final dropdown = tester.widget<DropdownMenu<String>>(
        find.byType(DropdownMenu<String>),
      );

      final entry = dropdown.dropdownMenuEntries.single;

      expect(entry.labelWidget, isNotNull);
      expect(entry.labelWidget!.key, customKey);
    });

    testWidgets('supports integer generic values', (tester) async {
      int? selectedValue;

      const integerItems = <PDropdownItem<int>>[
        PDropdownItem<int>(
          value: 1,
          label: 'یک',
        ),
        PDropdownItem<int>(
          value: 2,
          label: 'دو',
        ),
        PDropdownItem<int>(
          value: 3,
          label: 'سه',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PDropdown<int>(
              value: 1,
              items: integerItems,
              onChanged: (value) {
                selectedValue = value;
              },
            ),
          ),
        ),
      );

      final dropdown = tester.widget<DropdownMenu<int>>(
        find.byType(DropdownMenu<int>),
      );

      expect(dropdown.initialSelection, 1);

      await tester.tap(find.byType(DropdownMenu<int>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('دو').last);
      await tester.pumpAndSettle();

      expect(selectedValue, 2);
    });

    testWidgets('supports long labels without throwing', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: null,
          onChanged: (_) {},
          label: const Text(
            'این یک عنوان طولانی برای بررسی رفتار '
            'PDropdown در شرایط مختلف صفحه است',
          ),
          hintText: 'یک گزینه را از فهرست انتخاب کنید',
        ),
      );

      expect(tester.takeException(), isNull);
      expect(find.byType(PDropdown<String>), findsOneWidget);
      expect(find.byType(DropdownMenu<String>), findsOneWidget);
    });

    testWidgets('supports constrained layouts without overflow', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 220,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: PDropdown<String>(
                  value: null,
                  items: items,
                  onChanged: (_) {},
                  label: const Text('کشور مورد نظر'),
                  hintText: 'انتخاب کشور',
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.byType(PDropdown<String>), findsOneWidget);
      expect(find.byType(DropdownMenu<String>), findsOneWidget);
    });

    testWidgets('supports rebuild with a changed value', (tester) async {
      String? value = 'iran';

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Scaffold(
                body: PDropdown<String>(
                  value: value,
                  items: items,
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
        tester
            .widget<DropdownMenu<String>>(
              find.byType(DropdownMenu<String>),
            )
            .initialSelection,
        'iran',
      );

      await tester.tap(find.byType(DropdownMenu<String>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('آلمان').last);
      await tester.pumpAndSettle();

      expect(value, 'germany');

      expect(
        tester
            .widget<DropdownMenu<String>>(
              find.byType(DropdownMenu<String>),
            )
            .initialSelection,
        'germany',
      );
    });

    testWidgets('supports changing value from a parent rebuild', (
      tester,
    ) async {
      String? selectedValue = 'iran';

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Scaffold(
                body: Column(
                  children: [
                    PDropdown<String>(
                      value: selectedValue,
                      items: items,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedValue = 'turkey';
                        });
                      },
                      child: const Text('Change'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

      expect(
        tester
            .widget<DropdownMenu<String>>(
              find.byType(DropdownMenu<String>),
            )
            .initialSelection,
        'iran',
      );

      await tester.tap(find.text('Change'));
      await tester.pumpAndSettle();

      expect(
        tester
            .widget<DropdownMenu<String>>(
              find.byType(DropdownMenu<String>),
            )
            .initialSelection,
        'turkey',
      );
    });

    testWidgets('uses select-only mode', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: 'iran',
          onChanged: (_) {},
        ),
      );

      final dropdown = tester.widget<DropdownMenu<String>>(
        find.byType(DropdownMenu<String>),
      );

      expect(dropdown.selectOnly, isTrue);
    });

    testWidgets('does not enable filter mode', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: 'iran',
          onChanged: (_) {},
        ),
      );

      final dropdown = tester.widget<DropdownMenu<String>>(
        find.byType(DropdownMenu<String>),
      );

      expect(dropdown.enableFilter, isFalse);
    });

    testWidgets('supports const construction', (tester) async {
      const dropdown = PDropdown<String>(
        value: null,
        items: [
          PDropdownItem<String>(
            value: 'iran',
            label: 'ایران',
          ),
        ],
        onChanged: null,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: dropdown,
          ),
        ),
      );

      expect(find.byType(PDropdown<String>), findsOneWidget);
    });

    testWidgets('does not throw for an empty item list', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: null,
          dropdownItems: const <PDropdownItem<String>>[],
          onChanged: (_) {},
          hintText: 'گزینه‌ای وجود ندارد',
        ),
      );

      expect(tester.takeException(), isNull);
      expect(find.byType(PDropdown<String>), findsOneWidget);
    });

    testWidgets('preserves the item order', (tester) async {
      const orderedItems = <PDropdownItem<String>>[
        PDropdownItem<String>(
          value: 'first',
          label: 'اول',
        ),
        PDropdownItem<String>(
          value: 'second',
          label: 'دوم',
        ),
        PDropdownItem<String>(
          value: 'third',
          label: 'سوم',
        ),
      ];

      await tester.pumpWidget(
        buildTestWidget(
          value: 'first',
          onChanged: (_) {},
          dropdownItems: orderedItems,
        ),
      );

      final dropdown = tester.widget<DropdownMenu<String>>(
        find.byType(DropdownMenu<String>),
      );

      expect(dropdown.dropdownMenuEntries.length, 3);
      expect(dropdown.dropdownMenuEntries[0].value, 'first');
      expect(dropdown.dropdownMenuEntries[1].value, 'second');
      expect(dropdown.dropdownMenuEntries[2].value, 'third');
    });

    testWidgets('has no exception after opening and closing the menu', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: 'iran',
          onChanged: (_) {},
        ),
      );

      await tester.tap(find.byType(DropdownMenu<String>));
      await tester.pumpAndSettle();

      await tester.tapAt(const Offset(20, 20));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  });
}