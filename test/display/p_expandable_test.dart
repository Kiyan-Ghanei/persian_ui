import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PExpandable', () {
    testWidgets('renders title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PExpandable(
              title: Text('اطلاعات'),
              child: Text('محتوا'),
            ),
          ),
        ),
      );

      expect(find.text('اطلاعات'), findsOneWidget);
    });

    testWidgets('hides child when initially collapsed', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PExpandable(
              title: Text('اطلاعات'),
              child: Text('محتوا'),
            ),
          ),
        ),
      );

      expect(find.text('محتوا'), findsNothing);
    });

    testWidgets('shows child when initially expanded', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PExpandable(
              title: Text('اطلاعات'),
              initiallyExpanded: true,
              child: Text('محتوا'),
            ),
          ),
        ),
      );

      expect(find.text('محتوا'), findsOneWidget);
    });

    testWidgets('expands when header is tapped', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PExpandable(
              title: Text('اطلاعات'),
              child: Text('محتوا'),
            ),
          ),
        ),
      );

      expect(find.text('محتوا'), findsNothing);

      await tester.tap(find.text('اطلاعات'));
      await tester.pumpAndSettle();

      expect(find.text('محتوا'), findsOneWidget);
    });

    testWidgets('collapses when expanded header is tapped', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PExpandable(
              title: Text('اطلاعات'),
              initiallyExpanded: true,
              child: Text('محتوا'),
            ),
          ),
        ),
      );

      expect(find.text('محتوا'), findsOneWidget);

      await tester.tap(find.text('اطلاعات'));
      await tester.pumpAndSettle();

      expect(find.text('محتوا'), findsNothing);
    });

    testWidgets('calls callback with true when expanded', (tester) async {
      bool? expandedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PExpandable(
              title: const Text('اطلاعات'),
              onExpansionChanged: (value) {
                expandedValue = value;
              },
              child: const Text('محتوا'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('اطلاعات'));
      await tester.pumpAndSettle();

      expect(expandedValue, isTrue);
    });

    testWidgets('calls callback with false when collapsed', (tester) async {
      bool? expandedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PExpandable(
              title: const Text('اطلاعات'),
              initiallyExpanded: true,
              onExpansionChanged: (value) {
                expandedValue = value;
              },
              child: const Text('محتوا'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('اطلاعات'));
      await tester.pumpAndSettle();

      expect(expandedValue, isFalse);
    });

    testWidgets('renders leading widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PExpandable(
              leading: Icon(Icons.info),
              title: Text('اطلاعات'),
              child: Text('محتوا'),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('renders custom trailing widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PExpandable(
              title: Text('اطلاعات'),
              trailing: Icon(Icons.chevron_left),
              child: Text('محتوا'),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.chevron_left), findsOneWidget);
    });

    testWidgets('renders default expansion indicator', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PExpandable(
              title: Text('اطلاعات'),
              child: Text('محتوا'),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.expand_more), findsOneWidget);
    });

    testWidgets('rotates default indicator when expanded', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PExpandable(
              title: Text('اطلاعات'),
              child: Text('محتوا'),
            ),
          ),
        ),
      );

      final rotationFinder = find.byType(AnimatedRotation);

      expect(rotationFinder, findsOneWidget);

      final before = tester.widget<AnimatedRotation>(rotationFinder);
      expect(before.turns, 0);

      await tester.tap(find.text('اطلاعات'));
      await tester.pump();

      final after = tester.widget<AnimatedRotation>(rotationFinder);
      expect(after.turns, 0.5);
    });

    testWidgets('respects custom padding', (tester) async {
      const customPadding = EdgeInsets.all(24);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PExpandable(
              title: Text('اطلاعات'),
              padding: customPadding,
              child: Text('محتوا'),
            ),
          ),
        ),
      );

      final expandable = find.byType(PExpandable);

      final paddingFinder = find.descendant(
        of: expandable,
        matching: find.byWidgetPredicate(
          (widget) {
            return widget is Padding && widget.padding == customPadding;
          },
        ),
      );

      expect(paddingFinder, findsOneWidget);
    });

    testWidgets('works correctly in RTL direction', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: PExpandable(
                leading: Icon(Icons.info),
                title: Text('اطلاعات'),
                child: Text('محتوا'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('اطلاعات'), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('works correctly in LTR direction', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              body: PExpandable(
                leading: Icon(Icons.info),
                title: Text('Information'),
                child: Text('Content'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Information'), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('does not overflow in a constrained layout', (tester) async {
      await tester.binding.setSurfaceSize(const Size(320, 480));

      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PExpandable(
              title: Text('اطلاعات طولانی'),
              child: Text(
                'این یک محتوای نسبتاً طولانی برای بررسی رفتار '
                'واکنش‌گرا و جلوگیری از Overflow است.',
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('اطلاعات طولانی'));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });

    testWidgets('works inside a narrow parent', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 180,
              child: PExpandable(
                title: Text('عنوان'),
                child: Text('محتوا'),
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
    });

    testWidgets('works inside a Column', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                PExpandable(
                  title: Text('بخش اول'),
                  child: Text('محتوای اول'),
                ),
                PExpandable(
                  title: Text('بخش دوم'),
                  child: Text('محتوای دوم'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('بخش اول'), findsOneWidget);
      expect(find.text('بخش دوم'), findsOneWidget);
    });

    testWidgets('exposes semantic title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PExpandable(
              title: Text('اطلاعات'),
              child: Text('محتوا'),
            ),
          ),
        ),
      );

      expect(
        find.bySemanticsLabel('اطلاعات'),
        findsOneWidget,
      );
    });

    testWidgets('keeps semantic title after expansion', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PExpandable(
              title: Text('اطلاعات'),
              child: Text('محتوا'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('اطلاعات'));
      await tester.pumpAndSettle();

      expect(
        find.bySemanticsLabel('اطلاعات'),
        findsOneWidget,
      );
    });

    testWidgets('supports empty child', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PExpandable(
              title: Text('اطلاعات'),
              child: SizedBox.shrink(),
            ),
          ),
        ),
      );

      await tester.tap(find.text('اطلاعات'));
      await tester.pumpAndSettle();

      expect(find.text('اطلاعات'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}