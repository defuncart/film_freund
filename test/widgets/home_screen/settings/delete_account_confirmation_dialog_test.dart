import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/managers/user/user_manager.dart';
import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/widgets/home_screen/settings/delete_account_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mocks.dart';
import '../../../test_service_locator.dart';
import '../../../test_utils.dart';

void main() {
  group('$DeleteAccountConfirmationDialog', () {
    var isPressed = false;

    final widget = wrapWithMaterialAppLocalizationDelegates(
      DeleteAccountConfirmationDialog(
        onAccountDeleted: () => isPressed = true,
      ),
    );

    final UserManager mockUserManager = MockUserManager();
    TestServiceLocator.register(userManager: mockUserManager);

    testWidgets('Ensure content is correct', (tester) async {
      await tester.pumpWidget(widget);

      await tester.pumpAndSettle();

      expect(find.byType(Text), findsNWidgets(5));

      expect(
        find.text(AppLocalizations.current.deleteAccountConfirmationDialogTitleText),
        findsOneWidget,
      );

      expect(
        find.text(AppLocalizations.current.deleteAccountConfirmationDialogDescriptionText),
        findsOneWidget,
      );

      expect(
        find.byKey(DeleteAccountConfirmationDialog.passwordTextFieldKey),
        findsOneWidget,
      );

      expect(
        find.text(AppLocalizations.current.generalPasswordHintText),
        findsOneWidget,
      );

      expect(
        find.text(AppLocalizations.current.deleteAccountConfirmationDialogCancelButtonText.toUpperCase()),
        findsOneWidget,
      );

      expect(
        find.text(AppLocalizations.current.deleteAccountConfirmationDialogConfirmButtonText.toUpperCase()),
        findsOneWidget,
      );
    });

    testWidgets('when password is not valid, expect error', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(DeleteAccountConfirmationDialog.passwordTextFieldKey), 'bla');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(
        find.text(AppLocalizations.current.generalInvalidPassword),
        findsOneWidget,
      );
    });

    testWidgets('when password is valid, expect no error', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(DeleteAccountConfirmationDialog.passwordTextFieldKey), '123456');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(
        find.text(AppLocalizations.current.generalInvalidPassword),
        findsNothing,
      );
    });

    testWidgets('When password is valid, ensure callback can be invoked', (tester) async {
      const password = '123456';

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(DeleteAccountConfirmationDialog.passwordTextFieldKey), password);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(isPressed, isFalse);

      const email = 'a@a.aa';
      final user = TestInstance.user(email: email);
      when(mockUserManager.currentUser).thenAnswer((_) => Future.value(user));
      when(mockUserManager.deleteUser(email: email, password: password))
          .thenAnswer((_) => Future.value(DeleteResult.success));

      await tester.tap(find.text(
        AppLocalizations.current.deleteAccountConfirmationDialogConfirmButtonText.toUpperCase(),
      ));

      expect(isPressed, isTrue);
    });
  });
}
