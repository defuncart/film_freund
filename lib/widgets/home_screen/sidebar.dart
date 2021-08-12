import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

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
              title: Text(element.title),
              onTap: () {
                // TODO do not pop when desktop
                Navigator.of(context).pop();
                element.onPressed?.call();
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
    title: 'Popular',
    onPressed: null,
  ),
  SidebarElement(
    icon: Icons.search,
    title: 'Search',
    onPressed: null,
  ),
  SidebarElement(
    icon: Icons.check,
    title: 'Watched',
    onPressed: null,
  ),
  SidebarElement(
    icon: Icons.favorite,
    title: 'Liked',
    onPressed: null,
  ),
  SidebarElement(
    icon: Icons.watch_later,
    title: 'Watchlist',
    onPressed: null,
  ),
  SidebarElement(
    icon: Icons.list,
    title: 'Lists',
    onPressed: null,
  ),
  SidebarElement(
    icon: Icons.settings,
    title: 'Settings',
    onPressed: null,
  ),
  SidebarElement(
    icon: Icons.logout,
    title: 'Sign Out',
    onPressed: null,
  ),
];

@visibleForTesting
class SidebarElement {
  const SidebarElement({
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onPressed;
}
