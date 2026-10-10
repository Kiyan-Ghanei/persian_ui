import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PProgress', () {
    testWidgets('renders linear progress indicator', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PProgress(
            value: 0.5,
          ),
        ),
      );

      expect(find.byType(PProgress), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('uses default values', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PProgress(
            value: 0.5,
          ),
        ),
      );

      final progress = tester.widget<PProgress>(
        find.byType(PProgress),
      );

      expect(progress.value, 0.5);
      expect(progress.height, 6);
      expect(progress.color, isNull);
      expect(progress.backgroundColor, isNull);
      expect(progress.borderRadius, isNull);
    });

    testWidgets('supports zero progress', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PProgress(
            value: 0,
          ),
        ),
      );

      final progress = tester.widget<PProgress>(
        find.byType(PProgress),
      );

      expect(progress.value, 0);
    });

    testWidgets('supports complete progress', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PProgress(
            value: 1,
          ),
        ),
      );

      final progress = tester.widget<PProgress>(
        find.byType(PProgress),
      );

      expect(progress.value, 1);
    });

    testWidgets('supports custom height', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PProgress(
            value: 0.5,
            height: 12,
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(PProgress),
          matching: find.byType(SizedBox),
        ),
      );

      expect(sizedBox.height, 12);
    });

    testWidgets('supports custom color', (tester) async {
      const color = Colors.green;

      await tester.pumpWidget(
        const MaterialApp(
          home: PProgress(
            value: 0.5,
            color: color,
          ),
        ),
      );

      final progressIndicator =
          tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );

      expect(progressIndicator.color, color);
    });

    testWidgets('supports custom background color', (tester) async {
      const backgroundColor = Colors.grey;

      await tester.pumpWidget(
        const MaterialApp(
          home: PProgress(
            value: 0.5,
            backgroundColor: backgroundColor,
          ),
        ),
      );

      final progressIndicator =
          tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );

      expect(
        progressIndicator.backgroundColor,
        backgroundColor,
      );
    });

    testWidgets('supports custom border radius', (tester) async {
      final radius = BorderRadius.circular(12);

      await tester.pumpWidget(
        MaterialApp(
          home: PProgress(
            value: 0.5,
            borderRadius: radius,
          ),
        ),
      );

      final progress = tester.widget<PProgress>(
        find.byType(PProgress),
      );

      expect(progress.borderRadius, radius);

      final clip = tester.widget<ClipRRect>(
        find.descendant(
          of: find.byType(PProgress),
          matching: find.byType(ClipRRect),
        ),
      );

      expect(clip.borderRadius, radius);
    });

    testWidgets('supports RTL directionality', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: PProgress(
              value: 0.5,
            ),
          ),
        ),
      );

      expect(find.byType(PProgress), findsOneWidget);
      expect(
        find.byType(LinearProgressIndicator),
        findsOneWidget,
      );
    });

    testWidgets('supports LTR directionality', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: PProgress(
              value: 0.5,
            ),
          ),
        ),
      );

      expect(find.byType(PProgress), findsOneWidget);
      expect(
        find.byType(LinearProgressIndicator),
        findsOneWidget,
      );
    });
  });
}