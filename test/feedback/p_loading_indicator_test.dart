import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PLoadingIndicator', () {
    testWidgets('renders circular progress indicator', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PLoadingIndicator(),
        ),
      );

      expect(find.byType(PLoadingIndicator), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('uses default values', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PLoadingIndicator(),
        ),
      );

      final loadingIndicator = tester.widget<PLoadingIndicator>(
        find.byType(PLoadingIndicator),
      );

      expect(loadingIndicator.size, 24);
      expect(loadingIndicator.strokeWidth, 2);
      expect(loadingIndicator.color, isNull);
      expect(loadingIndicator.semanticsLabel, isNull);
    });

    testWidgets('supports custom size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PLoadingIndicator(
            size: 40,
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(PLoadingIndicator),
          matching: find.byType(SizedBox),
        ),
      );

      expect(sizedBox.width, 40);
      expect(sizedBox.height, 40);
    });

    testWidgets('supports custom stroke width', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PLoadingIndicator(
            strokeWidth: 4,
          ),
        ),
      );

      final progressIndicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );

      expect(progressIndicator.strokeWidth, 4);
    });

    testWidgets('supports custom color', (tester) async {
      const color = Colors.red;

      await tester.pumpWidget(
        const MaterialApp(
          home: PLoadingIndicator(
            color: color,
          ),
        ),
      );

      final progressIndicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );

      expect(progressIndicator.color, color);
    });

    testWidgets('passes semantic label to accessibility tree',
        (tester) async {
      const label = 'در حال بارگذاری';

      await tester.pumpWidget(
        const MaterialApp(
          home: PLoadingIndicator(
            semanticsLabel: label,
          ),
        ),
      );

      final loadingIndicator = tester.widget<PLoadingIndicator>(
        find.byType(PLoadingIndicator),
      );

      expect(loadingIndicator.semanticsLabel, label);

      expect(
        find.bySemanticsLabel(label),
        findsOneWidget,
      );
    });

    testWidgets('keeps semantic label null when not provided',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PLoadingIndicator(),
        ),
      );

      final loadingIndicator = tester.widget<PLoadingIndicator>(
        find.byType(PLoadingIndicator),
      );

      expect(loadingIndicator.semanticsLabel, isNull);
    });

    testWidgets('supports zero size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PLoadingIndicator(
            size: 0,
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(PLoadingIndicator),
          matching: find.byType(SizedBox),
        ),
      );

      expect(sizedBox.width, 0);
      expect(sizedBox.height, 0);
    });

    testWidgets('supports RTL directionality', (tester) async {
      const label = 'در حال بارگذاری';

      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: PLoadingIndicator(
              semanticsLabel: label,
            ),
          ),
        ),
      );

      final loadingIndicator = tester.widget<PLoadingIndicator>(
        find.byType(PLoadingIndicator),
      );

      expect(loadingIndicator.semanticsLabel, label);

      expect(
        find.bySemanticsLabel(label),
        findsOneWidget,
      );
    });

    testWidgets('supports LTR directionality', (tester) async {
      const label = 'Loading';

      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: PLoadingIndicator(
              semanticsLabel: label,
            ),
          ),
        ),
      );

      final loadingIndicator = tester.widget<PLoadingIndicator>(
        find.byType(PLoadingIndicator),
      );

      expect(loadingIndicator.semanticsLabel, label);

      expect(
        find.bySemanticsLabel(label),
        findsOneWidget,
      );
    });
  });
}