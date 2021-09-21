import 'package:film_freund/generated/l10n.dart';
import 'package:flutter/material.dart';

class SignOutConfirmationDialog extends StatelessWidget {
  const SignOutConfirmationDialog({
    required this.onConfirm,
    Key? key,
  }) : super(key: key);

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(AppLocalizations.of(context).signOutConfirmationDialogDescriptionText),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            AppLocalizations.of(context).generalCancel.toUpperCase(),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: Text(
            AppLocalizations.of(context).signOutConfirmationDialogConfirmButtonText.toUpperCase(),
          ),
        ),
      ],
    );
  }
}
