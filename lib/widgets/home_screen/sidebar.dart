import 'package:film_freund/utils/sizes.dart';
import 'package:film_freund/widgets/home_screen/active_view.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    required this.onViewChanged,
    required this.onSignOut,
    Key? key,
  }) : super(key: key);

  final void Function(ActiveView activeView) onViewChanged;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).accentColor,
                  child: const Text(
                    'T',
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Test\nAccount',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
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
                element.onPressed?.call();
              },
            ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign Out'),
            onTap: () {
              if (isSinglePage(context)) {
                Navigator.of(context).pop();
              }
              onSignOut();
            },
          ),
        ],
      ),
    );
  }
}

@visibleForTesting
const elements = [
  SidebarElement(
    icon: Icons.whatshot,
    view: ActiveView.popular,
    onPressed: null,
  ),
  SidebarElement(
    icon: Icons.search,
    view: ActiveView.search,
    onPressed: null,
  ),
  SidebarElement(
    icon: Icons.check,
    view: ActiveView.watched,
    onPressed: null,
  ),
  SidebarElement(
    icon: Icons.favorite,
    view: ActiveView.liked,
    onPressed: null,
  ),
  SidebarElement(
    icon: Icons.watch_later,
    view: ActiveView.watchlist,
    onPressed: null,
  ),
  SidebarElement(
    icon: Icons.list,
    view: ActiveView.lists,
    onPressed: null,
  ),
  SidebarElement(
    icon: Icons.settings,
    view: ActiveView.settings,
    onPressed: null,
  ),
];

@visibleForTesting
class SidebarElement {
  const SidebarElement({
    required this.icon,
    required this.view,
    required this.onPressed,
  });

  final IconData icon;
  final ActiveView view;
  final VoidCallback? onPressed;
}
