import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/services/service_locator.dart';
import 'package:film_freund/services/user/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return user.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (user) => SettingsViewContent(user: user),
    );
  }
}

@visibleForTesting
const displayNameTextFieldKey = Key('SettingsViewDisplayNameTextField');

@visibleForTesting
class SettingsViewContent extends StatelessWidget {
  const SettingsViewContent({
    required this.user,
    Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context).settingsViewSignedInAsText(user.email),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: null,
              child: Text(
                AppLocalizations.of(context).settingsViewChangePasswordButtonText.toUpperCase(),
              ),
            ),
            TextButton(
              onPressed: null,
              child: Text(
                AppLocalizations.of(context).settingsViewSignOutButtonText.toUpperCase(),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        TextField(
          key: displayNameTextFieldKey,
          // controller: _emailController,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context).settingsViewDisplayNameHintText,
            // errorText: _shouldShowEmailError ? AppLocalizations.of(context).signinScreenEmailErrorText : null,
          ),
          autocorrect: false,
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete_forever),
              SizedBox(width: 4),
              Text('Delete Account'),
            ],
          ),
        ),
      ],
    );
  }
}

// TODO autoDispose
final currentUserProvider = FutureProvider<User>((ref) async {
  return ServiceLocator.userManager.currentUser;
});
