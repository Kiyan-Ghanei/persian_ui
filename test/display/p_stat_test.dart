import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PStat', () {
    testWidgets('displays value', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PStat(
              value: '125',
              label: 'کاربران',
            ),
          ),
        ),
      );

      expect(find.text('125'), findsOneWidget);
    });

    testWidgets('displays label', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PStat(
              value: '125',
              label: 'کاربران',
            ),
          ),
        ),
      );

      expect(find.text('کاربران'), findsOneWidget);
    });

    testWidgets('displays icon when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PStat(
              value: '125',
              label: 'کاربران',
              icon: Icon(Icons.people),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.people), findsOneWidget);
    });

    testWidgets('does not require an icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PStat(
              value: '125',
              label: 'کاربران',
            ),
          ),
        ),
      );

      expect(find.byType(Icon), findsNothing);
    });

    testWidgets('displays subtitle when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PStat(
              value: '125',
              label: 'کاربران',
              subtitle: Text('این ماه'),
            ),
          ),
        ),
      );

      expect(find.text('این ماه'), findsOneWidget);
    });

    testWidgets('does not require a subtitle', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PStat(
              value: '125',
              label: 'کاربران',
            ),
          ),
        ),
      );

      expect(find.text('این ماه'), findsNothing);
    });

    testWidgets('supports custom icon widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PStat(
              value: '125',
              label: 'کاربران',
              icon: SizedBox(
                key: ValueKey('custom-icon'),
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
      );

      expect(find.byKey(const ValueKey('custom-icon')), findsOneWidget);
    });

    testWidgets('supports custom subtitle widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PStat(
              value: '125',
              label: 'کاربران',
              subtitle: SizedBox(
                key: ValueKey('custom-subtitle'),
                height: 20,
              ),
            ),
          ),
        ),
      );

      expect(find.byKey(const ValueKey('custom-subtitle')), findsOneWidget);
    });

    testWidgets('supports custom accent color', (tester) async {
      const accentColor = Colors.red;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PStat(
              value: '125',
              label: 'کاربران',
              icon: Icon(Icons.people),
              color: accentColor,
            ),
          ),
        ),
      );

      final iconThemes = tester.widgetList<IconTheme>(
        find.descendant(
          of: find.byType(PStat),
          matching: find.byType(IconTheme),
        ),
      );

      expect(
        iconThemes.any(
          (theme) => theme.data.color == accentColor,
        ),
        isTrue,
      );
    });

    testWidgets('uses theme primary color for icon by default', (tester) async {
      const primaryColor = Colors.purple;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: primaryColor,
            ),
          ),
          home: const Scaffold(
            body: PStat(
              value: '125',
              label: 'کاربران',
              icon: Icon(Icons.people),
            ),
          ),
        ),
      );

      final pStatFinder = find.byType(PStat);

      final iconThemes = tester.widgetList<IconTheme>(
        find.descendant(
          of: pStatFinder,
          matching: find.byType(IconTheme),
        ),
      );

      expect(
        iconThemes.any(
          (theme) =>
              theme.data.color ==
              Theme.of(
                tester.element(pStatFinder),
              ).colorScheme.primary,
        ),
        isTrue,
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
            body: PStat(
              value:
                  '12345678901234567890123456789012345678901234567890',
              label:
                  'این یک عنوان بسیار طولانی برای آزمایش رفتار واکنش‌گرا است',
              subtitle: Text(
                'این متن نیز برای بررسی محتوای طولانی استفاده می‌شود.',
              ),
              icon: Icon(Icons.analytics),
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
              child: PStat(
                value: '85%',
                label: 'پیشرفت',
                icon: Icon(Icons.trending_up),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(PStat), findsOneWidget);
      expect(find.text('85%'), findsOneWidget);
      expect(find.text('پیشرفت'), findsOneWidget);
    });

    testWidgets('works inside Row', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                Expanded(
                  child: PStat(
                    value: '24',
                    label: 'سفارش‌ها',
                  ),
                ),
                Expanded(
                  child: PStat(
                    value: '4.8',
                    label: 'امتیاز',
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(PStat), findsNWidgets(2));
      expect(find.text('24'), findsOneWidget);
      expect(find.text('4.8'), findsOneWidget);
    });

    testWidgets('supports RTL layout', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: PStat(
                value: '125',
                label: 'کاربران',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(PStat), findsOneWidget);
      expect(find.text('125'), findsOneWidget);
      expect(find.text('کاربران'), findsOneWidget);
    });

    testWidgets('supports LTR layout', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              body: PStat(
                value: '125',
                label: 'Users',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(PStat), findsOneWidget);
      expect(find.text('125'), findsOneWidget);
      expect(find.text('Users'), findsOneWidget);
    });

    testWidgets('provides accessible semantics', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PStat(
              value: '125',
              label: 'کاربران',
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(
        find.byType(PStat),
      );

      expect(
        semantics.label,
        '125، کاربران',
      );
    });

    testWidgets('supports complete configuration', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PStat(
              value: '4.8',
              label: 'امتیاز',
              icon: Icon(Icons.star),
              color: Colors.amber,
              subtitle: Text('از ۵'),
            ),
          ),
        ),
      );

      expect(find.text('4.8'), findsOneWidget);
      expect(find.text('امتیاز'), findsOneWidget);
      expect(find.text('از ۵'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('works with a very narrow constraint', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 60,
              child: PStat(
                value: '85%',
                label: 'پیشرفت',
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
    });

    testWidgets('handles an empty subtitle widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PStat(
              value: '125',
              label: 'کاربران',
              subtitle: SizedBox.shrink(),
            ),
          ),
        ),
      );

      expect(find.byType(PStat), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}