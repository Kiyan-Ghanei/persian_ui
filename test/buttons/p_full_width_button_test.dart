
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PButton fullWidth', () {
    testWidgets('should preserve intrinsic width by default', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 320,
              child: const Align(
                alignment: Alignment.topLeft,
                child: PButton(
                  text: 'ثبت',
                  onPressed: null,
                ),
              ),
            ),
          ),
        ),
      );

      final Size buttonSize = tester.getSize(
        find.byType(ElevatedButton),
      );

      expect(buttonSize.width, lessThan(320));
    });

    testWidgets('should fill the available width when enabled', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 320,
              child: const Align(
                alignment: Alignment.topLeft,
                child: PButton(
                  text: 'ثبت',
                  onPressed: null,
                  fullWidth: true,
                ),
              ),
            ),
          ),
        ),
      );

      final Size buttonSize = tester.getSize(
        find.byType(ElevatedButton),
      );

      expect(buttonSize.width, 320);
    });
  });

  group('PLoadingButton fullWidth', () {
    testWidgets('should fill the available width when enabled', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 320,
              child: const Align(
                alignment: Alignment.topLeft,
                child: PLoadingButton(
                  text: 'ذخیره',
                  onPressed: null,
                  fullWidth: true,
                ),
              ),
            ),
          ),
        ),
      );

      final Size buttonSize = tester.getSize(
        find.byType(ElevatedButton),
      );

      expect(buttonSize.width, 320);
    });

    testWidgets('should remain full width while loading', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 320,
              child: const Align(
                alignment: Alignment.topLeft,
                child: PLoadingButton(
                  text: 'ذخیره',
                  onPressed: null,
                  loading: true,
                  fullWidth: true,
                ),
              ),
            ),
          ),
        ),
      );

      final Size buttonSize = tester.getSize(
        find.byType(ElevatedButton),
      );

      expect(buttonSize.width, 320);
      expect(
        find.byType(CircularProgressIndicator),
        findsOneWidget,
      );
    });
  });
}
