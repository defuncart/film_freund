// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes
// ignore_for_file: always_use_package_imports

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(_current != null,
        'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Email`
  String get signinScreenEmailHintText {
    return Intl.message(
      'Email',
      name: 'signinScreenEmailHintText',
      desc: 'Hint text for email input field',
      args: [],
    );
  }

  /// `Password`
  String get signinScreenPasswordHintText {
    return Intl.message(
      'Password',
      name: 'signinScreenPasswordHintText',
      desc: 'Hint text for password input field',
      args: [],
    );
  }

  /// `Sign In`
  String get signinScreenSigninButtonText {
    return Intl.message(
      'Sign In',
      name: 'signinScreenSigninButtonText',
      desc: 'Text for signin button',
      args: [],
    );
  }

  /// `Popular`
  String get activeViewPopularTitle {
    return Intl.message(
      'Popular',
      name: 'activeViewPopularTitle',
      desc: 'Title for ActiveView.popular',
      args: [],
    );
  }

  /// `Search`
  String get activeViewSearchTitle {
    return Intl.message(
      'Search',
      name: 'activeViewSearchTitle',
      desc: 'Title for ActiveView.search',
      args: [],
    );
  }

  /// `Watched`
  String get activeViewWatchedTitle {
    return Intl.message(
      'Watched',
      name: 'activeViewWatchedTitle',
      desc: 'Title for ActiveView.watched',
      args: [],
    );
  }

  /// `Liked`
  String get activeViewLikedTitle {
    return Intl.message(
      'Liked',
      name: 'activeViewLikedTitle',
      desc: 'Title for ActiveView.liked',
      args: [],
    );
  }

  /// `Watchlist`
  String get activeViewWatchlistTitle {
    return Intl.message(
      'Watchlist',
      name: 'activeViewWatchlistTitle',
      desc: 'Title for ActiveView.watchlist',
      args: [],
    );
  }

  /// `Lists`
  String get activeViewListsTitle {
    return Intl.message(
      'Lists',
      name: 'activeViewListsTitle',
      desc: 'Title for ActiveView.lists',
      args: [],
    );
  }

  /// `Settings`
  String get activeViewSettingsTitle {
    return Intl.message(
      'Settings',
      name: 'activeViewSettingsTitle',
      desc: 'Title for ActiveView.settings',
      args: [],
    );
  }

  /// `Sign Out`
  String get sidebarSignOutButtonText {
    return Intl.message(
      'Sign Out',
      name: 'sidebarSignOutButtonText',
      desc: 'Text for sign out button',
      args: [],
    );
  }

  /// `Are you sure you want to sign out?`
  String get signOutConfirmationDialogDescriptionText {
    return Intl.message(
      'Are you sure you want to sign out?',
      name: 'signOutConfirmationDialogDescriptionText',
      desc: 'Description text for sign out dialog',
      args: [],
    );
  }

  /// `Cancel`
  String get signOutConfirmationDialogCancelButtonText {
    return Intl.message(
      'Cancel',
      name: 'signOutConfirmationDialogCancelButtonText',
      desc: 'Cancel text for sign out dialog',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOutConfirmationDialogConfirmButtonText {
    return Intl.message(
      'Sign Out',
      name: 'signOutConfirmationDialogConfirmButtonText',
      desc: 'Confirmation text for sign out dialog',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
