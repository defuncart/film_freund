import 'package:email_validator/email_validator.dart';
import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/services/service_locator.dart';
import 'package:film_freund/widgets/common/input_fields/password_input.dart';
import 'package:film_freund/widgets/common/modal_progress_indicator.dart';
import 'package:film_freund/widgets/home_screen/home_screen.dart';
import 'package:film_freund/widgets/signin_screen/signin_error_dialog.dart';
import 'package:flutter/material.dart';

@visibleForTesting
abstract class SigninScreenKeys {
  @visibleForTesting
  static const emailTextField = Key('SigninScreenEmailTextField');

  @visibleForTesting
  static const passwordTextField = Key('SigninScreenPasswordTextField');

  @visibleForTesting
  static const signinButton = Key('SigninScreenSigninButton');
}

class SigninScreen extends StatefulWidget {
  static const routeName = 'LoginScreen';

  const SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  var _isValidEmail = false;
  var _isValidPassword = false;

  bool get _canSubmit => _isValidEmail && _isValidPassword;
  bool get _shouldShowEmailError => _emailController.text.isNotEmpty && !_isValidEmail;
  bool get _shouldShowPasswordError => _passwordController.text.isNotEmpty && !_isValidPassword;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _emailController.addListener(() {
      setState(() => _isValidEmail = EmailValidator.validate(_emailController.text));
    });

    _passwordController = TextEditingController();
    _passwordController.addListener(() {
      setState(() => _isValidPassword = _passwordController.text.length >= 6);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  key: SigninScreenKeys.emailTextField,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context).signinScreenEmailHintText,
                    errorText: _shouldShowEmailError ? AppLocalizations.of(context).signinScreenEmailErrorText : null,
                  ),
                  autofocus: true,
                  autocorrect: false,
                ),
                const SizedBox(height: 8),
                PasswordInput(
                  key: SigninScreenKeys.passwordTextField,
                  controller: _passwordController,
                  hintText: AppLocalizations.of(context).generalPasswordHint,
                  errorText: _shouldShowPasswordError ? AppLocalizations.of(context).generalInvalidPassword : null,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  key: SigninScreenKeys.signinButton,
                  onPressed: _canSubmit ? () => _signin() : null,
                  child: Text(AppLocalizations.of(context).signinScreenSigninButtonText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signin() async {
    ModalProgressIndicator.show(context);

    final result = await ServiceLocator.userManager.signin(
      email: _emailController.text,
      password: _passwordController.text,
    );

    ModalProgressIndicator.hide();

    switch (result) {
      case AuthResult.createSuccess:
      case AuthResult.signinSuccess:
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        break;
      case AuthResult.signinIncorrectPassword:
      case AuthResult.other:
        showDialog(
          context: context,
          builder: (_) => const SignInErrorDialog(),
        );
    }
  }
}
