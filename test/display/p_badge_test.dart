import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: child,
        ),
      ),
    );
  }

  group('PBadge', () {
    testWidgets(
      'renders label',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            const PBadge(label: '3'),
          ),
        );

        expect(find.text('3'), findsOneWidget);
      },
    );

    testWidgets(
      'renders text badge',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            const PBadge(label: 'NEW'),
          ),
        );

        expect(find.text('NEW'), findsOneWidget);
      },
    );

    testWidgets(
      'uses pill shape by default',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            const PBadge(label: 'NEW'),
          ),
        );

        final container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(PBadge),
                matching: find.byType(Container),
              )
              .first,
        );

        final decoration = container.decoration! as BoxDecoration;

        expect(decoration.borderRadius, isA<BorderRadius>());
      },
    );

    testWidgets(
      'supports circle shape',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            const PBadge(
              label: '3',
              shape: PBadgeShape.circle,
            ),
          ),
        );

        expect(find.text('3'), findsOneWidget);
      },
    );

    testWidgets(
      'applies custom background color',
      (tester) async {
        const backgroundColor = Colors.blue;

        await tester.pumpWidget(
          buildTestWidget(
            const PBadge(
              label: '3',
              backgroundColor: backgroundColor,
            ),
          ),
        );

        final container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(PBadge),
                matching: find.byType(Container),
              )
              .first,
        );

        final decoration = container.decoration! as BoxDecoration;

        expect(decoration.color, backgroundColor);
      },
    );

    testWidgets(
      'applies custom foreground color',
      (tester) async {
        const foregroundColor = Colors.white;

        await tester.pumpWidget(
          buildTestWidget(
            const PBadge(
              label: '3',
              foregroundColor: foregroundColor,
            ),
          ),
        );

        final text = tester.widget<Text>(
          find.text('3'),
        );

        expect(text.style?.color, foregroundColor);
      },
    );

    testWidgets(
      'applies custom padding',
      (tester) async {
        const customPadding = EdgeInsets.all(16);

        await tester.pumpWidget(
          buildTestWidget(
            const PBadge(
              label: '3',
              padding: customPadding,
            ),
          ),
        );

        final container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(PBadge),
                matching: find.byType(Container),
              )
              .first,
        );

        expect(container.padding, customPadding);
      },
    );

    testWidgets(
      'applies minimum size',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            const PBadge(
              label: '3',
              minSize: 32,
            ),
          ),
        );

        final container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(PBadge),
                matching: find.byType(Container),
              )
              .first,
        );

        final constraints = container.constraints!;

        expect(constraints.minWidth, 32);
        expect(constraints.minHeight, 32);
      },
    );

    testWidgets(
      'applies custom text style',
      (tester) async {
        const textStyle = TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        );

        await tester.pumpWidget(
          buildTestWidget(
            const PBadge(
              label: '3',
              textStyle: textStyle,
            ),
          ),
        );

        final text = tester.widget<Text>(
          find.text('3'),
        );

        expect(text.style, textStyle);
      },
    );

    testWidgets(
      'adds semantic label',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            const PBadge(
              label: '3',
              semanticLabel: 'سه اعلان جدید',
            ),
          ),
        );

        final badgeFinder = find.byType(PBadge);
        final semanticsFinder = find.descendant(
          of: badgeFinder,
          matching: find.byType(Semantics),
        );

        expect(semanticsFinder, findsOneWidget);

        final semantics = tester.widget<Semantics>(
          semanticsFinder,
        );

        expect(
          semantics.properties.label,
          'سه اعلان جدید',
        );
      },
    );

    testWidgets(
      'does not add semantic wrapper without semantic label',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            const PBadge(label: '3'),
          ),
        );

        final badgeFinder = find.byType(PBadge);
        final semanticsFinder = find.descendant(
          of: badgeFinder,
          matching: find.byType(Semantics),
        );

        expect(semanticsFinder, findsNothing);
      },
    );

    testWidgets(
      'works correctly in RTL',
      (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.rtl,
            child: const PBadge(
              label: 'جدید',
            ),
          ),
        );

        expect(find.text('جدید'), findsOneWidget);
      },
    );

    testWidgets(
      'works correctly in LTR',
      (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: const PBadge(
              label: 'NEW',
            ),
          ),
        );

        expect(find.text('NEW'), findsOneWidget);
      },
    );
  });
}