import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  Widget buildTestWidget({
    required Widget child,
    TextDirection textDirection = TextDirection.rtl,
  }) {
    return MaterialApp(
      home: Directionality(
        textDirection: textDirection,
        child: Scaffold(
          body: child,
        ),
      ),
    );
  }

  group('PBreadcrumb', () {
    testWidgets('renders all breadcrumb labels', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: const PBreadcrumb(
            items: [
              PBreadcrumbItem(label: 'خانه'),
              PBreadcrumbItem(label: 'محصولات'),
              PBreadcrumbItem(label: 'جزئیات'),
            ],
          ),
        ),
      );

      expect(find.text('خانه'), findsOneWidget);
      expect(find.text('محصولات'), findsOneWidget);
      expect(find.text('جزئیات'), findsOneWidget);
    });

    testWidgets('renders PBreadcrumb widget', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: const PBreadcrumb(
            items: [
              PBreadcrumbItem(label: 'خانه'),
              PBreadcrumbItem(label: 'جزئیات'),
            ],
          ),
        ),
      );

      expect(find.byType(PBreadcrumb), findsOneWidget);
    });

    testWidgets('renders the expected number of separators', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: const PBreadcrumb(
            items: [
              PBreadcrumbItem(label: 'خانه'),
              PBreadcrumbItem(label: 'محصولات'),
              PBreadcrumbItem(label: 'جزئیات'),
            ],
          ),
        ),
      );

      expect(find.byIcon(Icons.chevron_left), findsNWidgets(2));
    });

    testWidgets('does not render separator after the last item', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: const PBreadcrumb(
            items: [
              PBreadcrumbItem(label: 'خانه'),
              PBreadcrumbItem(label: 'جزئیات'),
            ],
          ),
        ),
      );

      expect(find.byIcon(Icons.chevron_left), findsOneWidget);
    });

    testWidgets('calls onTap for interactive breadcrumb item', (
      tester,
    ) async {
      var tapped = false;

      await tester.pumpWidget(
        buildTestWidget(
          child: PBreadcrumb(
            items: [
              PBreadcrumbItem(
                label: 'خانه',
                onTap: () => tapped = true,
              ),
              const PBreadcrumbItem(label: 'جزئیات'),
            ],
          ),
        ),
      );

      await tester.tap(find.text('خانه'));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('last item is not interactive by default', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        buildTestWidget(
          child: PBreadcrumb(
            items: [
              const PBreadcrumbItem(label: 'خانه'),
              PBreadcrumbItem(
                label: 'جزئیات',
                onTap: () => tapped = true,
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('جزئیات'));
      await tester.pump();

      expect(tapped, isFalse);
    });

    testWidgets('supports custom separator', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: const PBreadcrumb(
            separator: Text('/'),
            items: [
              PBreadcrumbItem(label: 'خانه'),
              PBreadcrumbItem(label: 'محصولات'),
              PBreadcrumbItem(label: 'جزئیات'),
            ],
          ),
        ),
      );

      expect(find.text('/'), findsNWidgets(2));
      expect(find.byIcon(Icons.chevron_left), findsNothing);
    });

    testWidgets('supports custom text styles', (tester) async {
      const regularStyle = TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );

      const currentStyle = TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );

      await tester.pumpWidget(
        buildTestWidget(
          child: const PBreadcrumb(
            textStyle: regularStyle,
            currentTextStyle: currentStyle,
            items: [
              PBreadcrumbItem(label: 'خانه'),
              PBreadcrumbItem(label: 'جزئیات'),
            ],
          ),
        ),
      );

      final homeText = tester.widget<Text>(find.text('خانه'));
      final currentText = tester.widget<Text>(find.text('جزئیات'));

      expect(homeText.style, regularStyle);
      expect(currentText.style, currentStyle);
    });

    testWidgets('supports custom padding', (tester) async {
      const padding = EdgeInsets.all(24);

      await tester.pumpWidget(
        buildTestWidget(
          child: const PBreadcrumb(
            padding: padding,
            items: [
              PBreadcrumbItem(label: 'خانه'),
              PBreadcrumbItem(label: 'جزئیات'),
            ],
          ),
        ),
      );

      final breadcrumb = tester.widget<PBreadcrumb>(
        find.byType(PBreadcrumb),
      );

      expect(breadcrumb.padding, padding);
    });

    testWidgets('supports LTR direction', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          textDirection: TextDirection.ltr,
          child: const PBreadcrumb(
            items: [
              PBreadcrumbItem(label: 'Home'),
              PBreadcrumbItem(label: 'Products'),
              PBreadcrumbItem(label: 'Details'),
            ],
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Products'), findsOneWidget);
      expect(find.text('Details'), findsOneWidget);
    });
  });
}