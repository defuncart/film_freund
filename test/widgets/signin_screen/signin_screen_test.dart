import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/widgets/signin_screen/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_utils.dart';

void main() {
  group('$SigninScreen', () {
    final widget = wrapWithMaterialAppLocalizationDelegates(
      const SigninScreen(),
    );

    testWidgets('expect correct widget tree', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(
        find.text(AppLocalizations.current.signinScreenEmailHintText),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.current.generalPasswordHint),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.current.signinScreenSigninButtonText),
        findsOneWidget,
      );
    });

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
      expect(
        tester.widget<TextField>(find.byKey(emailTextFieldKey)).decoration?.errorText,
        isNotNull,
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
      expect(
        tester.widget<TextField>(find.byKey(emailTextFieldKey)).decoration?.errorText,
        isNull,
      );
    });

    testWidgets('when password is not valid, expect error', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(passwordTextFieldKey), 'bla');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(
        find.text(AppLocalizations.current.generalInvalidPassword),
        findsOneWidget,
      );
      expect(
        tester.widget<TextField>(find.byKey(passwordTextFieldKey)).decoration?.errorText,
        isNotNull,
      );
    });

    testWidgets('when password is valid, expect no error', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(passwordTextFieldKey), '123456');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(
        find.text(AppLocalizations.current.generalInvalidPassword),
        findsNothing,
      );
      expect(
        tester.widget<TextField>(find.byKey(passwordTextFieldKey)).decoration?.errorText,
        isNull,
      );
    });

    testWidgets('when email and password are not valid, signin button is disabled', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(emailTextFieldKey), 'bla');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.enterText(find.byKey(passwordTextFieldKey), 'bla');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(
        tester.widget<ElevatedButton>(find.byKey(signinButtonKey)).enabled,
        isFalse,
      );
    });

    testWidgets('when email and password are valid, signin button is enabled', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(emailTextFieldKey), 'a@a.aa');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.enterText(find.byKey(passwordTextFieldKey), '123456');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(
        tester.widget<ElevatedButton>(find.byKey(signinButtonKey)).enabled,
        isTrue,
      );
    });
  });
}
