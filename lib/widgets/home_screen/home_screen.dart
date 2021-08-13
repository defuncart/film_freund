import 'dart:math';

import 'package:film_freund/utils/sizes.dart';
import 'package:film_freund/widgets/home_screen/active_view.dart';
import 'package:film_freund/widgets/home_screen/sidebar.dart';
import 'package:film_freund/widgets/home_screen/sign_out_confirmation_dialog.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
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
      onSignOut: () => showDialog(
        context: context,
        builder: (_) => SignOutConfirmationDialog(
          onConfirm: () {},
        ),
      ),
    );

    final content = HomePageContent(
      activeView: _activeView,
    );

    return isSinglePage(context)
        ? Scaffold(
            appBar: AppBar(
              title: Text(_activeView.title),
            ),
            body: content,
            // TODO only needed for web/desktop
            drawer: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: sidebar,
            ),
            drawerEnableOpenDragGesture: false,
          )
        : Scaffold(
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
                    child: content,
                  ),
                ],
              ),
            ),
          );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({
    required this.activeView,
    Key? key,
  }) : super(key: key);

  final ActiveView activeView;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        activeView.title,
      ),
    );
  }
}
