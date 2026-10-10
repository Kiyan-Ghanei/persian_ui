import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PLinearProgress', () {
    testWidgets('renders linear progress indicator', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PLinearProgress(
            value: 0.5,
          ),
        ),
      );

      expect(find.byType(PLinearProgress), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('uses default values', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PLinearProgress(
            value: 0.5,
          ),
        ),
      );

      final progress = tester.widget<PLinearProgress>(
        find.byType(PLinearProgress),
      );

      expect(progress.value, 0.5);
      expect(progress.height, 8);
      expect(progress.color, isNull);
      expect(progress.backgroundColor, isNull);
      expect(progress.borderRadius, isNull);
      expect(progress.showPercentage, isFalse);
    });

    testWidgets('supports zero progress', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PLinearProgress(
            value: 0,
          ),
        ),
      );

      final progress = tester.widget<PLinearProgress>(
        find.byType(PLinearProgress),
      );

      expect(progress.value, 0);
    });

    testWidgets('supports complete progress', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PLinearProgress(
            value: 1,
          ),
        ),
      );

      final progress = tester.widget<PLinearProgress>(
        find.byType(PLinearProgress),
      );

      expect(progress.value, 1);
    });

    testWidgets('supports custom height', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PLinearProgress(
            value: 0.5,
            height: 12,
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(PLinearProgress),
          matching: find.byType(SizedBox),
        ),
      );

      expect(sizedBox.height, 12);
    });

    testWidgets('supports custom color', (tester) async {
      const color = Colors.green;

      await tester.pumpWidget(
        const MaterialApp(
          home: PLinearProgress(
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
          home: PLinearProgress(
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
          home: PLinearProgress(
            value: 0.5,
            borderRadius: radius,
          ),
        ),
      );

      final progress = tester.widget<PLinearProgress>(
        find.byType(PLinearProgress),
      );

      expect(progress.borderRadius, radius);

      final clip = tester.widget<ClipRRect>(
        find.descendant(
          of: find.byType(PLinearProgress),
          matching: find.byType(ClipRRect),
        ),
      );

      expect(clip.borderRadius, radius);
    });

    testWidgets('does not show percentage by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PLinearProgress(
            value: 0.75,
          ),
        ),
      );

      expect(find.text('75%'), findsNothing);
    });

    testWidgets('shows percentage when enabled', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PLinearProgress(
            value: 0.75,
            showPercentage: true,
          ),
        ),
      );

      expect(find.text('75%'), findsOneWidget);
    });

    testWidgets('rounds displayed percentage', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PLinearProgress(
            value: 0.756,
            showPercentage: true,
          ),
        ),
      );

      expect(find.text('76%'), findsOneWidget);
    });

    testWidgets('supports RTL directionality', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: PLinearProgress(
              value: 0.5,
              showPercentage: true,
            ),
          ),
        ),
      );

      expect(find.byType(PLinearProgress), findsOneWidget);
      expect(find.text('50%'), findsOneWidget);
    });

    testWidgets('supports LTR directionality', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: PLinearProgress(
              value: 0.5,
              showPercentage: true,
            ),
          ),
        ),
      );

      expect(find.byType(PLinearProgress), findsOneWidget);
      expect(find.text('50%'), findsOneWidget);
    });
  });
}