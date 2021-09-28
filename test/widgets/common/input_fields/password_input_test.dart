import 'package:film_freund/widgets/common/input_fields/password_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utils.dart';

void main() {
  group('$PasswordInput', () {
    testWidgets('Ensure password can be obscured', (tester) async {
      final key = UniqueKey();
      final widget = wrapWithMaterialAppLocalizationDelegates(
        Scaffold(
          body: PasswordInput(
            controller: TextEditingController(),
            hintText: 'hintText',
            key: key,
          ),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      var textField = tester.widget<TextField>(find.descendant(
        of: find.byKey(key),
        matching: find.byType(TextField),
      ));

      expect(textField.obscureText, isTrue);

      final obscureTextButton = find.descendant(
        of: find.byKey(key),
        matching: find.byType(IconButton),
      );

      await tester.tap(obscureTextButton);
      await tester.pumpAndSettle();

      textField = tester.widget<TextField>(find.descendant(
        of: find.byKey(key),
        matching: find.byType(TextField),
      ));

      expect(textField.obscureText, isFalse);
    });
  });
}
