import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/widgets/home_screen/settings/settings_view.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utils.dart';

void main() {
  group('$SettingsView', () {
    // TODO
  });

  group('$SettingsViewContent', () {
    testWidgets('Ensure onSignOutConfirmed can be invoked', (tester) async {
      var isPressed = false;
      final widget = wrapWithMaterialAppLocalizationDelegates(
        SettingsViewContent(
          user: TestInstance.user(),
          onSignOutConfirmed: () => isPressed = true,
        ),
      );

      await tester.pumpWidget(widget);

      await tester.pumpAndSettle();

      expect(isPressed, isFalse);

      await tester.tap(
        find.text(
          AppLocalizations.current.settingsViewSignOutButtonText.toLowerCase(),
        ),
      );

      expect(isPressed, isTrue);
    });
  });
}
