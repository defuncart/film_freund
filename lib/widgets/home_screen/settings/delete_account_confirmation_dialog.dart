import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/services/service_locator.dart';
import 'package:film_freund/widgets/common/input_fields/password_input.dart';
import 'package:film_freund/widgets/common/modal_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

@visibleForTesting
class DeleteAccountConfirmationDialogKeys {
  DeleteAccountConfirmationDialogKeys._();

  @visibleForTesting
  static const passwordTextField = Key('DeleteAccountPasswordTextField');

  @visibleForTesting
  static const deleteButton = Key('SigninScreenDeleteButton');
}

class DeleteAccountConfirmationDialog extends StatefulWidget {
  const DeleteAccountConfirmationDialog({
    required this.onAccountDeleted,
    Key? key,
  }) : super(key: key);

  final VoidCallback onAccountDeleted;

  @override
  State<DeleteAccountConfirmationDialog> createState() => _DeleteAccountConfirmationDialogState();
}

class _DeleteAccountConfirmationDialogState extends State<DeleteAccountConfirmationDialog> {
  late TextEditingController _passwordController;
  var _isValidPassword = false;
  String? _passwordErrorText;

  @override
  void initState() {
    super.initState();

    _passwordController = TextEditingController();
    _passwordController.addListener(() {
      setState(() {
        _isValidPassword = _passwordController.text.length >= 6;
        if (_passwordController.text.isNotEmpty && !_isValidPassword) {
          _passwordErrorText = AppLocalizations.of(context).generalInvalidPassword;
        } else {
          _passwordErrorText = null;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).deleteAccountConfirmationDialogTitleText),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalizations.of(context).deleteAccountConfirmationDialogDescriptionText),
          const Gap(16),
          PasswordInput(
            key: DeleteAccountConfirmationDialogKeys.passwordTextField,
            controller: _passwordController,
            hintText: AppLocalizations.of(context).generalPasswordHint,
            errorText: _passwordErrorText,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            AppLocalizations.of(context).generalCancel.toUpperCase(),
          ),
        ),
        TextButton(
          key: DeleteAccountConfirmationDialogKeys.deleteButton,
          onPressed: _isValidPassword
              ? () async {
                  ModalProgressIndicator.show(context);

                  final currentUser = await ServiceLocator.userManager.currentUser;
                  final result = await ServiceLocator.userManager.deleteUser(
                    email: currentUser.email,
                    password: _passwordController.text,
                  );

                  ModalProgressIndicator.hide();

                  switch (result) {
                    case DeleteResult.success:
                      widget.onAccountDeleted();
                      break;
                    case DeleteResult.incorrectPassword:
                      setState(() => _passwordErrorText = AppLocalizations.of(context).generalIncorrectPassword);
                      break;
                    case DeleteResult.other:
                      setState(() => _passwordErrorText = AppLocalizations.of(context).generalErrorOccured);
                      break;
                  }
                }
              : null,
          child: Text(
            AppLocalizations.of(context).deleteAccountConfirmationDialogConfirmButtonText.toUpperCase(),
          ),
        ),
      ],
    );
  }
}
