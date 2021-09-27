import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/services/movies/models/movie.dart';
import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:film_freund/services/user/models/user.dart';
import 'package:film_freund/widgets/my_app.dart' show routes;
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
      routes: routes,
    );

/// A test util to create model instances for testing
class TestInstance {
  TestInstance._();

  /// Returns a [User] model with given overriden parameters
  static User user({
    String? id,
    String? email,
    String? displayName,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? watched,
    List<String>? watchlist,
    List<String>? lists,
  }) =>
      User(
        id: id ?? 'id',
        email: email ?? 'email',
        displayName: displayName ?? 'displayName',
        createdAt: createdAt ?? DateTime(1),
        updatedAt: updatedAt ?? DateTime(1),
        watched: watched ?? [],
        watchlist: watchlist ?? [],
        lists: lists ?? [],
      );

  static Movie movie({
    String? backdropPath,
    int? budget,
    List<String>? genres,
    String? homepage,
    int? id,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    DateTime? releaseDate,
    int? revenue,
    int? runtime,
    String? tagline,
    String? title,
    int? voteAverage,
    int? voteCount,
  }) =>
      Movie(
        backdropPath: backdropPath ?? 'backdropPath',
        budget: budget ?? 0,
        genres: genres ?? ['genre'],
        homepage: homepage ?? 'homepage',
        id: id ?? 0,
        originalLanguage: originalLanguage ?? 'originalLanguage',
        originalTitle: originalTitle ?? 'originalTitle',
        overview: overview ?? 'overview',
        popularity: popularity ?? 0,
        posterPath: posterPath ?? 'posterPath',
        releaseDate: releaseDate ?? DateTime(1),
        revenue: revenue ?? 0,
        runtime: runtime ?? 0,
        tagline: tagline ?? 'tagline',
        title: title ?? 'title',
        voteAverage: voteAverage ?? 0,
        voteCount: voteCount ?? 0,
      );

  static MovieTeaser movieTeaser({
    String? backdropPath,
    List<String>? genres,
    int? id,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    DateTime? releaseDate,
    String? title,
    int? voteAverage,
    int? voteCount,
  }) =>
      MovieTeaser(
        backdropPath: backdropPath ?? 'backdropPath',
        genres: genres ?? ['genre'],
        id: id ?? 0,
        originalLanguage: originalLanguage ?? 'originalLanguage',
        originalTitle: originalTitle ?? 'originalTitle',
        overview: overview ?? 'overview',
        popularity: popularity ?? 0,
        posterPath: posterPath ?? 'posterPath',
        releaseDate: releaseDate ?? DateTime(1),
        title: title ?? 'title',
        voteAverage: voteAverage ?? 0,
        voteCount: voteCount ?? 0,
      );
}
