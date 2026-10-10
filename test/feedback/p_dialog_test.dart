import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PDialog', () {
    testWidgets('displays title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PDialog(
              title: 'عنوان تست',
              confirmLabel: 'تأیید',
            ),
          ),
        ),
      );

      expect(find.text('عنوان تست'), findsOneWidget);
    });

    testWidgets('displays content', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PDialog(
              title: 'عنوان',
              confirmLabel: 'تأیید',
              content: const Text('محتوای تست'),
            ),
          ),
        ),
      );

      expect(find.text('محتوای تست'), findsOneWidget);
    });

    testWidgets('displays confirm button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PDialog(
              title: 'عنوان',
              confirmLabel: 'تأیید',
            ),
          ),
        ),
      );

      expect(find.text('تأیید'), findsOneWidget);
    });

    testWidgets('displays cancel button when cancelLabel is provided', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PDialog(
              title: 'عنوان',
              confirmLabel: 'تأیید',
              cancelLabel: 'لغو',
            ),
          ),
        ),
      );

      expect(find.text('لغو'), findsOneWidget);
    });

    testWidgets('does not display cancel button when cancelLabel is null', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PDialog(
              title: 'عنوان',
              confirmLabel: 'تأیید',
            ),
          ),
        ),
      );

      expect(find.text('لغو'), findsNothing);
    });

    testWidgets('calls onConfirm when confirm button is pressed', (
      tester,
    ) async {
      var confirmed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PDialog(
              title: 'عنوان',
              confirmLabel: 'تأیید',
              onConfirm: () {
                confirmed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('تأیید'));
      await tester.pump();

      expect(confirmed, isTrue);
    });

    testWidgets('calls onCancel when cancel button is pressed', (
      tester,
    ) async {
      var cancelled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PDialog(
              title: 'عنوان',
              confirmLabel: 'تأیید',
              cancelLabel: 'لغو',
              onCancel: () {
                cancelled = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('لغو'));
      await tester.pump();

      expect(cancelled, isTrue);
    });

    testWidgets('closes dialog after confirm', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: ElevatedButton(
                  onPressed: () {
                    PDialog.show(
                      context: context,
                      title: 'عنوان',
                      confirmLabel: 'تأیید',
                    );
                  },
                  child: const Text('باز کردن'),
                ),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('باز کردن'));
      await tester.pumpAndSettle();

      expect(find.text('عنوان'), findsOneWidget);

      await tester.tap(find.text('تأیید'));
      await tester.pumpAndSettle();

      expect(find.text('عنوان'), findsNothing);
    });

    testWidgets(
      'does not call onConfirm when confirmEnabled is false',
      (tester) async {
        var confirmed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PDialog(
                title: 'عنوان',
                confirmLabel: 'تأیید',
                confirmEnabled: false,
                onConfirm: () {
                  confirmed = true;
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('تأیید'));
        await tester.pump();

        expect(confirmed, isFalse);
      },
    );

    testWidgets('static show displays PDialog', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: ElevatedButton(
                  onPressed: () {
                    PDialog.show(
                      context: context,
                      title: 'دیالوگ تست',
                      confirmLabel: 'باشه',
                    );
                  },
                  child: const Text('نمایش'),
                ),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('نمایش'));
      await tester.pumpAndSettle();

      expect(find.text('دیالوگ تست'), findsOneWidget);
      expect(find.text('باشه'), findsOneWidget);
    });
  });
}