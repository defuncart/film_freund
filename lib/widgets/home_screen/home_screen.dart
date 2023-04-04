import 'dart:math';

import 'package:film_freund/services/service_locator.dart';
import 'package:film_freund/utils/sizes.dart';
import 'package:film_freund/widgets/home_screen/active_view.dart';
import 'package:film_freund/widgets/home_screen/popular/popular_view.dart';
import 'package:film_freund/widgets/home_screen/search/search_view.dart';
import 'package:film_freund/widgets/home_screen/settings/settings_view.dart';
import 'package:film_freund/widgets/home_screen/sidebar.dart';
import 'package:film_freund/widgets/home_screen/upcoming/upcoming_view.dart';
import 'package:film_freund/widgets/home_screen/watched/watched_view.dart';
import 'package:film_freund/widgets/home_screen/watchlist/watchlist_view.dart';
import 'package:film_freund/widgets/signin_screen/signin_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _activeView = ActiveView.popular;

  @override
  Widget build(BuildContext context) {
    final sidebar = Sidebar(
      onViewChanged: (activeView) => setState(() => _activeView = activeView),
    );

    return isSinglePage(context)
        ? HomeScreenDetail(
            activeView: _activeView,
            sidebar: sidebar,
          )
        : HomeScreenMasterDetail(
            activeView: _activeView,
            sidebar: sidebar,
          );
  }
}

@visibleForTesting
class HomeScreenDetail extends StatelessWidget {
  const HomeScreenDetail({
    required this.activeView,
    required this.sidebar,
    Key? key,
  }) : super(key: key);

  final ActiveView activeView;
  final Sidebar sidebar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(activeView.title),
      ),
      body: HomeScreenContent(
        activeView: activeView,
      ),
      // TODO only needed for web/desktop
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: sidebar,
      ),
      drawerEnableOpenDragGesture: false,
    );
  }
}

@visibleForTesting
class HomeScreenMasterDetail extends StatelessWidget {
  const HomeScreenMasterDetail({
    required this.activeView,
    required this.sidebar,
    Key? key,
  }) : super(key: key);

  final ActiveView activeView;
  final Sidebar sidebar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 200,
                maxWidth: min(max(200, MediaQuery.of(context).size.width * 0.25), 300),
              ),
              child: sidebar,
            ),
            const VerticalDivider(width: 2),
            Expanded(
              child: HomeScreenContent(
                activeView: activeView,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

@visibleForTesting
class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({
    required this.activeView,
    Key? key,
  }) : super(key: key);

  final ActiveView activeView;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Builder(
            builder: (_) {
              switch (activeView) {
                case ActiveView.popular:
                  return const PopularView();
                case ActiveView.upcoming:
                  return const UpcomingView();
                case ActiveView.watched:
                  return const WatchedView();
                case ActiveView.search:
                  return const SearchView();
                case ActiveView.watchlist:
                  return const WatchlistView();
                case ActiveView.settings:
                  return SettingsView(
                    onSignOutConfirmed: () {
                      ServiceLocator.userManager.signOut();
                      Navigator.of(context).pushReplacementNamed(SigninScreen.routeName);
                    },
                  );
                default:
                  return ActiveViewPlaceholder(
                    activeView: activeView,
                  );
              }
            },
          ),
        ),
      );
}

@visibleForTesting
class ActiveViewPlaceholder extends StatelessWidget {
  const ActiveViewPlaceholder({
    required this.activeView,
    Key? key,
  }) : super(key: key);

  final ActiveView activeView;

  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          activeView.title,
        ),
      );
}
