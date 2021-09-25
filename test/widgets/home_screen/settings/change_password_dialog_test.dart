import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/widgets/common/input_fields/password_input.dart';
import 'package:film_freund/widgets/home_screen/settings/change_password_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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

      testWidgets('when same as current, expect no error', (tester) async {
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
          findsNothing,
        );
      }, skip: true);
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
  });
}
