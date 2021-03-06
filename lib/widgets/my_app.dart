import 'package:film_freund/configs/app_themes.dart';
import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/services/service_locator.dart';
import 'package:film_freund/widgets/home_screen/home_screen.dart';
import 'package:film_freund/widgets/signin_screen/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late Future<bool> _initAppFuture;

  @override
  void initState() {
    super.initState();

    _initAppFuture = _initApp();
  }

  Future<bool> _initApp() async {
    ServiceLocator.setReader(ref.read);

    await Firebase.initializeApp();
    await ServiceLocator.localSettings.initialize();
    ServiceLocator.cacheManager.start();

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
        future: _initAppFuture,
        // ignore: avoid_types_on_closure_parameters
        builder: (_, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(
                child: CircularProgressIndicator(
                  color: AppThemes.light.colorScheme.secondary,
                ),
              );
            default:
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data == true) {
                return const MyAppContent();
              }
            //TODO else show error
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

@visibleForTesting
class MyAppContent extends StatelessWidget {
  const MyAppContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: AppThemes.light.scaffoldBackgroundColor,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        theme: AppThemes.light,
        initialRoute: ServiceLocator.userManager.isAuthenticated ? HomeScreen.routeName : SigninScreen.routeName,
        routes: routes,
      ),
    );
  }
}

@visibleForTesting
final routes = {
  HomeScreen.routeName: (_) => const HomeScreen(),
  SigninScreen.routeName: (_) => const SigninScreen(),
};
