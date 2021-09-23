import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/managers/user/user_manager.dart';
import 'package:film_freund/widgets/home_screen/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks.dart';
import '../../../test_service_locator.dart';
import '../../../test_utils.dart';

void main() {
  group('$SettingsView', () {
    // TODO
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

    // TODO maybe only for certain tests
    final UserManager mockUserManager = MockUserManager();
    TestServiceLocator.register(
      userManager: mockUserManager,
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
  });
}
