import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PErrorState', () {
    testWidgets('renders title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PErrorState(
            title: Text('خطایی رخ داد'),
          ),
        ),
      );

      expect(find.text('خطایی رخ داد'), findsOneWidget);
    });

    testWidgets('renders icon when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PErrorState(
            icon: Icon(Icons.error_outline),
            title: Text('خطایی رخ داد'),
          ),
        ),
      );

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('does not render icon when omitted', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PErrorState(
            title: Text('خطایی رخ داد'),
          ),
        ),
      );

      expect(find.byIcon(Icons.error_outline), findsNothing);
    });

    testWidgets('renders description when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PErrorState(
            title: Text('خطایی رخ داد'),
            description: Text('دریافت اطلاعات با مشکل مواجه شد.'),
          ),
        ),
      );

      expect(
        find.text('دریافت اطلاعات با مشکل مواجه شد.'),
        findsOneWidget,
      );
    });

    testWidgets('does not render description when omitted', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PErrorState(
            title: Text('خطایی رخ داد'),
          ),
        ),
      );

      expect(
        find.text('دریافت اطلاعات با مشکل مواجه شد.'),
        findsNothing,
      );
    });

    testWidgets('renders arbitrary action widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PErrorState(
            title: const Text('خطایی رخ داد'),
            action: ElevatedButton(
              onPressed: () {},
              child: const Text('تلاش مجدد'),
            ),
          ),
        ),
      );

      expect(find.text('تلاش مجدد'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('does not render action when omitted', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PErrorState(
            title: Text('خطایی رخ داد'),
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('supports custom padding', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PErrorState(
            title: Text('خطایی رخ داد'),
            padding: EdgeInsets.all(32),
          ),
        ),
      );

      final padding = tester.widget<Padding>(
        find.ancestor(
          of: find.text('خطایی رخ داد'),
          matching: find.byType(Padding),
        ),
      );

      expect(padding.padding, const EdgeInsets.all(32));
    });

    testWidgets('renders all optional content together', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PErrorState(
            icon: const Icon(Icons.error_outline),
            title: const Text('خطایی رخ داد'),
            description: const Text('عملیات با مشکل مواجه شد.'),
            action: TextButton(
              onPressed: () {},
              child: const Text('تلاش مجدد'),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.text('خطایی رخ داد'), findsOneWidget);
      expect(find.text('عملیات با مشکل مواجه شد.'), findsOneWidget);
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
          home: PErrorState(
            title: Text('خطایی در پردازش درخواست رخ داد'),
            description: Text(
              'در حال حاضر امکان دریافت اطلاعات وجود ندارد.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );

      expect(find.text('خطایی در پردازش درخواست رخ داد'), findsOneWidget);
      expect(
        find.text('در حال حاضر امکان دریافت اطلاعات وجود ندارد.'),
        findsOneWidget,
      );

      expect(tester.takeException(), isNull);
    });

    testWidgets('works with RTL directionality', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: PErrorState(
              title: Text('خطایی رخ داد'),
            ),
          ),
        ),
      );

      expect(find.text('خطایی رخ داد'), findsOneWidget);
    });
  });
}