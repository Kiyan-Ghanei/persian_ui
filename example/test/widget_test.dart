import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';

void main() {
  testWidgets('PersianUI showcase renders successfully', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PersianUIShowcaseApp());

    expect(find.text('PersianUI'), findsOneWidget);
    expect(find.text('انواع دکمه'), findsOneWidget);
    expect(find.text('دکمه اصلی'), findsOneWidget);
  });
}