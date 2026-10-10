import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  Widget buildTestApp({
    required SnackBar snackbar,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              },
              child: const Text('نمایش'),
            );
          },
        ),
      ),
    );
  }

  Future<void> showSnackbar(
    WidgetTester tester,
    PSnackbar snackbar,
  ) async {
    await tester.pumpWidget(
      buildTestApp(snackbar: snackbar),
    );

    await tester.tap(find.text('نمایش'));

    // اجازه می‌دهیم انیمیشن ورود Snackbar کامل شود.
    await tester.pumpAndSettle();
  }

  testWidgets(
    'PSnackbar uses info type by default',
    (WidgetTester tester) async {
      await showSnackbar(
        tester,
        PSnackbar(
          message: 'اطلاعات',
        ),
      );

      final SnackBar snackbar =
          tester.widget<SnackBar>(find.byType(SnackBar));

      expect(
        snackbar.backgroundColor,
        PColors.info,
      );

      expect(
        find.byIcon(Icons.info_outline),
        findsOneWidget,
      );

      expect(
        find.text('اطلاعات'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'PSnackbar uses success color for success type',
    (WidgetTester tester) async {
      await showSnackbar(
        tester,
        PSnackbar(
          message: 'موفق',
          type: PSnackbarType.success,
        ),
      );

      final SnackBar snackbar =
          tester.widget<SnackBar>(find.byType(SnackBar));

      expect(
        snackbar.backgroundColor,
        PColors.success,
      );

      expect(
        find.byIcon(Icons.check_circle_outline),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'PSnackbar uses warning color for warning type',
    (WidgetTester tester) async {
      await showSnackbar(
        tester,
        PSnackbar(
          message: 'هشدار',
          type: PSnackbarType.warning,
        ),
      );

      final SnackBar snackbar =
          tester.widget<SnackBar>(find.byType(SnackBar));

      expect(
        snackbar.backgroundColor,
        PColors.warning,
      );

      expect(
        find.byIcon(Icons.warning_amber_outlined),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'PSnackbar uses error color for error type',
    (WidgetTester tester) async {
      await showSnackbar(
        tester,
        PSnackbar(
          message: 'خطا',
          type: PSnackbarType.error,
        ),
      );

      final SnackBar snackbar =
          tester.widget<SnackBar>(find.byType(SnackBar));

      expect(
        snackbar.backgroundColor,
        PColors.error,
      );

      expect(
        find.byIcon(Icons.error_outline),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'PSnackbar shows action when actionLabel is provided',
    (WidgetTester tester) async {
      await showSnackbar(
        tester,
        PSnackbar(
          message: 'عملیات انجام شد',
          actionLabel: 'انجام',
        ),
      );

      expect(
        find.byType(SnackBarAction),
        findsOneWidget,
      );

      expect(
        find.text('انجام'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'PSnackbar does not show action when actionLabel is null',
    (WidgetTester tester) async {
      await showSnackbar(
        tester,
        PSnackbar(
          message: 'پیام',
        ),
      );

      expect(
        find.byType(SnackBarAction),
        findsNothing,
      );
    },
  );

  testWidgets(
    'PSnackbar calls onAction when action is pressed',
    (WidgetTester tester) async {
      bool actionPressed = false;

      await showSnackbar(
        tester,
        PSnackbar(
          message: 'عملیات انجام شد',
          actionLabel: 'انجام',
          onAction: () {
            actionPressed = true;
          },
        ),
      );

      final Finder actionFinder = find.byType(SnackBarAction);

      expect(
        actionFinder,
        findsOneWidget,
      );

      await tester.ensureVisible(actionFinder);
      await tester.tap(actionFinder);
      await tester.pump();

      expect(
        actionPressed,
        isTrue,
      );
    },
  );

  testWidgets(
    'PSnackbar uses custom duration',
    (WidgetTester tester) async {
      const Duration duration = Duration(seconds: 10);

      await showSnackbar(
        tester,
        PSnackbar(
          message: 'پیام',
          duration: duration,
        ),
      );

      final SnackBar snackbar =
          tester.widget<SnackBar>(find.byType(SnackBar));

      expect(
        snackbar.duration,
        duration,
      );
    },
  );

  testWidgets(
    'PSnackbar static show displays snackbar',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () {
                    PSnackbar.show(
                      context: context,
                      message: 'پیام استاتیک',
                      type: PSnackbarType.info,
                    );
                  },
                  child: const Text('نمایش'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('نمایش'));
      await tester.pumpAndSettle();

      expect(
        find.byType(SnackBar),
        findsOneWidget,
      );

      expect(
        find.text('پیام استاتیک'),
        findsOneWidget,
      );

      expect(
        find.byIcon(Icons.info_outline),
        findsOneWidget,
      );
    },
  );
}