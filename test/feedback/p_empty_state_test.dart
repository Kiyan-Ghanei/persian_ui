import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PEmptyState', () {
    testWidgets('renders title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PEmptyState(
            title: Text('موردی پیدا نشد'),
          ),
        ),
      );

      expect(find.text('موردی پیدا نشد'), findsOneWidget);
    });

    testWidgets('renders icon when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PEmptyState(
            icon: Icon(Icons.inbox_outlined),
            title: Text('موردی پیدا نشد'),
          ),
        ),
      );

      expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
    });

    testWidgets('does not render icon when omitted', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PEmptyState(
            title: Text('موردی پیدا نشد'),
          ),
        ),
      );

      expect(find.byIcon(Icons.inbox_outlined), findsNothing);
    });

    testWidgets('renders description when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PEmptyState(
            title: Text('موردی پیدا نشد'),
            description: Text('هنوز محتوایی برای نمایش وجود ندارد.'),
          ),
        ),
      );

      expect(
        find.text('هنوز محتوایی برای نمایش وجود ندارد.'),
        findsOneWidget,
      );
    });

    testWidgets('does not render description when omitted', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PEmptyState(
            title: Text('موردی پیدا نشد'),
          ),
        ),
      );

      expect(
        find.text('هنوز محتوایی برای نمایش وجود ندارد.'),
        findsNothing,
      );
    });

    testWidgets('renders arbitrary action widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PEmptyState(
            title: const Text('موردی پیدا نشد'),
            action: ElevatedButton(
              onPressed: () {},
              child: const Text('افزودن'),
            ),
          ),
        ),
      );

      expect(find.text('افزودن'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('does not render action when omitted', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PEmptyState(
            title: Text('موردی پیدا نشد'),
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('supports custom padding', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PEmptyState(
            title: Text('موردی پیدا نشد'),
            padding: EdgeInsets.all(32),
          ),
        ),
      );

      final padding = tester.widget<Padding>(
        find.ancestor(
          of: find.text('موردی پیدا نشد'),
          matching: find.byType(Padding),
        ),
      );

      expect(padding.padding, const EdgeInsets.all(32));
    });

    testWidgets('renders all optional content together', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PEmptyState(
            icon: const Icon(Icons.inbox_outlined),
            title: const Text('موردی پیدا نشد'),
            description: const Text('محتوایی وجود ندارد.'),
            action: TextButton(
              onPressed: () {},
              child: const Text('تلاش مجدد'),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
      expect(find.text('موردی پیدا نشد'), findsOneWidget);
      expect(find.text('محتوایی وجود ندارد.'), findsOneWidget);
      expect(find.text('تلاش مجدد'), findsOneWidget);
    });

    testWidgets('adapts to narrow constraints without overflow', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(
        const Size(320, 480),
      );

      addTearDown(() async {
        await tester.binding.setSurfaceSize(null);
      });

      await tester.pumpWidget(
        const MaterialApp(
          home: PEmptyState(
            title: Text('موردی برای نمایش پیدا نشد'),
            description: Text(
              'در حال حاضر هیچ محتوایی برای نمایش وجود ندارد.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );

      expect(find.text('موردی برای نمایش پیدا نشد'), findsOneWidget);
      expect(
        find.text('در حال حاضر هیچ محتوایی برای نمایش وجود ندارد.'),
        findsOneWidget,
      );

      expect(tester.takeException(), isNull);
    });

    testWidgets('works with RTL directionality', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: PEmptyState(
              title: Text('موردی پیدا نشد'),
            ),
          ),
        ),
      );

      expect(find.text('موردی پیدا نشد'), findsOneWidget);
    });
  });
}