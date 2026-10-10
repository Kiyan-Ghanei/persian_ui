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
          body: Center(
            child: child,
          ),
        ),
      ),
    );
  }

  testWidgets('renders avatar with default size', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        child: const PAvatar(),
      ),
    );

    final container = tester.widget<Container>(
      find.descendant(
        of: find.byType(PAvatar),
        matching: find.byType(Container),
      ).first,
    );

    expect(container.constraints?.minWidth, 40);
    expect(container.constraints?.minHeight, 40);
  });

  testWidgets('renders custom size', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        child: const PAvatar(
          size: 64,
        ),
      ),
    );

    final container = tester.widget<Container>(
      find.descendant(
        of: find.byType(PAvatar),
        matching: find.byType(Container),
      ).first,
    );

    expect(container.constraints?.minWidth, 64);
    expect(container.constraints?.minHeight, 64);
  });

  testWidgets('renders fallback text', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        child: const PAvatar(
          fallbackText: 'ک',
        ),
      ),
    );

    expect(find.text('ک'), findsOneWidget);
  });

  testWidgets('renders fallback icon when text is unavailable', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        child: const PAvatar(
          fallbackIcon: Icon(Icons.person),
        ),
      ),
    );

    expect(find.byIcon(Icons.person), findsOneWidget);
  });

  testWidgets('fallback text has priority over fallback icon', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        child: const PAvatar(
          fallbackText: 'ک',
          fallbackIcon: Icon(Icons.person),
        ),
      ),
    );

    expect(find.text('ک'), findsOneWidget);
    expect(find.byIcon(Icons.person), findsNothing);
  });

  testWidgets('uses asset image provider', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        child: const PAvatar(
          imageProvider: AssetImage('assets/avatar.png'),
          fallbackText: 'ک',
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('shows fallback when image fails', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        child: const PAvatar(
          imageProvider: NetworkImage(
            'https://invalid.example/avatar.png',
          ),
          fallbackText: 'ک',
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('ک'), findsOneWidget);
  });

  testWidgets('applies custom background color', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        child: const PAvatar(
          backgroundColor: Colors.red,
        ),
      ),
    );

    final container = tester.widget<Container>(
      find.descendant(
        of: find.byType(PAvatar),
        matching: find.byType(Container),
      ).first,
    );

    final decoration = container.decoration! as BoxDecoration;

    expect(decoration.color, Colors.red);
    expect(decoration.shape, BoxShape.circle);
  });

  testWidgets('adds semantic label to avatar', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        child: const PAvatar(
          fallbackText: 'ک',
          semanticLabel: 'تصویر پروفایل کاربر',
        ),
      ),
    );

    final semantics = tester.widget<Semantics>(
      find.descendant(
        of: find.byType(PAvatar),
        matching: find.byType(Semantics),
      ),
    );

    expect(
      semantics.properties.label,
      'تصویر پروفایل کاربر',
    );

    expect(
      semantics.properties.image,
      false,
    );
  });

  testWidgets('does not add custom semantics without label', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        child: const PAvatar(
          fallbackText: 'ک',
        ),
      ),
    );

    expect(
      find.descendant(
        of: find.byType(PAvatar),
        matching: find.byType(Semantics),
      ),
      findsNothing,
    );
  });

  testWidgets('works correctly in RTL', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        textDirection: TextDirection.rtl,
        child: const PAvatar(
          fallbackText: 'ک',
        ),
      ),
    );

    expect(find.text('ک'), findsOneWidget);

    final directionality = tester.widget<Directionality>(
      find.ancestor(
        of: find.byType(PAvatar),
        matching: find.byType(Directionality),
      ).first,
    );

    expect(
      directionality.textDirection,
      TextDirection.rtl,
    );
  });

  testWidgets('works correctly in LTR', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        textDirection: TextDirection.ltr,
        child: const PAvatar(
          fallbackText: 'K',
        ),
      ),
    );

    expect(find.text('K'), findsOneWidget);

    final directionality = tester.widget<Directionality>(
      find.ancestor(
        of: find.byType(PAvatar),
        matching: find.byType(Directionality),
      ).first,
    );

    expect(
      find.text('K'),
      findsOneWidget,
    );

    expect(
      directionality.textDirection,
      TextDirection.ltr,
    );
  });
}