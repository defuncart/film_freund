import 'package:email_validator/email_validator.dart';
import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/widgets/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  static const routeName = 'LoginScreen';

  const SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  var _validEmail = false;
  var _validPassword = false;
  var _shouldObscurePassword = true;

  bool get _canSubmit => _validEmail && _validPassword;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailController.addListener(() {
      final validEmail = EmailValidator.validate(_emailController.text);
      if (validEmail != _validEmail) {
        setState(() => _validEmail = validEmail);
      }
    });
    _passwordController.addListener(() {
      final validPassword = _passwordController.text.length >= 6;
      if (validPassword != _validPassword) {
        setState(() => _validPassword = validPassword);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).signinScreenEmailHintText,
              ),
              autofocus: true,
              autocorrect: false,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).signinScreenPasswordHintText,
                suffixIcon: IconButton(
                  icon: Icon(
                    _shouldObscurePassword ? Icons.visibility : Icons.visibility_off,
                    // color: Colors.black,
                  ),
                  onPressed: () => setState(() => _shouldObscurePassword = !_shouldObscurePassword),
                ),
              ),
              obscureText: _shouldObscurePassword,
              autocorrect: false,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _canSubmit ? () => _signin() : null,
              child: Text(AppLocalizations.of(context).signinScreenSigninButtonText),
            ),
          ],
        ),
      ),
    );
  }

  void _signin() => Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
}
