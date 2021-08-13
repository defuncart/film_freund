import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/widgets/signin_screen/signin_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_utils.dart';

void main() {
  group('$SigninScreen', () {
    final widget = wrapWithMaterialAppLocalizationDelegates(
      const SigninScreen(),
    );

    testWidgets('when email is not valid, expect error', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(emailTextFieldKey), 'bla');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(
        find.text(AppLocalizations.current.signinScreenEmailErrorText),
        findsOneWidget,
      );
    });

    testWidgets('when email is valid, expect no error', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(emailTextFieldKey), 'a@a.a');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(
        find.text(AppLocalizations.current.signinScreenEmailErrorText),
        findsNothing,
      );
    });

    testWidgets('when password is not valid, expect error', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(passwordTextFieldKey), 'bla');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(
        find.text(AppLocalizations.current.signinScreenPasswordErrorText),
        findsOneWidget,
      );
    });

    testWidgets('when password is valid, expect no error', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(passwordTextFieldKey), '123456');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(
        find.text(AppLocalizations.current.signinScreenPasswordErrorText),
        findsNothing,
      );
    });
  });
}
