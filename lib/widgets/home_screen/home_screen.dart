import 'dart:math';

import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/utils/sizes.dart';
import 'package:film_freund/widgets/home_screen/sidebar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isMobile(context)
        ? Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text(AppLocalizations.of(context).test),
            ),
            // TODO only needed for web/desktop
            drawer: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: const Sidebar(),
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
                    child: const Sidebar(),
                  ),
                  const VerticalDivider(width: 2),
                  Expanded(
                    child: Center(
                      child: Text(AppLocalizations.of(context).test),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
