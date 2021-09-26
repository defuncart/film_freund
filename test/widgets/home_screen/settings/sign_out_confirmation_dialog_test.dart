import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/widgets/home_screen/settings/sign_out_confirmation_dialog.dart';
import 'package:flutter/material.dart' show Text;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mocks.dart';
import '../../../test_utils.dart';

void main() {
  group('$SignOutConfirmationDialog', () {
    final mockVoidCallback = MockVoidCallback();

    final widget = wrapWithMaterialAppLocalizationDelegates(
      SignOutConfirmationDialog(
        onConfirm: mockVoidCallback,
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

    testWidgets('when cancel button pressed, expect callback is not invoked', (tester) async {
      await tester.pumpWidget(widget);

      await tester.pumpAndSettle();

      await tester.tap(find.text(
        AppLocalizations.current.generalCancel.toUpperCase(),
      ));

      verifyNever(mockVoidCallback.call());
    });

    testWidgets('when confirm button pressed, expect callback is invoked', (tester) async {
      await tester.pumpWidget(widget);

      await tester.pumpAndSettle();

      await tester.tap(find.text(
        AppLocalizations.current.signOutConfirmationDialogConfirmButtonText.toUpperCase(),
      ));

      verify(mockVoidCallback.call()).called(1);
    });
  });
}
