
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PIconButton', () {
    testWidgets('should display icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PIconButton(
              icon: Icons.add,
              onPressed: () {},
              tooltip: 'افزودن',
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped', (
      WidgetTester tester,
    ) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PIconButton(
              icon: Icons.add,
              onPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('should expose tooltip', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PIconButton(
              icon: Icons.search,
              onPressed: () {},
              tooltip: 'جستجو',
            ),
          ),
        ),
      );

      expect(find.byTooltip('جستجو'), findsOneWidget);
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
              body: PIconButton(
                icon: Icons.add,
                onPressed: () {},
              ),
            ),
          ),
        );

        final IconButton button = tester.widget<IconButton>(
          find.byType(IconButton),
        );

        expect(
          button.style?.backgroundColor?.resolve(<WidgetState>{}),
          customPrimary,
        );
        expect(button.color, customOnPrimary);
      },
    );

    testWidgets('small size should use a smaller icon', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PIconButton(
              icon: Icons.add,
              onPressed: () {},
              size: PButtonSize.small,
            ),
          ),
        ),
      );

      final Icon icon = tester.widget<Icon>(find.byIcon(Icons.add));

      expect(icon.size, 18);
    });

    testWidgets('medium size should preserve the default icon size', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PIconButton(
              icon: Icons.add,
              onPressed: () {},
              size: PButtonSize.medium,
            ),
          ),
        ),
      );

      final Icon icon = tester.widget<Icon>(find.byIcon(Icons.add));

      expect(icon.size, 24);
    });

    testWidgets('large size should use a larger icon', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PIconButton(
              icon: Icons.add,
              onPressed: () {},
              size: PButtonSize.large,
            ),
          ),
        ),
      );

      final Icon icon = tester.widget<Icon>(find.byIcon(Icons.add));

      expect(icon.size, 30);
    });
  });
}
