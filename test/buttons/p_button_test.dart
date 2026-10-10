
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PButton', () {
    testWidgets('should display text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PButton(
              text: 'ثبت',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('ثبت'), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped', (
      WidgetTester tester,
    ) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PButton(
              text: 'ثبت',
              onPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('ثبت'));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('should support primary variant', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PButton(
              text: 'اصلی',
              onPressed: () {},
              variant: PButtonVariant.primary,
            ),
          ),
        ),
      );

      expect(find.text('اصلی'), findsOneWidget);
    });

    testWidgets('should support secondary variant', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PButton(
              text: 'ثانویه',
              onPressed: () {},
              variant: PButtonVariant.secondary,
            ),
          ),
        ),
      );

      expect(find.text('ثانویه'), findsOneWidget);
    });

    testWidgets('should support danger variant', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PButton(
              text: 'حذف',
              onPressed: () {},
              variant: PButtonVariant.danger,
            ),
          ),
        ),
      );

      expect(find.text('حذف'), findsOneWidget);
    });

    testWidgets('should be disabled when onPressed is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PButton(
              text: 'غیرفعال',
              onPressed: null,
            ),
          ),
        ),
      );

      expect(find.text('غیرفعال'), findsOneWidget);
    });

    testWidgets(
      'primary variant should use the current theme primary color',
      (WidgetTester tester) async {
        const Color customPrimary = Color(0xFF7B1FA2);

        final ThemeData customTheme = ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: customPrimary,
            primary: customPrimary,
          ),
        );

        await tester.pumpWidget(
          MaterialApp(
            theme: customTheme,
            home: Scaffold(
              body: PButton(
                text: 'سفارشی',
                onPressed: () {},
                variant: PButtonVariant.primary,
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
      },
    );

    testWidgets(
      'secondary variant should use theme surface and text colors',
      (WidgetTester tester) async {
        const Color customBackground = Color(0xFFE0F2F1);
        const Color customForeground = Color(0xFF004D40);

        final ColorScheme colorScheme = ColorScheme.fromSeed(
          seedColor: const Color(0xFF008577),
        ).copyWith(
          surfaceContainerHighest: customBackground,
          onSurface: customForeground,
        );

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: colorScheme,
            ),
            home: Scaffold(
              body: PButton(
                text: 'ثانویه',
                onPressed: () {},
                variant: PButtonVariant.secondary,
              ),
            ),
          ),
        );

        final ElevatedButton button = tester.widget<ElevatedButton>(
          find.byType(ElevatedButton),
        );

        expect(
          button.style?.backgroundColor?.resolve(<WidgetState>{}),
          customBackground,
        );
        expect(
          button.style?.foregroundColor?.resolve(<WidgetState>{}),
          customForeground,
        );
      },
    );

    testWidgets(
      'danger variant should use theme error colors',
      (WidgetTester tester) async {
        const Color customError = Color(0xFFAD1457);
        const Color customOnError = Color(0xFFFFFFFF);

        final ColorScheme colorScheme = ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
        ).copyWith(
          error: customError,
          onError: customOnError,
        );

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: colorScheme,
            ),
            home: Scaffold(
              body: PButton(
                text: 'حذف',
                onPressed: () {},
                variant: PButtonVariant.danger,
              ),
            ),
          ),
        );

        final ElevatedButton button = tester.widget<ElevatedButton>(
          find.byType(ElevatedButton),
        );

        expect(
          button.style?.backgroundColor?.resolve(<WidgetState>{}),
          customError,
        );
        expect(
          button.style?.foregroundColor?.resolve(<WidgetState>{}),
          customOnError,
        );
      },
    );

    testWidgets(
      'primary variant should use the dark theme primary color',
      (WidgetTester tester) async {
        const Color darkPrimary = Color(0xFFCE93D8);

        final ThemeData darkTheme = ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: darkPrimary,
            primary: darkPrimary,
            brightness: Brightness.dark,
          ),
        );

        await tester.pumpWidget(
          MaterialApp(
            theme: darkTheme,
            home: Scaffold(
              body: PButton(
                text: 'اصلی',
                onPressed: () {},
                variant: PButtonVariant.primary,
              ),
            ),
          ),
        );

        final ElevatedButton button = tester.widget<ElevatedButton>(
          find.byType(ElevatedButton),
        );

        expect(
          button.style?.backgroundColor?.resolve(<WidgetState>{}),
          darkPrimary,
        );
      },
    );

    testWidgets('small size should use compact padding', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PButton(
              text: 'کوچک',
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
            body: PButton(
              text: 'متوسط',
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
            body: PButton(
              text: 'بزرگ',
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
