import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/services/service_locator.dart';
import 'package:film_freund/widgets/common/input_fields/password_input.dart';
import 'package:film_freund/widgets/common/modal_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

@visibleForTesting
abstract class ChangePasswordDialogKeys {
  @visibleForTesting
  static const currentPasswordTextField = Key('ChangePasswordCurrentPasswordTextField');

  @visibleForTesting
  static const newPasswordTextField = Key('ChangePasswordNewPasswordTextField');

  @visibleForTesting
  static const repeatNewPasswordTextField = Key('ChangePasswordRepeatNewPasswordTextField');
}

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _repeatNewPasswordController;
  var _isCurrentPasswordValid = false;
  var _isNewPasswordValid = false;
  var _isRepeatNewPasswordValid = false;
  String? _currentPasswordErrorText;
  String? _newPasswordErrorText;

  bool get _shouldShowRepeatNewPasswordError =>
      _repeatNewPasswordController.text.isNotEmpty && !_isRepeatNewPasswordValid;
  bool get _canSubmit => _isCurrentPasswordValid && _isNewPasswordValid && _isRepeatNewPasswordValid;

  @override
  void initState() {
    super.initState();

    _currentPasswordController = TextEditingController()
      ..addListener(() {
        setState(() {
          _isCurrentPasswordValid = _currentPasswordController.text.length >= 6;
          if (_currentPasswordController.text.isNotEmpty && !_isCurrentPasswordValid) {
            _currentPasswordErrorText = AppLocalizations.of(context).generalInvalidPassword;
          } else {
            _currentPasswordErrorText = null;
          }
        });
      });
    _newPasswordController = TextEditingController()
      ..addListener(() {
        setState(() {
          if (_currentPasswordController.text.isNotEmpty &&
              _newPasswordController.text == _currentPasswordController.text) {
            _newPasswordErrorText = AppLocalizations.of(context).changePasswordDialogNewPasswordErrorText;
            _isNewPasswordValid = false;
          } else if (_newPasswordController.text.isNotEmpty && _newPasswordController.text.length < 6) {
            _newPasswordErrorText = AppLocalizations.of(context).generalInvalidPassword;
            _isNewPasswordValid = false;
          } else {
            _isNewPasswordValid = true;
            _newPasswordErrorText = null;
          }
        });
      });
    _repeatNewPasswordController = TextEditingController()
      ..addListener(() {
        setState(() {
          _isRepeatNewPasswordValid = _repeatNewPasswordController.text == _newPasswordController.text;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).changePasswordDialogTitleText),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PasswordInput(
            key: ChangePasswordDialogKeys.currentPasswordTextField,
            controller: _currentPasswordController,
            hintText: AppLocalizations.of(context).changePasswordDialogCurrentPasswordHintText,
            errorText: _currentPasswordErrorText,
          ),
          const Gap(16),
          PasswordInput(
            key: ChangePasswordDialogKeys.newPasswordTextField,
            controller: _newPasswordController,
            hintText: AppLocalizations.of(context).changePasswordDialogNewPasswordHintText,
            errorText: _newPasswordErrorText,
          ),
          const Gap(16),
          PasswordInput(
            key: ChangePasswordDialogKeys.repeatNewPasswordTextField,
            controller: _repeatNewPasswordController,
            hintText: AppLocalizations.of(context).changePasswordDialogRepeatNewPasswordHintText,
            errorText: _shouldShowRepeatNewPasswordError
                ? AppLocalizations.of(context).changePasswordDialogRepeatNewPasswordErrorText
                : null,
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
          onPressed: _canSubmit
              ? () async {
                  ModalProgressIndicator.show(context);

                  final result = await ServiceLocator.userManager.changePassword(
                    currentPassword: _currentPasswordController.text,
                    newPassword: _newPasswordController.text,
                  );

                  ModalProgressIndicator.hide();

                  switch (result) {
                    case ChangePasswordResult.success:
                      Navigator.of(context).pop();
                      break;
                    case ChangePasswordResult.incorrectPassword:
                      setState(() => _currentPasswordErrorText = AppLocalizations.of(context).generalIncorrectPassword);
                      break;
                    case ChangePasswordResult.other:
                      setState(() => _currentPasswordErrorText = AppLocalizations.of(context).generalErrorOccured);
                      break;
                  }
                }
              : null,
          child: Text(
            AppLocalizations.of(context).changePasswordDialogConfirmButtonText.toUpperCase(),
          ),
        ),
      ],
    );
  }
}
