import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/widgets/signin_screen/signin_error_dialog.dart';
import 'package:flutter/material.dart' show Text;
import 'package:flutter_test/flutter_test.dart';

import '../../test_utils.dart';

void main() {
  group('$SignInErrorDialog', () {
    final widget = wrapWithMaterialAppLocalizationDelegates(
      const SignInErrorDialog(),
    );

    testWidgets('Ensure content is correct', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(
        find.byType(SignInErrorDialog),
        findsOneWidget,
      );
      expect(find.byType(Text), findsNWidgets(3));
      expect(
        find.text(AppLocalizations.current.signinErrorDialogTitleText),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.current.signinErrorDialogDescriptionText),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.current.signinErrorDialogButtonText.toUpperCase()),
        findsOneWidget,
      );
    });

    testWidgets('When button is pressed, expect dialog is closed', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(
        find.byType(SignInErrorDialog),
        findsOneWidget,
      );

      await tester.tap(
        find.text(AppLocalizations.current.signinErrorDialogButtonText.toUpperCase()),
      );
      await tester.pumpAndSettle();

      expect(
        find.byType(SignInErrorDialog),
        findsNothing,
      );
    });
  });
}
