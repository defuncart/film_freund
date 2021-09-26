import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/managers/user/user_manager.dart';
import 'package:film_freund/state/current_user_provider.dart';
import 'package:film_freund/widgets/home_screen/settings/change_password_dialog.dart';
import 'package:film_freund/widgets/home_screen/settings/delete_account_confirmation_dialog.dart';
import 'package:film_freund/widgets/home_screen/settings/settings_view.dart';
import 'package:film_freund/widgets/home_screen/settings/sign_out_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks.dart';
import '../../../test_service_locator.dart';
import '../../../test_utils.dart';

void main() {
  group('$SettingsView', () {
    testWidgets('SettingsView loading', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            currentUserProvider.overrideWithProvider(
              FutureProvider.autoDispose((_) => Future.error('')),
            ),
          ],
          child: SettingsView(
            onSignOutConfirmed: () {},
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('SettingsView error', (tester) async {
      const error = 'error';
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            currentUserProvider.overrideWithProvider(
              FutureProvider.autoDispose((_) => Future.error(error)),
            )
          ],
          child: MaterialApp(
            home: Scaffold(
              body: SettingsView(
                onSignOutConfirmed: () {},
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(Text), findsOneWidget);
      expect(find.text(error), findsOneWidget);
    }, skip: false);

    testWidgets('SettingsView user', (tester) async {
      final user = TestInstance.user();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            currentUserProvider.overrideWithProvider(
              FutureProvider.autoDispose((_) => Future.value(user)),
            )
          ],
          child: wrapWithMaterialAppLocalizationDelegates(
            Scaffold(
              body: SettingsView(
                onSignOutConfirmed: () {},
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(SettingsViewContent), findsOneWidget);
    });
  });

  group('$SettingsViewContent', () {
    final user = TestInstance.user();
    final mockOnSignOutConfirmed = MockVoidCallback();
    final widget = wrapWithMaterialAppLocalizationDelegates(
      Scaffold(
        body: SettingsViewContent(
          user: user,
          onSignOutConfirmed: mockOnSignOutConfirmed,
        ),
      ),
    );

    testWidgets('ensure widget tree is correct', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(
        find.text(AppLocalizations.current.settingsViewSignedInAsText(user.email)),
        findsOneWidget,
      );
      expect(
        find.byType(TextButton),
        findsNWidgets(2),
      );
      expect(
        find.text(AppLocalizations.current.settingsViewChangePasswordButtonText.toUpperCase()),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.current.settingsViewSignOutButtonText.toUpperCase()),
        findsOneWidget,
      );
      expect(
        find.byType(TextField),
        findsOneWidget,
      );
      expect(
        find.byType(ElevatedButton),
        findsOneWidget,
      );
      expect(
        find.byType(Icon),
        findsOneWidget,
      );
      expect(
        find.byIcon(Icons.delete_forever),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.current.settingsViewDeleteAccountButtonText),
        findsOneWidget,
      );
    });

    testWidgets('when display name is not valid, expect error', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(SettingsViewContentKeys.displayNameTextField), '');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(
        find.text(AppLocalizations.current.settingsViewDisplayNameErrorText),
        findsOneWidget,
      );
    });

    testWidgets('when display name is valid, expect no error', (tester) async {
      final UserManager mockUserManager = MockUserManager();
      TestServiceLocator.register(
        userManager: mockUserManager,
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(SettingsViewContentKeys.displayNameTextField), 'a');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(
        find.text(AppLocalizations.current.settingsViewDisplayNameErrorText),
        findsNothing,
      );
    });

    testWidgets('when change password button is tapped, expect dialog', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.tap(
        find.text(AppLocalizations.current.settingsViewChangePasswordButtonText.toUpperCase()),
      );
      await tester.pumpAndSettle();

      expect(
        find.byType(ChangePasswordDialog),
        findsOneWidget,
      );
    });

    testWidgets('when sign out button is tapped, expect dialog', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.tap(
        find.text(AppLocalizations.current.settingsViewSignOutButtonText.toUpperCase()),
      );
      await tester.pumpAndSettle();

      expect(
        find.byType(SignOutConfirmationDialog),
        findsOneWidget,
      );
    });

    testWidgets('when delete account button is tapped, expect dialog', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.tap(
        find.byType(ElevatedButton),
      );
      await tester.pumpAndSettle();

      expect(
        find.byType(DeleteAccountConfirmationDialog),
        findsOneWidget,
      );
    });
  });
}
