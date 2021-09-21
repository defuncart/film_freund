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

  /// `Liked`
  String get activeViewLikedTitle {
    return Intl.message(
      'Liked',
      name: 'activeViewLikedTitle',
      desc: 'Title for ActiveView.liked',
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

  /// `Settings`
  String get activeViewSettingsTitle {
    return Intl.message(
      'Settings',
      name: 'activeViewSettingsTitle',
      desc: 'Title for ActiveView.settings',
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

  /// `Watchlist`
  String get activeViewWatchlistTitle {
    return Intl.message(
      'Watchlist',
      name: 'activeViewWatchlistTitle',
      desc: 'Title for ActiveView.watchlist',
      args: [],
    );
  }

  /// `Delete`
  String get deleteAccountConfirmationDialogConfirmButtonText {
    return Intl.message(
      'Delete',
      name: 'deleteAccountConfirmationDialogConfirmButtonText',
      desc: 'Confirmation text for delete account dialog',
      args: [],
    );
  }

  /// `Once your account is deleted, there is no way to get it back.`
  String get deleteAccountConfirmationDialogDescriptionText {
    return Intl.message(
      'Once your account is deleted, there is no way to get it back.',
      name: 'deleteAccountConfirmationDialogDescriptionText',
      desc: 'Description text for delete account dialog',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccountConfirmationDialogTitleText {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccountConfirmationDialogTitleText',
      desc: 'Title text for delete account dialog',
      args: [],
    );
  }

  /// `Cancel`
  String get generalCancel {
    return Intl.message(
      'Cancel',
      name: 'generalCancel',
      desc: 'Text for a general cancel action',
      args: [],
    );
  }

  /// `An error occured!`
  String get generalErrorOccured {
    return Intl.message(
      'An error occured!',
      name: 'generalErrorOccured',
      desc: 'Error text when something went wrong',
      args: [],
    );
  }

  /// `Incorrect password`
  String get generalIncorrectPassword {
    return Intl.message(
      'Incorrect password',
      name: 'generalIncorrectPassword',
      desc: 'Error text when password is incorrect',
      args: [],
    );
  }

  /// `Password must have at least six characters`
  String get generalInvalidPassword {
    return Intl.message(
      'Password must have at least six characters',
      name: 'generalInvalidPassword',
      desc: 'Error text when password is invalid',
      args: [],
    );
  }

  /// `Password`
  String get generalPasswordHint {
    return Intl.message(
      'Password',
      name: 'generalPasswordHint',
      desc: 'Hint text for password input field',
      args: [],
    );
  }

  /// `Change Password`
  String get settingsViewChangePasswordButtonText {
    return Intl.message(
      'Change Password',
      name: 'settingsViewChangePasswordButtonText',
      desc: 'Text for change password button',
      args: [],
    );
  }

  /// `Display Name`
  String get settingsViewDisplayNameHintText {
    return Intl.message(
      'Display Name',
      name: 'settingsViewDisplayNameHintText',
      desc: 'Hint text for display name input field',
      args: [],
    );
  }

  /// `Sign Out`
  String get settingsViewSignOutButtonText {
    return Intl.message(
      'Sign Out',
      name: 'settingsViewSignOutButtonText',
      desc: 'Text for sign out button',
      args: [],
    );
  }

  /// `Signed in as {email}`
  String settingsViewSignedInAsText(Object email) {
    return Intl.message(
      'Signed in as $email',
      name: 'settingsViewSignedInAsText',
      desc: 'Text to denote which email user is signed in as',
      args: [email],
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

  /// `Are you sure you want to sign out?`
  String get signOutConfirmationDialogDescriptionText {
    return Intl.message(
      'Are you sure you want to sign out?',
      name: 'signOutConfirmationDialogDescriptionText',
      desc: 'Description text for sign out dialog',
      args: [],
    );
  }

  /// `Ok`
  String get signinErrorDialogButtonText {
    return Intl.message(
      'Ok',
      name: 'signinErrorDialogButtonText',
      desc: 'Button text for signin error dialog',
      args: [],
    );
  }

  /// `Please ensure that you are connected to the internet and that the password is correct.`
  String get signinErrorDialogDescriptionText {
    return Intl.message(
      'Please ensure that you are connected to the internet and that the password is correct.',
      name: 'signinErrorDialogDescriptionText',
      desc: 'Description text for signin error dialog',
      args: [],
    );
  }

  /// `An error occured!`
  String get signinErrorDialogTitleText {
    return Intl.message(
      'An error occured!',
      name: 'signinErrorDialogTitleText',
      desc: 'Title text for signin error dialog',
      args: [],
    );
  }

  /// `Invalid email`
  String get signinScreenEmailErrorText {
    return Intl.message(
      'Invalid email',
      name: 'signinScreenEmailErrorText',
      desc: 'Text when email input is invalid',
      args: [],
    );
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

  /// `Sign In`
  String get signinScreenSigninButtonText {
    return Intl.message(
      'Sign In',
      name: 'signinScreenSigninButtonText',
      desc: 'Text for signin button',
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
