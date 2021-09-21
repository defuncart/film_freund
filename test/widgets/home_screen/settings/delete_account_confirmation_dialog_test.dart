import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/managers/user/user_manager.dart';
import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/widgets/home_screen/settings/delete_account_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_ui/flutter_test_ui.dart';
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
        find.text(AppLocalizations.current.generalPasswordHint),
        findsOneWidget,
      );

      expect(
        find.text(AppLocalizations.current.generalCancel.toUpperCase()),
        findsOneWidget,
      );

      expect(
        find.text(AppLocalizations.current.deleteAccountConfirmationDialogConfirmButtonText.toUpperCase()),
        findsOneWidget,
      );
    });

    testWidgets('when password is not valid, expect error text', (tester) async {
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

    group('when password is valid', () {
      const password = '123456';

      setUpUI((tester) async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        await tester.enterText(find.byKey(DeleteAccountConfirmationDialog.passwordTextFieldKey), password);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();
      });

      testUI('expect no error text', (tester) async {
        expect(
          find.text(AppLocalizations.current.generalInvalidPassword),
          findsNothing,
        );
      });

      const email = 'a@a.aa';

      group('when cancel button is pressed', () {
        testUI('ensure no callbacks are invoked', (tester) async {
          expect(isPressed, isFalse);

          await tester.tap(find.text(
            AppLocalizations.current.generalCancel.toUpperCase(),
          ));

          expect(isPressed, isFalse);
          verifyNever(mockUserManager.currentUser);
          verifyNever(mockUserManager.deleteUser(email: email, password: password));
        });
      });

      group('when delete button is pressed', () {
        final user = TestInstance.user(email: email);
        when(mockUserManager.currentUser).thenAnswer((_) => Future.value(user));

        testUI('and ${DeleteResult.success}, ensure callback is invoked', (tester) async {
          expect(isPressed, isFalse);

          when(mockUserManager.deleteUser(email: email, password: password))
              .thenAnswer((_) => Future.value(DeleteResult.success));

          await tester.tap(find.text(
            AppLocalizations.current.deleteAccountConfirmationDialogConfirmButtonText.toUpperCase(),
          ));

          expect(isPressed, isTrue);
          isPressed = false; // reset otherwise subsequent tests will fail
        });

        testUI('and ${DeleteResult.incorrectPassword}, ensure error text', (tester) async {
          expect(isPressed, isFalse);

          when(mockUserManager.deleteUser(email: email, password: password))
              .thenAnswer((_) => Future.value(DeleteResult.incorrectPassword));

          await tester.tap(find.text(
            AppLocalizations.current.deleteAccountConfirmationDialogConfirmButtonText.toUpperCase(),
          ));

          await tester.pumpAndSettle();

          expect(
            find.text(AppLocalizations.current.generalIncorrectPassword),
            findsOneWidget,
          );
          expect(isPressed, isFalse);
        });

        testUI('and ${DeleteResult.other}, ensure error text', (tester) async {
          expect(isPressed, isFalse);

          when(mockUserManager.deleteUser(email: email, password: password))
              .thenAnswer((_) => Future.value(DeleteResult.other));

          await tester.tap(find.text(
            AppLocalizations.current.deleteAccountConfirmationDialogConfirmButtonText.toUpperCase(),
          ));

          await tester.pumpAndSettle();

          expect(
            find.text(AppLocalizations.current.generalErrorOccured),
            findsOneWidget,
          );
          expect(isPressed, isFalse);
        });
      });
    });
  });
}
