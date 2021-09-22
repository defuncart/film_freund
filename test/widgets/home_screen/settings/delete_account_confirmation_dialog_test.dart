import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/managers/user/user_manager.dart';
import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/widgets/common/input_fields/password_input.dart';
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
    final mockVoidCallback = MockVoidCallback();

    final widget = wrapWithMaterialAppLocalizationDelegates(
      DeleteAccountConfirmationDialog(
        onAccountDeleted: mockVoidCallback,
      ),
    );

    final UserManager mockUserManager = MockUserManager();
    TestServiceLocator.register(userManager: mockUserManager);

    testWidgets('Ensure content is correct', (tester) async {
      await tester.pumpWidget(widget);

      await tester.pumpAndSettle();

      expect(find.byType(Text), findsNWidgets(5));
      expect(find.byType(PasswordInput), findsOneWidget);

      expect(
        find.text(AppLocalizations.current.deleteAccountConfirmationDialogTitleText),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.current.deleteAccountConfirmationDialogDescriptionText),
        findsOneWidget,
      );
      expect(
        find.byKey(DeleteAccountConfirmationDialogKeys.passwordTextField),
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

      expect(
        tester.widget<TextButton>(find.byKey(DeleteAccountConfirmationDialogKeys.deleteButton)).enabled,
        isFalse,
      );
    });

    testWidgets('when password is not valid, expect error', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(DeleteAccountConfirmationDialogKeys.passwordTextField), 'bla');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(
        find.text(AppLocalizations.current.generalInvalidPassword),
        findsOneWidget,
      );
      expect(
        tester.widget<TextButton>(find.byKey(DeleteAccountConfirmationDialogKeys.deleteButton)).enabled,
        isFalse,
      );
    });

    group('when password is valid', () {
      const password = '123456';

      setUpUI((tester) async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        await tester.enterText(find.byKey(DeleteAccountConfirmationDialogKeys.passwordTextField), password);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();
      });

      testUI('expect no error', (tester) async {
        expect(
          find.text(AppLocalizations.current.generalInvalidPassword),
          findsNothing,
        );
        expect(
          tester.widget<TextButton>(find.byKey(DeleteAccountConfirmationDialogKeys.deleteButton)).enabled,
          isTrue,
        );
      });

      const email = 'a@a.aa';

      group('when cancel button is pressed', () {
        testUI('ensure no callbacks are invoked', (tester) async {
          await tester.tap(find.text(
            AppLocalizations.current.generalCancel.toUpperCase(),
          ));

          verifyNever(mockVoidCallback.call());
          verifyNever(mockUserManager.currentUser);
          verifyNever(mockUserManager.deleteUser(email: email, password: password));
        });
      });

      group('when delete button is pressed', () {
        final user = TestInstance.user(email: email);
        when(mockUserManager.currentUser).thenAnswer((_) => Future.value(user));

        testUI('and ${DeleteResult.success}, ensure callback is invoked', (tester) async {
          when(mockUserManager.deleteUser(email: email, password: password))
              .thenAnswer((_) => Future.value(DeleteResult.success));

          await tester.tap(find.text(
            AppLocalizations.current.deleteAccountConfirmationDialogConfirmButtonText.toUpperCase(),
          ));

          verify(mockVoidCallback.call()).called(1);
        });

        testUI('and ${DeleteResult.incorrectPassword}, ensure incorrect password error', (tester) async {
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
          verifyNever(mockVoidCallback.call());
        });

        testUI('and ${DeleteResult.other}, ensure general error', (tester) async {
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
          verifyNever(mockVoidCallback.call());
        });
      });
    });
  });
}
