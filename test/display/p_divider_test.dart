import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PDivider', () {
    testWidgets('uses horizontal orientation by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PDivider(),
          ),
        ),
      );

      expect(find.byType(Divider), findsOneWidget);
      expect(find.byType(VerticalDivider), findsNothing);
    });

    testWidgets('uses vertical orientation when requested', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PDivider(
              orientation: Axis.vertical,
            ),
          ),
        ),
      );

      expect(find.byType(VerticalDivider), findsOneWidget);
      expect(find.byType(Divider), findsNothing);
    });

    testWidgets('applies thickness', (tester) async {
      const thickness = 3.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PDivider(
              thickness: thickness,
            ),
          ),
        ),
      );

      final divider = tester.widget<Divider>(
        find.byType(Divider),
      );

      expect(divider.thickness, thickness);
    });

    testWidgets('applies color', (tester) async {
      const color = Colors.red;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PDivider(
              color: color,
            ),
          ),
        ),
      );

      final divider = tester.widget<Divider>(
        find.byType(Divider),
      );

      expect(divider.color, color);
    });

    testWidgets('applies indent', (tester) async {
      const indent = 16.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PDivider(
              indent: indent,
            ),
          ),
        ),
      );

      final divider = tester.widget<Divider>(
        find.byType(Divider),
      );

      expect(divider.indent, indent);
    });

    testWidgets('applies endIndent', (tester) async {
      const endIndent = 24.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PDivider(
              endIndent: endIndent,
            ),
          ),
        ),
      );

      final divider = tester.widget<Divider>(
        find.byType(Divider),
      );

      expect(divider.endIndent, endIndent);
    });

    testWidgets('applies indent and endIndent together', (tester) async {
      const indent = 12.0;
      const endIndent = 20.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PDivider(
              indent: indent,
              endIndent: endIndent,
            ),
          ),
        ),
      );

      final divider = tester.widget<Divider>(
        find.byType(Divider),
      );

      expect(divider.indent, indent);
      expect(divider.endIndent, endIndent);
    });

    testWidgets('applies properties to vertical divider', (tester) async {
      const thickness = 2.0;
      const color = Colors.blue;
      const indent = 8.0;
      const endIndent = 16.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PDivider(
              orientation: Axis.vertical,
              thickness: thickness,
              color: color,
              indent: indent,
              endIndent: endIndent,
            ),
          ),
        ),
      );

      final divider = tester.widget<VerticalDivider>(
        find.byType(VerticalDivider),
      );

      expect(divider.thickness, thickness);
      expect(divider.color, color);
      expect(divider.indent, indent);
      expect(divider.endIndent, endIndent);
    });

    testWidgets('works in RTL direction', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: PDivider(
                indent: 10,
                endIndent: 20,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Divider), findsOneWidget);
    });

    testWidgets('works in LTR direction', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              body: PDivider(
                indent: 10,
                endIndent: 20,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Divider), findsOneWidget);
    });

    testWidgets('works inside a horizontal layout', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                Expanded(
                  child: PDivider(
                    orientation: Axis.vertical,
                  ),
                ),
                Expanded(
                  child: Text('Content'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VerticalDivider), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('does not add artificial semantics', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PDivider(),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(Divider));

      expect(semantics.label, isEmpty);
    });
  });
}