import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/widgets/home_screen/settings/sign_out_confirmation_dialog.dart';
import 'package:flutter/material.dart' show Text;
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utils.dart';

void main() {
  group('$SignOutConfirmationDialog', () {
    var isPressed = false;

    final widget = wrapWithMaterialAppLocalizationDelegates(
      SignOutConfirmationDialog(
        onConfirm: () => isPressed = true,
      ),
    );

    testWidgets('Ensure content is correct', (tester) async {
      await tester.pumpWidget(widget);

      await tester.pumpAndSettle();

      expect(find.byType(Text), findsNWidgets(3));

      expect(
        find.text(AppLocalizations.current.signOutConfirmationDialogDescriptionText),
        findsOneWidget,
      );

      expect(
        find.text(AppLocalizations.current.generalCancel.toUpperCase()),
        findsOneWidget,
      );

      expect(
        find.text(AppLocalizations.current.signOutConfirmationDialogConfirmButtonText.toUpperCase()),
        findsOneWidget,
      );
    });

    testWidgets('Ensure callback can be invoked', (tester) async {
      await tester.pumpWidget(widget);

      await tester.pumpAndSettle();

      expect(isPressed, isFalse);

      await tester.tap(find.text(
        AppLocalizations.current.signOutConfirmationDialogConfirmButtonText.toUpperCase(),
      ));

      expect(isPressed, isTrue);
    });
  });
}
