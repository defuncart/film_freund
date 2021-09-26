import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/managers/user/user_manager.dart';
import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/widgets/common/input_fields/password_input.dart';
import 'package:film_freund/widgets/home_screen/settings/change_password_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_ui/flutter_test_ui.dart';
import 'package:mockito/mockito.dart';

import '../../../mocks.dart';
import '../../../test_service_locator.dart';
import '../../../test_utils.dart';

void main() {
  group('$ChangePasswordDialog', () {
    final widget = wrapWithMaterialAppLocalizationDelegates(
      const ChangePasswordDialog(),
    );

    testWidgets('expect correct widget tree', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(3));
      expect(find.byType(PasswordInput), findsNWidgets(3));
      expect(find.byType(TextButton), findsNWidgets(2));
      expect(
        find.text(AppLocalizations.current.changePasswordDialogTitleText),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.current.changePasswordDialogCurrentPasswordHintText),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.current.changePasswordDialogNewPasswordHintText),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.current.changePasswordDialogRepeatNewPasswordHintText),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.current.generalCancel.toUpperCase()),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.current.changePasswordDialogConfirmButtonText.toUpperCase()),
        findsOneWidget,
      );
    });

    group('current password', () {
      testWidgets('when not valid, expect error', (tester) async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        await tester.enterText(find.byKey(ChangePasswordDialogKeys.currentPasswordTextField), 'bla');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();

        expect(
          find.text(AppLocalizations.current.generalInvalidPassword),
          findsOneWidget,
        );
      });

      testWidgets('when valid, expect no error', (tester) async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        await tester.enterText(find.byKey(ChangePasswordDialogKeys.currentPasswordTextField), '123456');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();

        expect(
          find.text(AppLocalizations.current.generalInvalidPassword),
          findsNothing,
        );
      });
    });

    group('new password', () {
      testWidgets('when not valid, expect error', (tester) async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        await tester.enterText(find.byKey(ChangePasswordDialogKeys.newPasswordTextField), 'bla');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();

        expect(
          find.text(AppLocalizations.current.generalInvalidPassword),
          findsOneWidget,
        );
      });

      testWidgets('when valid, expect no error', (tester) async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        await tester.enterText(find.byKey(ChangePasswordDialogKeys.newPasswordTextField), '123456');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();

        expect(
          find.text(AppLocalizations.current.generalInvalidPassword),
          findsNothing,
        );
      });

      testWidgets('when same as current, expect error', (tester) async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        await tester.enterText(find.byKey(ChangePasswordDialogKeys.currentPasswordTextField), '123456');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();

        await tester.enterText(find.byKey(ChangePasswordDialogKeys.newPasswordTextField), '123456');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();

        expect(
          find.text(AppLocalizations.current.changePasswordDialogNewPasswordErrorText),
          findsOneWidget,
        );
      });

      testWidgets('when not same as current, expect no error', (tester) async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        await tester.enterText(find.byKey(ChangePasswordDialogKeys.currentPasswordTextField), '123456');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();

        await tester.enterText(find.byKey(ChangePasswordDialogKeys.newPasswordTextField), '654321');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();

        expect(
          find.text(AppLocalizations.current.changePasswordDialogNewPasswordErrorText),
          findsNothing,
        );
      });
    });

    group('repeat password', () {
      testWidgets('when not same as new password, expect error', (tester) async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        await tester.enterText(find.byKey(ChangePasswordDialogKeys.newPasswordTextField), 'bla');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.enterText(find.byKey(ChangePasswordDialogKeys.repeatNewPasswordTextField), 'bl');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();

        expect(
          find.text(AppLocalizations.current.changePasswordDialogRepeatNewPasswordErrorText),
          findsOneWidget,
        );
      });

      testWidgets('when same as new password, expect no error', (tester) async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        await tester.enterText(find.byKey(ChangePasswordDialogKeys.newPasswordTextField), 'bla');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.enterText(find.byKey(ChangePasswordDialogKeys.repeatNewPasswordTextField), 'bla');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();

        expect(
          find.text(AppLocalizations.current.changePasswordDialogRepeatNewPasswordErrorText),
          findsNothing,
        );
      });
    });

    testWidgets('when current, new or repeat passwords are not valid, continue button is disabled', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(ChangePasswordDialogKeys.currentPasswordTextField), 'bla');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.enterText(find.byKey(ChangePasswordDialogKeys.newPasswordTextField), 'bla');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.enterText(find.byKey(ChangePasswordDialogKeys.repeatNewPasswordTextField), 'bl');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      final textButtonFinder = find.ancestor(
        of: find.text(
          AppLocalizations.current.changePasswordDialogConfirmButtonText.toUpperCase(),
        ),
        matching: find.byType(TextButton),
      );

      expect(
        tester.widget<TextButton>(textButtonFinder).enabled,
        isFalse,
      );
    });

    group('when current, new and repeat passwords are  valid', () {
      const currentPassword = '123456';
      const newPassword = '654321';
      final UserManager mockUserManager = MockUserManager();
      TestServiceLocator.register(
        userManager: mockUserManager,
      );

      setUpUI((tester) async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        await tester.enterText(find.byKey(ChangePasswordDialogKeys.currentPasswordTextField), currentPassword);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.enterText(find.byKey(ChangePasswordDialogKeys.newPasswordTextField), newPassword);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.enterText(find.byKey(ChangePasswordDialogKeys.repeatNewPasswordTextField), newPassword);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();
      });

      testUI('expect no error', (tester) async {
        expect(
          find.text(AppLocalizations.current.generalInvalidPassword),
          findsNothing,
        );
        expect(
          find.text(AppLocalizations.current.changePasswordDialogNewPasswordErrorText),
          findsNothing,
        );
        expect(
          find.text(AppLocalizations.current.changePasswordDialogRepeatNewPasswordErrorText),
          findsNothing,
        );
      });

      testUI('expect continue button is enabled', (tester) async {
        final textButtonFinder = find.ancestor(
          of: find.text(
            AppLocalizations.current.changePasswordDialogConfirmButtonText.toUpperCase(),
          ),
          matching: find.byType(TextButton),
        );

        expect(
          tester.widget<TextButton>(textButtonFinder).enabled,
          isTrue,
        );
      });

      group('when cancel button is pressed', () {
        testUI('ensure no callbacks are invoked', (tester) async {
          await tester.tap(find.text(
            AppLocalizations.current.generalCancel.toUpperCase(),
          ));

          verifyNever(mockUserManager.changePassword(
            currentPassword: currentPassword,
            newPassword: newPassword,
          ));
        });
      });

      group('when continue button is pressed', () {
        testUI('and ${ChangePasswordResult.success}, ensure callback is invoked', (tester) async {
          when(mockUserManager.changePassword(currentPassword: currentPassword, newPassword: newPassword))
              .thenAnswer((_) => Future.value(ChangePasswordResult.success));

          await tester.tap(find.text(
            AppLocalizations.current.changePasswordDialogConfirmButtonText.toUpperCase(),
          ));
          await tester.pumpAndSettle();

          expect(find.byType(ChangePasswordDialog), findsNothing);
        });

        testUI('and ${ChangePasswordResult.incorrectPassword}, ensure incorrect password error', (tester) async {
          when(mockUserManager.changePassword(currentPassword: currentPassword, newPassword: newPassword))
              .thenAnswer((_) => Future.value(ChangePasswordResult.incorrectPassword));

          await tester.tap(find.text(
            AppLocalizations.current.changePasswordDialogConfirmButtonText.toUpperCase(),
          ));
          await tester.pumpAndSettle();

          expect(
            find.text(AppLocalizations.current.generalIncorrectPassword),
            findsOneWidget,
          );
        });

        testUI('and ${ChangePasswordResult.other}, ensure general error', (tester) async {
          when(mockUserManager.changePassword(currentPassword: currentPassword, newPassword: newPassword))
              .thenAnswer((_) => Future.value(ChangePasswordResult.other));

          await tester.tap(find.text(
            AppLocalizations.current.changePasswordDialogConfirmButtonText.toUpperCase(),
          ));
          await tester.pumpAndSettle();

          expect(
            find.text(AppLocalizations.current.generalErrorOccured),
            findsOneWidget,
          );
        });
      });
    });
  });
}
