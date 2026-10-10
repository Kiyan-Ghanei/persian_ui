
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PLoadingButton', () {
    testWidgets('should display text when not loading', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PLoadingButton(
              text: 'ذخیره',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('ذخیره'), findsOneWidget);
      expect(
        find.byType(CircularProgressIndicator),
        findsNothing,
      );
    });

    testWidgets('should display progress indicator when loading', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PLoadingButton(
              text: 'ذخیره',
              onPressed: () {},
              loading: true,
            ),
          ),
        ),
      );

      expect(
        find.byType(CircularProgressIndicator),
        findsOneWidget,
      );
    });

    testWidgets('should not call onPressed while loading', (
      WidgetTester tester,
    ) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PLoadingButton(
              text: 'ذخیره',
              onPressed: () {
                pressed = true;
              },
              loading: true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PLoadingButton));
      await tester.pump();

      expect(pressed, isFalse);
    });

    testWidgets(
      'should use the current theme colors',
      (WidgetTester tester) async {
        const Color customPrimary = Color(0xFF7B1FA2);
        const Color customOnPrimary = Color(0xFFFFFFFF);

        final ColorScheme colorScheme = ColorScheme.fromSeed(
          seedColor: customPrimary,
        ).copyWith(
          primary: customPrimary,
          onPrimary: customOnPrimary,
        );

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: colorScheme,
            ),
            home: Scaffold(
              body: PLoadingButton(
                text: 'ذخیره',
                onPressed: () {},
              ),
            ),
          ),
        );

        final ElevatedButton button = tester.widget<ElevatedButton>(
          find.byType(ElevatedButton),
        );

        expect(
          button.style?.backgroundColor?.resolve(<WidgetState>{}),
          customPrimary,
        );
        expect(
          button.style?.foregroundColor?.resolve(<WidgetState>{}),
          customOnPrimary,
        );
      },
    );

    testWidgets('small size should use compact padding', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PLoadingButton(
              text: 'ذخیره',
              onPressed: () {},
              size: PButtonSize.small,
            ),
          ),
        ),
      );

      final ElevatedButton button = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );

      expect(
        button.style?.padding?.resolve(<WidgetState>{}),
        const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
      );
    });

    testWidgets('medium size should preserve default padding', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PLoadingButton(
              text: 'ذخیره',
              onPressed: () {},
              size: PButtonSize.medium,
            ),
          ),
        ),
      );

      final ElevatedButton button = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );

      expect(
        button.style?.padding?.resolve(<WidgetState>{}),
        const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      );
    });

    testWidgets('large size should use spacious padding', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PLoadingButton(
              text: 'ذخیره',
              onPressed: () {},
              size: PButtonSize.large,
            ),
          ),
        ),
      );

      final ElevatedButton button = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );

      expect(
        button.style?.padding?.resolve(<WidgetState>{}),
        const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
      );
    });
  });
}
