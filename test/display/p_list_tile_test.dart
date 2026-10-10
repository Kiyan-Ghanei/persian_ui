import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PListTile', () {
    testWidgets('displays title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PListTile(
            title: const Text('عنوان'),
          ),
        ),
      );

      expect(find.text('عنوان'), findsOneWidget);
    });

    testWidgets('displays leading when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PListTile(
            leading: const Icon(Icons.person),
            title: const Text('عنوان'),
          ),
        ),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('does not display leading when omitted', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PListTile(
            title: const Text('عنوان'),
          ),
        ),
      );

      expect(find.byIcon(Icons.person), findsNothing);
    });

    testWidgets('displays subtitle when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PListTile(
            title: const Text('عنوان'),
            subtitle: const Text('توضیحات'),
          ),
        ),
      );

      expect(find.text('توضیحات'), findsOneWidget);
    });

    testWidgets('does not display subtitle when omitted', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PListTile(
            title: const Text('عنوان'),
          ),
        ),
      );

      expect(find.text('توضیحات'), findsNothing);
    });

    testWidgets('displays trailing when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PListTile(
            title: const Text('عنوان'),
            trailing: const Icon(Icons.chevron_left),
          ),
        ),
      );

      expect(find.byIcon(Icons.chevron_left), findsOneWidget);
    });

    testWidgets('calls onTap when enabled', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: PListTile(
            title: const Text('عنوان'),
            onTap: () {
              tapped = true;
            },
          ),
        ),
      );

      await tester.tap(find.text('عنوان'));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('calls onLongPress when enabled', (tester) async {
      var longPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: PListTile(
            title: const Text('عنوان'),
            onLongPress: () {
              longPressed = true;
            },
          ),
        ),
      );

      await tester.longPress(find.text('عنوان'));
      await tester.pump();

      expect(longPressed, isTrue);
    });

    testWidgets('does not call callbacks when disabled', (tester) async {
      var tapped = false;
      var longPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: PListTile(
            title: const Text('عنوان'),
            onTap: () {
              tapped = true;
            },
            onLongPress: () {
              longPressed = true;
            },
            enabled: false,
          ),
        ),
      );

      await tester.tap(find.text('عنوان'));
      await tester.pump();

      await tester.longPress(find.text('عنوان'));
      await tester.pump();

      expect(tapped, isFalse);
      expect(longPressed, isFalse);
    });

    testWidgets('respects custom padding', (tester) async {
      const padding = EdgeInsets.all(32);

      await tester.pumpWidget(
        MaterialApp(
          home: PListTile(
            title: const Text('عنوان'),
            padding: padding,
          ),
        ),
      );

      final tilePadding = tester.widget<Padding>(
        find
            .ancestor(
              of: find.text('عنوان'),
              matching: find.byType(Padding),
            )
            .first,
      );

      expect(tilePadding.padding, padding);
    });

    testWidgets('supports RTL directionality', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: PListTile(
              leading: Icon(Icons.person),
              title: Text('عنوان'),
              trailing: Icon(Icons.chevron_left),
            ),
          ),
        ),
      );

      expect(find.text('عنوان'), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.chevron_left), findsOneWidget);
    });

    testWidgets('supports LTR directionality', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: PListTile(
              leading: Icon(Icons.person),
              title: Text('Title'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('handles long text without horizontal overflow', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(320, 480));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        MaterialApp(
          home: PListTile(
            leading: const Icon(Icons.info),
            title: const Text(
              'این یک عنوان بسیار طولانی برای بررسی رفتار responsive کامپوننت است',
            ),
            subtitle: const Text(
              'این توضیحات نیز عمداً طولانی هستند تا مطمئن شویم '
              'در عرض محدود باعث overflow نمی‌شوند',
            ),
            trailing: const Icon(Icons.chevron_left),
          ),
        ),
      );

      await tester.pump();

      expect(tester.takeException(), isNull);
    });

    testWidgets('supports complete content configuration', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PListTile(
            leading: const Icon(Icons.person),
            title: const Text('عنوان'),
            subtitle: const Text('توضیحات'),
            trailing: const Icon(Icons.chevron_left),
            onTap: () {},
            onLongPress: () {},
          ),
        ),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.text('عنوان'), findsOneWidget);
      expect(find.text('توضیحات'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_left), findsOneWidget);
    });

    testWidgets('provides button semantics when interactive', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        MaterialApp(
          home: PListTile(
            title: const Text('عنوان'),
            onTap: () {},
          ),
        ),
      );

      expect(
        find.bySemanticsLabel('عنوان'),
        findsOneWidget,
      );

      handle.dispose();
    });

    testWidgets('remains disabled for interaction when disabled', (
      tester,
    ) async {
      var tapped = false;

      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        MaterialApp(
          home: PListTile(
            title: const Text('عنوان'),
            onTap: () {
              tapped = true;
            },
            enabled: false,
          ),
        ),
      );

      await tester.tap(find.text('عنوان'));
      await tester.pump();

      expect(tapped, isFalse);
      expect(find.bySemanticsLabel('عنوان'), findsOneWidget);

      handle.dispose();
    });
  });
}