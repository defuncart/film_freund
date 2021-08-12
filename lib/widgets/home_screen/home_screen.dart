import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/widgets/home_screen/sidebar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
