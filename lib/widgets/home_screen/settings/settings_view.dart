import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/services/service_locator.dart';
import 'package:film_freund/services/user/models/user.dart';
import 'package:film_freund/widgets/home_screen/settings/change_password_dialog.dart';
import 'package:film_freund/widgets/home_screen/settings/delete_account_confirmation_dialog.dart';
import 'package:film_freund/widgets/home_screen/settings/sign_out_confirmation_dialog.dart';
import 'package:film_freund/widgets/signin_screen/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({
    required this.onSignOutConfirmed,
    Key? key,
  }) : super(key: key);

  final VoidCallback onSignOutConfirmed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return user.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (user) => SettingsViewContent(
        user: user,
        onSignOutConfirmed: onSignOutConfirmed,
      ),
    );
  }
}

@visibleForTesting
class SettingsViewContentKeys {
  SettingsViewContentKeys._();

  @visibleForTesting
  static const displayNameTextField = Key('SettingsViewContentDisplayNameTextField');
}

@visibleForTesting
class SettingsViewContent extends StatefulWidget {
  const SettingsViewContent({
    required this.user,
    required this.onSignOutConfirmed,
    Key? key,
  }) : super(key: key);

  final User user;
  final VoidCallback onSignOutConfirmed;

  @override
  State<SettingsViewContent> createState() => _SettingsViewContentState();
}

class _SettingsViewContentState extends State<SettingsViewContent> {
  late TextEditingController _displayNameController;
  late bool _isValidDisplayName;

  @override
  void initState() {
    super.initState();

    _displayNameController = TextEditingController(text: widget.user.displayName);
    _isValidDisplayName = _displayNameController.text.isNotEmpty;
    _displayNameController.addListener(() {
      setState(() {
        _isValidDisplayName = _displayNameController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context).settingsViewSignedInAsText(widget.user.email),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => showDialog(
                context: context,
                builder: (_) => const ChangePasswordDialog(),
              ),
              child: Text(
                AppLocalizations.of(context).settingsViewChangePasswordButtonText.toUpperCase(),
              ),
            ),
            TextButton(
              onPressed: () => showDialog(
                context: context,
                builder: (_) => SignOutConfirmationDialog(
                  onConfirm: widget.onSignOutConfirmed,
                ),
              ),
              child: Text(
                AppLocalizations.of(context).settingsViewSignOutButtonText.toUpperCase(),
              ),
            ),
          ],
        ),
        const Gap(16),
        TextField(
          key: SettingsViewContentKeys.displayNameTextField,
          controller: _displayNameController,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).settingsViewDisplayNameHintText,
            hintText: AppLocalizations.of(context).settingsViewDisplayNameHintText,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorText: !_isValidDisplayName ? AppLocalizations.of(context).settingsViewDisplayNameErrorText : null,
          ),
          autocorrect: false,
          onEditingComplete: () {
            if (_isValidDisplayName) {
              ServiceLocator.userManager.updateUser(
                user: widget.user,
                displayName: _displayNameController.text,
              );
            }
          },
        ),
        const Gap(16),
        ElevatedButton(
          onPressed: () => showDialog(
            context: context,
            builder: (_) => DeleteAccountConfirmationDialog(
              onAccountDeleted: () {
                Navigator.of(context).pushReplacementNamed(SigninScreen.routeName);
              },
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.delete_forever),
              const Gap(4),
              Text(AppLocalizations.of(context).settingsViewDeleteAccountButtonText),
            ],
          ),
        ),
      ],
    );
  }
}

final currentUserProvider = FutureProvider.autoDispose<User>((ref) async {
  return ServiceLocator.userManager.currentUser;
});
