import 'package:film_freund/generated/l10n.dart';
import 'package:flutter/material.dart';

class SignInErrorDialog extends StatelessWidget {
  const SignInErrorDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).signinErrorDialogTitleText),
      content: Text(AppLocalizations.of(context).signinErrorDialogDescriptionText),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            AppLocalizations.of(context).signinErrorDialogButtonText.toUpperCase(),
          ),
        ),
      ],
    );
  }
}
