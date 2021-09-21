// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(email) => "Signed in as ${email}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "activeViewLikedTitle": MessageLookupByLibrary.simpleMessage("Liked"),
        "activeViewListsTitle": MessageLookupByLibrary.simpleMessage("Lists"),
        "activeViewPopularTitle":
            MessageLookupByLibrary.simpleMessage("Popular"),
        "activeViewSearchTitle": MessageLookupByLibrary.simpleMessage("Search"),
        "activeViewSettingsTitle":
            MessageLookupByLibrary.simpleMessage("Settings"),
        "activeViewWatchedTitle":
            MessageLookupByLibrary.simpleMessage("Watched"),
        "activeViewWatchlistTitle":
            MessageLookupByLibrary.simpleMessage("Watchlist"),
        "deleteAccountConfirmationDialogCancelButtonText":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "deleteAccountConfirmationDialogConfirmButtonText":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteAccountConfirmationDialogDescriptionText":
            MessageLookupByLibrary.simpleMessage(
                "Once your account is deleted, there is no way to get it back."),
        "deleteAccountConfirmationDialogTitleText":
            MessageLookupByLibrary.simpleMessage("Delete Account"),
        "generalErrorOccured":
            MessageLookupByLibrary.simpleMessage("An error occured!"),
        "generalIncorrectPassword":
            MessageLookupByLibrary.simpleMessage("Incorrect password"),
        "generalInvalidPassword": MessageLookupByLibrary.simpleMessage(
            "Password must have at least six characters"),
        "generalPasswordHintText":
            MessageLookupByLibrary.simpleMessage("Password"),
        "settingsViewChangePasswordButtonText":
            MessageLookupByLibrary.simpleMessage("Change Password"),
        "settingsViewDisplayNameHintText":
            MessageLookupByLibrary.simpleMessage("Display Name"),
        "settingsViewSignOutButtonText":
            MessageLookupByLibrary.simpleMessage("Sign Out"),
        "settingsViewSignedInAsText": m0,
        "signOutConfirmationDialogCancelButtonText":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "signOutConfirmationDialogConfirmButtonText":
            MessageLookupByLibrary.simpleMessage("Sign Out"),
        "signOutConfirmationDialogDescriptionText":
            MessageLookupByLibrary.simpleMessage(
                "Are you sure you want to sign out?"),
        "signinErrorDialogButtonText":
            MessageLookupByLibrary.simpleMessage("Ok"),
        "signinErrorDialogDescriptionText": MessageLookupByLibrary.simpleMessage(
            "Please ensure that you are connected to the internet and that the password is correct."),
        "signinErrorDialogTitleText":
            MessageLookupByLibrary.simpleMessage("An error occured!"),
        "signinScreenEmailErrorText":
            MessageLookupByLibrary.simpleMessage("Invalid email"),
        "signinScreenEmailHintText":
            MessageLookupByLibrary.simpleMessage("Email"),
        "signinScreenPasswordErrorText": MessageLookupByLibrary.simpleMessage(
            "Password must have at least six characters"),
        "signinScreenPasswordHintText":
            MessageLookupByLibrary.simpleMessage("Password"),
        "signinScreenSigninButtonText":
            MessageLookupByLibrary.simpleMessage("Sign In")
      };
}
