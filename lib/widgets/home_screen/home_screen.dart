import 'dart:math';

import 'package:film_freund/services/service_locator.dart';
import 'package:film_freund/utils/sizes.dart';
import 'package:film_freund/widgets/home_screen/active_view.dart';
import 'package:film_freund/widgets/home_screen/settings/settings_view.dart';
import 'package:film_freund/widgets/home_screen/sidebar.dart';
import 'package:film_freund/widgets/signin_screen/signin_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
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
      body: HomePageContent(
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: HomePageContent(
                  activeView: activeView,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

@visibleForTesting
class HomePageContent extends StatelessWidget {
  const HomePageContent({
    required this.activeView,
    Key? key,
  }) : super(key: key);

  final ActiveView activeView;

  @override
  Widget build(BuildContext context) {
    switch (activeView) {
      case ActiveView.settings:
        return SettingsView(
          onSignOutConfirmed: () {
            ServiceLocator.userManager.signout();
            Navigator.of(context).pushReplacementNamed(SigninScreen.routeName);
          },
        );
      default:
        return Center(
          child: Text(
            activeView.title,
          ),
        );
    }
  }
}
