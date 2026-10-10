
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/src/layout/p_container.dart';

void main() {
  group('PContainer', () {
    testWidgets('renders child', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PContainer(
            child: Text('Content'),
          ),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('uses top center alignment by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PContainer(
            child: Text('Content'),
          ),
        ),
      );

      final alignFinder = find.byType(Align);
      expect(alignFinder, findsOneWidget);

      final align = tester.widget<Align>(alignFinder);
      expect(align.alignment, Alignment.topCenter);
    });

    testWidgets('applies custom alignment', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PContainer(
            alignment: Alignment.bottomRight,
            child: Text('Content'),
          ),
        ),
      );

      final align = tester.widget<Align>(find.byType(Align));

      expect(align.alignment, Alignment.bottomRight);
    });

    testWidgets('applies max width constraint', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PContainer(
            maxWidth: 300,
            child: Text('Content'),
          ),
        ),
      );

      final container = tester.widget<PContainer>(
        find.byType(PContainer),
      );

      expect(container.maxWidth, 300);
    });

    testWidgets('constrains oversized child to maxWidth', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Center(
            child: PContainer(
              maxWidth: 300,
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 500,
                height: 20,
              ),
            ),
          ),
        ),
      );

      final childSize = tester.getSize(find.byType(SizedBox));

      expect(childSize.width, 300);
    });

    test('allows zero maxWidth', () {
      const container = PContainer(
        maxWidth: 0,
        child: SizedBox(),
      );

      expect(container.maxWidth, 0);
    });

    test('rejects negative maxWidth', () {
      expect(
        () => PContainer(
          maxWidth: -10,
          child: const SizedBox(),
        ),
        throwsAssertionError,
      );
    });

    testWidgets('does not set maxWidth when maxWidth is null', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PContainer(
            child: Text('Content'),
          ),
        ),
      );

      final container = tester.widget<PContainer>(
        find.byType(PContainer),
      );

      expect(container.maxWidth, isNull);
    });

    testWidgets('applies padding', (tester) async {
      const padding = EdgeInsets.all(16);

      await tester.pumpWidget(
        const MaterialApp(
          home: PContainer(
            padding: padding,
            child: Text('Content'),
          ),
        ),
      );

      final paddingWidgets = tester
          .widgetList<Padding>(find.byType(Padding))
          .toList();

      expect(
        paddingWidgets.any(
          (widget) => widget.padding == padding,
        ),
        isTrue,
      );
    });

    testWidgets('applies margin', (tester) async {
      const margin = EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: PContainer(
            margin: margin,
            child: Text('Content'),
          ),
        ),
      );

      final paddingWidgets = tester
          .widgetList<Padding>(find.byType(Padding))
          .toList();

      expect(paddingWidgets.length, 1);
      expect(paddingWidgets.first.padding, margin);
    });

    testWidgets('supports padding and margin together', (tester) async {
      const padding = EdgeInsets.all(12);
      const margin = EdgeInsets.all(20);

      await tester.pumpWidget(
        const MaterialApp(
          home: PContainer(
            padding: padding,
            margin: margin,
            child: Text('Content'),
          ),
        ),
      );

      final paddingWidgets = tester
          .widgetList<Padding>(find.byType(Padding))
          .toList();

      expect(paddingWidgets.length, 2);

      expect(
        paddingWidgets.any(
          (widget) => widget.padding == padding,
        ),
        isTrue,
      );

      expect(
        paddingWidgets.any(
          (widget) => widget.padding == margin,
        ),
        isTrue,
      );
    });

    testWidgets('applies padding inside margin', (tester) async {
      const padding = EdgeInsets.all(12);
      const margin = EdgeInsets.all(20);

      await tester.pumpWidget(
        const MaterialApp(
          home: PContainer(
            padding: padding,
            margin: margin,
            child: SizedBox(
              width: 40,
              height: 30,
            ),
          ),
        ),
      );

      final paddingWidgets = tester
          .widgetList<Padding>(find.byType(Padding))
          .toList();

      final marginWidget = paddingWidgets.singleWhere(
        (widget) => widget.padding == margin,
      );
      final innerPaddingWidget = paddingWidgets.singleWhere(
        (widget) => widget.padding == padding,
      );

      expect(marginWidget.child, same(innerPaddingWidget));
    });

    testWidgets('supports directional padding in RTL', (tester) async {
      const padding = EdgeInsetsDirectional.only(
        start: 10,
        end: 20,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: PContainer(
              padding: padding,
              child: SizedBox(
                width: 40,
                height: 20,
              ),
            ),
          ),
        ),
      );

      final paddingWidget = tester.widget<Padding>(
        find.byType(Padding),
      );

      expect(paddingWidget.padding, padding);

      final childRect = tester.getRect(find.byType(SizedBox));

      expect(childRect.width, 40);
    });

    testWidgets('supports RTL layout', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: PContainer(
              alignment: AlignmentDirectional.centerStart,
              child: Text('محتوا'),
            ),
          ),
        ),
      );

      final align = tester.widget<Align>(
        find.byType(Align),
      );

      expect(
        align.alignment,
        AlignmentDirectional.centerStart,
      );
    });

    testWidgets('supports LTR layout', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: PContainer(
              alignment: AlignmentDirectional.centerStart,
              child: Text('Content'),
            ),
          ),
        ),
      );

      final align = tester.widget<Align>(
        find.byType(Align),
      );

      expect(
        align.alignment,
        AlignmentDirectional.centerStart,
      );
    });
  });
}