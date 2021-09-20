import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/services/user/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Wraps [widget] with in [MaterialApp]
Widget wrapWithMaterialApp(Widget widget) => MaterialApp(home: widget);

/// Wraps [widget] with in [MaterialApp] while also setting en as locale
Widget wrapWithMaterialAppLocalizationDelegates(Widget widget) => MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.delegate.supportedLocales,
      locale: const Locale('en'),
      home: widget,
    );

/// A test util to create model instances for testing
class TestInstance {
  TestInstance._();

  /// Returns a [User] model with given overriden parameters
  static User user({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? watched,
    List<String>? watchlist,
    List<String>? lists,
  }) =>
      User(
        id: id ?? 'id',
        email: email ?? 'email',
        firstName: firstName ?? 'firstName',
        lastName: lastName ?? 'lastName',
        createdAt: createdAt ?? DateTime(1),
        updatedAt: updatedAt ?? DateTime(1),
        watched: watched ?? [],
        watchlist: watchlist ?? [],
        lists: lists ?? [],
      );
}
