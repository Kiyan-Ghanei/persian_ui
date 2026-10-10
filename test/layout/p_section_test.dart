
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/src/layout/p_section.dart';

void main() {
  group('PSection', () {
    testWidgets('renders child', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PSection(
            child: Text('Content'),
          ),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('renders title when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PSection(
            title: Text('Section Title'),
            child: Text('Content'),
          ),
        ),
      );

      expect(find.text('Section Title'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('renders trailing widget when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PSection(
            title: Text('Section Title'),
            trailing: Icon(Icons.more_horiz),
            child: Text('Content'),
          ),
        ),
      );

      expect(find.text('Section Title'), findsOneWidget);
      expect(find.byIcon(Icons.more_horiz), findsOneWidget);
    });

    testWidgets(
      'renders content without header when title and trailing are null',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: PSection(
              child: Text('Content'),
            ),
          ),
        );

        expect(find.byType(Row), findsNothing);
        expect(find.byType(SizedBox), findsNothing);
        expect(find.text('Content'), findsOneWidget);
      },
    );

    testWidgets('renders header when only trailing is provided', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PSection(
            trailing: Icon(Icons.more_horiz),
            child: Text('Content'),
          ),
        ),
      );

      expect(find.byType(Row), findsOneWidget);
      expect(find.byIcon(Icons.more_horiz), findsOneWidget);
    });

    testWidgets('renders header spacing when title is provided', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PSection(
            title: Text('Section Title'),
            child: Text('Content'),
          ),
        ),
      );

      final sizedBoxes = tester
          .widgetList<SizedBox>(find.byType(SizedBox))
          .toList();

      expect(
        sizedBoxes.any((box) => box.height == 12),
        isTrue,
      );
    });

    testWidgets('applies padding', (tester) async {
      const padding = EdgeInsets.all(16);

      await tester.pumpWidget(
        const MaterialApp(
          home: PSection(
            padding: padding,
            child: Text('Content'),
          ),
        ),
      );

      final paddingWidgets = tester
          .widgetList<Padding>(find.byType(Padding))
          .toList();

      expect(paddingWidgets.length, 1);
      expect(paddingWidgets.first.padding, padding);
    });

    testWidgets('applies margin', (tester) async {
      const margin = EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: PSection(
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
          home: PSection(
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

    testWidgets(
      'renders long title and trailing within constrained width',
      (tester) async {
        const availableWidth = 320.0;

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: availableWidth,
                  child: PSection(
                    title: Text(
                      'A very long section title that needs more space',
                    ),
                    trailing: Text('View all'),
                    child: Text('Content'),
                  ),
                ),
              ),
            ),
          ),
        );

        expect(
          find.text('A very long section title that needs more space'),
          findsOneWidget,
        );
        expect(find.text('View all'), findsOneWidget);
        expect(find.text('Content'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets('supports RTL layout', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: PSection(
              title: Text('عنوان'),
              trailing: Text('بیشتر'),
              child: Text('محتوا'),
            ),
          ),
        ),
      );

      expect(find.text('عنوان'), findsOneWidget);
      expect(find.text('بیشتر'), findsOneWidget);
      expect(find.text('محتوا'), findsOneWidget);
    });

    testWidgets('supports LTR layout', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: PSection(
              title: Text('Title'),
              trailing: Text('More'),
              child: Text('Content'),
            ),
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('More'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
    });
  });
}
