
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  group('PersianUI public API', () {
    test('exports core layout components', () {
      expect(PContainer.new, isA<Function>());
      expect(PSection.new, isA<Function>());
      expect(PRow.new, isA<Function>());
      expect(PColumn.new, isA<Function>());
      expect(PSpacer.new, isA<Function>());
      expect(PGrid.new, isA<Function>());
      expect(PWrap.new, isA<Function>());
    });

    test('exports core button components', () {
      expect(PButton.new, isA<Function>());
      expect(PIconButton.new, isA<Function>());
      expect(PLoadingButton.new, isA<Function>());
    });

    test('exports core card components', () {
      expect(PCard.new, isA<Function>());
      expect(PInfoCard.new, isA<Function>());
      expect(PActionCard.new, isA<Function>());
      expect(PStatusCard.new, isA<Function>());
    });

    test('exports core input components', () {
      expect(PTextField.new, isA<Function>());
      expect(PPasswordField.new, isA<Function>());
      expect(PNumberField.new, isA<Function>());
      expect(PSearchField.new, isA<Function>());
    });
  });
}
