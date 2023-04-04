import 'package:film_freund/services/service_locator.dart';
import 'package:film_freund/utils/sizes.dart';
import 'package:film_freund/widgets/common/user/user_avatar.dart';
import 'package:film_freund/widgets/home_screen/active_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    required this.onViewChanged,
    Key? key,
  }) : super(key: key);

  final void Function(ActiveView activeView) onViewChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: [
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: UserPanelConsumer(),
          ),
          for (final element in elements)
            ListTile(
              leading: Icon(element.icon),
              title: Text(element.view.title),
              onTap: () {
                if (isSinglePage(context)) {
                  Navigator.of(context).pop();
                }
                onViewChanged(element.view);
              },
            ),
        ],
      ),
    );
  }
}

/// Displays [UserPanel] from a Provider
@visibleForTesting
class UserPanelConsumer extends ConsumerWidget {
  const UserPanelConsumer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayName = ref.watch(watchCurrentUserDisplayNameProvider);

    return displayName.when(
      loading: () => const UserPanel(
        displayName: 'Film Freund',
      ),
      error: (err, _) => Text(err.toString()),
      data: (displayName) => UserPanel(
        displayName: displayName,
      ),
    );
  }
}

/// Displays a user panel for a given user's display name
@visibleForTesting
class UserPanel extends StatelessWidget {
  const UserPanel({
    required this.displayName,
    Key? key,
  }) : super(key: key);

  final String displayName;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          UserAvatar(
            initial: displayName[0],
          ),
          const Gap(16),
          Expanded(
            child: Text(
              displayName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      );
}

@visibleForTesting
final watchCurrentUserDisplayNameProvider =
    StreamProvider.autoDispose<String>((ref) => ServiceLocator.userManager.watchCurrentUser.map(
          (user) => user?.displayName ?? '',
        ));

@visibleForTesting
const elements = [
  SidebarElement(
    icon: Icons.whatshot,
    view: ActiveView.popular,
  ),
  SidebarElement(
    icon: Icons.new_releases,
    view: ActiveView.upcoming,
  ),
  SidebarElement(
    icon: Icons.search,
    view: ActiveView.search,
  ),
  SidebarElement(
    icon: Icons.check,
    view: ActiveView.watched,
  ),
  SidebarElement(
    icon: Icons.watch_later,
    view: ActiveView.watchlist,
  ),
  SidebarElement(
    icon: Icons.list,
    view: ActiveView.lists,
  ),
  SidebarElement(
    icon: Icons.settings,
    view: ActiveView.settings,
  ),
];

@visibleForTesting
class SidebarElement {
  const SidebarElement({
    required this.icon,
    required this.view,
  });

  final IconData icon;
  final ActiveView view;
}
