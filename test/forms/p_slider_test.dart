import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PSlider', () {
    testWidgets('renders with default configuration', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PSlider(
              value: 0.5,
              onChanged: null,
            ),
          ),
        ),
      );

      expect(find.byType(PSlider), findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);

      final slider = tester.widget<Slider>(
        find.byType(Slider),
      );

      expect(slider.value, 0.5);
      expect(slider.min, 0.0);
      expect(slider.max, 1.0);
      expect(slider.divisions, isNull);
      expect(slider.label, isNull);
    });

    testWidgets('passes custom min and max', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PSlider(
              value: 50.0,
              min: 10.0,
              max: 100.0,
              onChanged: null,
            ),
          ),
        ),
      );

      final slider = tester.widget<Slider>(
        find.byType(Slider),
      );

      expect(slider.value, 50.0);
      expect(slider.min, 10.0);
      expect(slider.max, 100.0);
    });

    testWidgets('passes divisions', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PSlider(
              value: 0.5,
              divisions: 10,
              onChanged: null,
            ),
          ),
        ),
      );

      final slider = tester.widget<Slider>(
        find.byType(Slider),
      );

      expect(slider.divisions, 10);
    });

    testWidgets('passes label', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PSlider(
              value: 0.5,
              label: '50%',
              onChanged: null,
            ),
          ),
        ),
      );

      final slider = tester.widget<Slider>(
        find.byType(Slider),
      );

      expect(slider.label, '50%');
    });

    testWidgets('passes onChanged callback', (tester) async {
      double? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PSlider(
              value: 0.5,
              onChanged: (value) {
                changedValue = value;
              },
            ),
          ),
        ),
      );

      final slider = tester.widget<Slider>(
        find.byType(Slider),
      );

      expect(slider.onChanged, isNotNull);

      slider.onChanged!(0.8);

      expect(changedValue, 0.8);
    });

    testWidgets('is disabled when onChanged is null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PSlider(
              value: 0.5,
              onChanged: null,
            ),
          ),
        ),
      );

      final slider = tester.widget<Slider>(
        find.byType(Slider),
      );

      expect(slider.onChanged, isNull);
    });

    testWidgets('is disabled when enabled is false', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PSlider(
              value: 0.5,
              enabled: false,
              onChanged: _noop,
            ),
          ),
        ),
      );

      final slider = tester.widget<Slider>(
        find.byType(Slider),
      );

      expect(slider.onChanged, isNull);
    });

    testWidgets('remains enabled when enabled is true', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PSlider(
              value: 0.5,
              enabled: true,
              onChanged: _noop,
            ),
          ),
        ),
      );

      final slider = tester.widget<Slider>(
        find.byType(Slider),
      );

      expect(slider.onChanged, isNotNull);
    });

    testWidgets('supports padding', (tester) async {
      const padding = EdgeInsets.all(16);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PSlider(
              value: 0.5,
              onChanged: null,
              padding: padding,
            ),
          ),
        ),
      );

      final paddingWidget = tester.widget<Padding>(
        find.ancestor(
          of: find.byType(Slider),
          matching: find.byType(Padding),
        ),
      );

      expect(paddingWidget.padding, padding);
    });

    testWidgets('does not add padding when padding is null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PSlider(
              value: 0.5,
              onChanged: null,
            ),
          ),
        ),
      );

      expect(
        find.ancestor(
          of: find.byType(Slider),
          matching: find.byType(Padding),
        ),
        findsNothing,
      );
    });

    testWidgets('works in RTL directionality', (tester) async {
      final directionalityKey = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Directionality(
            key: directionalityKey,
            textDirection: TextDirection.rtl,
            child: const Scaffold(
              body: PSlider(
                value: 0.5,
                onChanged: null,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(PSlider), findsOneWidget);

      final directionality = tester.widget<Directionality>(
        find.byKey(directionalityKey),
      );

      expect(
        directionality.textDirection,
        TextDirection.rtl,
      );
    });

    testWidgets('works in LTR directionality', (tester) async {
      final directionalityKey = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Directionality(
            key: directionalityKey,
            textDirection: TextDirection.ltr,
            child: const Scaffold(
              body: PSlider(
                value: 0.5,
                onChanged: null,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(PSlider), findsOneWidget);

      final directionality = tester.widget<Directionality>(
        find.byKey(directionalityKey),
      );

      expect(
        directionality.textDirection,
        TextDirection.ltr,
      );
    });

    testWidgets('supports constrained layouts', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              child: PSlider(
                value: 0.5,
                onChanged: null,
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(find.byType(PSlider), findsOneWidget);
    });

    testWidgets('supports a very small width without throwing',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 50,
              child: PSlider(
                value: 0.5,
                onChanged: null,
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
    });

    testWidgets('supports a discrete slider with custom range',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PSlider(
              value: 5,
              min: 0,
              max: 10,
              divisions: 10,
              onChanged: null,
            ),
          ),
        ),
      );

      final slider = tester.widget<Slider>(
        find.byType(Slider),
      );

      expect(slider.value, 5);
      expect(slider.min, 0);
      expect(slider.max, 10);
      expect(slider.divisions, 10);
    });

    testWidgets('supports zero as value', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PSlider(
              value: 0,
              onChanged: null,
            ),
          ),
        ),
      );

      final slider = tester.widget<Slider>(
        find.byType(Slider),
      );

      expect(slider.value, 0);
    });

    testWidgets('supports maximum value', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PSlider(
              value: 1,
              onChanged: null,
            ),
          ),
        ),
      );

      final slider = tester.widget<Slider>(
        find.byType(Slider),
      );

      expect(slider.value, 1);
    });

    testWidgets('supports rebuild with a changed value', (tester) async {
      var value = 0.25;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Scaffold(
                body: Column(
                  children: [
                    PSlider(
                      value: value,
                      onChanged: (newValue) {
                        setState(() {
                          value = newValue;
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          value = 0.75;
                        });
                      },
                      child: const Text('Change value'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

      final initialSlider = tester.widget<Slider>(
        find.byType(Slider),
      );

      expect(initialSlider.value, 0.25);

      await tester.tap(find.text('Change value'));
      await tester.pump();

      final updatedSlider = tester.widget<Slider>(
        find.byType(Slider),
      );

      expect(updatedSlider.value, 0.75);
    });

    testWidgets('responds to slider interaction', (tester) async {
      double value = 0.5;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Scaffold(
                body: PSlider(
                  value: value,
                  onChanged: (newValue) {
                    setState(() {
                      value = newValue;
                    });
                  },
                ),
              ),
            );
          },
        ),
      );

      final sliderFinder = find.byType(Slider);

      await tester.drag(
        sliderFinder,
        const Offset(100, 0),
      );

      await tester.pump();

      expect(value, isNot(0.5));
    });

    testWidgets('can be constructed as const', (tester) async {
      const slider = PSlider(
        value: 0.5,
        onChanged: null,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: slider,
          ),
        ),
      );

      expect(find.byType(PSlider), findsOneWidget);
    });

    testWidgets('accepts null label', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PSlider(
              value: 0.5,
              label: null,
              onChanged: null,
            ),
          ),
        ),
      );

      final slider = tester.widget<Slider>(
        find.byType(Slider),
      );

      expect(slider.label, isNull);
    });

    testWidgets('accepts null divisions', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PSlider(
              value: 0.5,
              divisions: null,
              onChanged: null,
            ),
          ),
        ),
      );

      final slider = tester.widget<Slider>(
        find.byType(Slider),
      );

      expect(slider.divisions, isNull);
    });

    testWidgets('does not throw with zero padding', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PSlider(
              value: 0.5,
              onChanged: null,
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
    });
  });
}

void _noop(double value) {}