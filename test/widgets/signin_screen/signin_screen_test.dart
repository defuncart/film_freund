import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/managers/user/user_manager.dart';
import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/widgets/common/input_fields/password_input.dart';
import 'package:film_freund/widgets/home_screen/home_screen.dart';
import 'package:film_freund/widgets/signin_screen/signin_error_dialog.dart';
import 'package:film_freund/widgets/signin_screen/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_ui/flutter_test_ui.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.dart';
import '../../riverpod_overrides.dart';
import '../../test_service_locator.dart';
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
      expect(find.byType(PasswordInput), findsOneWidget);
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

      await tester.enterText(find.byKey(SigninScreenKeys.emailTextField), 'bla');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(
        find.text(AppLocalizations.current.signinScreenEmailErrorText),
        findsOneWidget,
      );
      expect(
        tester.widget<TextField>(find.byKey(SigninScreenKeys.emailTextField)).decoration?.errorText,
        isNotNull,
      );
    });

    testWidgets('when email is valid, expect no error', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(SigninScreenKeys.emailTextField), 'a@a.a');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(
        find.text(AppLocalizations.current.signinScreenEmailErrorText),
        findsNothing,
      );
      expect(
        tester.widget<TextField>(find.byKey(SigninScreenKeys.emailTextField)).decoration?.errorText,
        isNull,
      );
    });

    testWidgets('when password is not valid, expect error', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(SigninScreenKeys.passwordTextField), 'bla');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(
        find.text(AppLocalizations.current.generalInvalidPassword),
        findsOneWidget,
      );
    });

    testWidgets('when password is valid, expect no error', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(SigninScreenKeys.passwordTextField), '123456');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(
        find.text(AppLocalizations.current.generalInvalidPassword),
        findsNothing,
      );
    });

    testWidgets('when email and password are not valid, signin button is disabled', (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(SigninScreenKeys.emailTextField), 'bla');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.enterText(find.byKey(SigninScreenKeys.passwordTextField), 'bla');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(
        tester.widget<ElevatedButton>(find.byKey(SigninScreenKeys.signinButton)).enabled,
        isFalse,
      );
    });

    group('when email and password are valid, signin button is enabled', () {
      const email = 'a@a.aa';
      const password = '123456';
      final UserManager mockUserManager = MockUserManager();
      TestServiceLocator.register(
        userManager: mockUserManager,
      );

      setUpUI((tester) async {
        await tester.pumpWidget(
          // need to wrap with popular provider in the event of transitioning to HomeScreen
          RiverpodOverrides.popularMovies(widget),
        );
        await tester.pumpAndSettle();

        await tester.enterText(find.byKey(SigninScreenKeys.emailTextField), email);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.enterText(find.byKey(SigninScreenKeys.passwordTextField), password);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();
      });

      testUI('expect no error', (tester) async {
        expect(
          find.text(AppLocalizations.current.signinScreenEmailErrorText),
          findsNothing,
        );
        expect(
          find.text(AppLocalizations.current.generalInvalidPassword),
          findsNothing,
        );
      });

      testUI('expect signin button is enabled', (tester) async {
        final buttonFinder = find.ancestor(
          of: find.text(
            AppLocalizations.current.signinScreenSigninButtonText,
          ),
          matching: find.byType(ElevatedButton),
        );

        expect(
          tester.widget<ElevatedButton>(buttonFinder).enabled,
          isTrue,
        );
      });

      group('when signin button is pressed', () {
        testUI('and ${AuthResult.createSuccess}, ensure callback is invoked', (tester) async {
          when(mockUserManager.signin(email: email, password: password))
              .thenAnswer((_) => Future.value(AuthResult.createSuccess));

          await tester.tap(find.text(
            AppLocalizations.current.signinScreenSigninButtonText,
          ));
          await tester.pumpAndSettle();

          expect(find.byType(SigninScreen), findsNothing);
          expect(find.byType(HomeScreen), findsOneWidget);
        });

        testUI('and ${AuthResult.signinSuccess}, ensure callback is invoked', (tester) async {
          when(mockUserManager.signin(email: email, password: password))
              .thenAnswer((_) => Future.value(AuthResult.signinSuccess));

          await tester.tap(find.text(
            AppLocalizations.current.signinScreenSigninButtonText,
          ));
          await tester.pumpAndSettle();

          expect(find.byType(SigninScreen), findsNothing);
          expect(find.byType(HomeScreen), findsOneWidget);
        });

        testUI('and ${AuthResult.signinIncorrectPassword}, ensure callback is invoked', (tester) async {
          when(mockUserManager.signin(email: email, password: password))
              .thenAnswer((_) => Future.value(AuthResult.signinIncorrectPassword));

          await tester.tap(find.text(
            AppLocalizations.current.signinScreenSigninButtonText,
          ));
          await tester.pumpAndSettle();

          expect(find.byType(SigninScreen), findsOneWidget);
          expect(find.byType(SignInErrorDialog), findsOneWidget);
          expect(find.byType(HomeScreen), findsNothing);
        });

        testUI('and ${AuthResult.other}, ensure callback is invoked', (tester) async {
          when(mockUserManager.signin(email: email, password: password))
              .thenAnswer((_) => Future.value(AuthResult.other));

          await tester.tap(find.text(
            AppLocalizations.current.signinScreenSigninButtonText,
          ));
          await tester.pumpAndSettle();

          expect(find.byType(SigninScreen), findsOneWidget);
          expect(find.byType(SignInErrorDialog), findsOneWidget);
          expect(find.byType(HomeScreen), findsNothing);
        });
      });
    });
  });
}
