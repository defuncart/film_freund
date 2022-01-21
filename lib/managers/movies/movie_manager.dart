import 'dart:async';

import 'package:film_freund/extensions/movie_extensions.dart';
import 'package:film_freund/managers/cache/cache_manager.dart';
import 'package:film_freund/services/lists/i_list_database.dart';
import 'package:film_freund/services/lists/models/movie_list.dart';
import 'package:film_freund/services/local_settings/i_local_settings_database.dart';
import 'package:film_freund/services/local_settings/region.dart';
import 'package:film_freund/services/movies/i_movie_database.dart';
import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:flutter/material.dart';

/// A manager which handles movie database requests and updating user's movie lists
class MovieManager {
  MovieManager({
    required IMovieDatabase movieDatabase,
    required ILocalSettingsDatabase localSettings,
    required IListDatabase listDatabase,
    required CacheManager cacheManager,
  })  : _movieDatabase = movieDatabase,
        _localSettings = localSettings,
        _listDatabase = listDatabase,
        _cacheManager = cacheManager;

  final IMovieDatabase _movieDatabase;
  final ILocalSettingsDatabase _localSettings;
  final IListDatabase _listDatabase;
  final CacheManager _cacheManager;

  /// Returns a list of the 20 most popular movies
  Future<List<MovieTeaser>> getPopular() => _movieDatabase.getPopular(
        region: _localSettings.region.countryCode,
      );

  /// Returns a list of upcoming movies
  Future<List<MovieTeaser>> getUpcoming() => _movieDatabase.getUpcoming(
        region: _localSettings.region.countryCode,
      );

  /// Returns a list of upcoming movies
  Future<List<MovieTeaser>> searchMovies(String searchTerm) => _movieDatabase.searchMovies(
        searchTerm: searchTerm,
        region: _localSettings.region.countryCode,
      );

  StreamController<List<MovieTeaser>>? _watchedMoviesController;
  StreamSubscription<MovieList>? _watchWatchedSubscription;

  /// Returns a steam of the current user's watched movies (ordered by last added)
  Stream<List<MovieTeaser>> get watchedMovies {
    _watchWatchedSubscription?.cancel();
    _watchedMoviesController?.close();
    _watchedMoviesController = StreamController<List<MovieTeaser>>();
    _watchWatchedSubscription = watchWatched.listen((list) {
      _movieDatabase
          .getMovies(list.movies)
          .then((movies) => _watchedMoviesController!.add(movies.reversed.toList().toMovieTeasers()));
    });

    return _watchedMoviesController!.stream;
  }

  StreamController<List<MovieTeaser>>? _watchlistMoviesController;
  StreamSubscription<MovieList>? _watchWatchlistSubscription;

  /// Returns a steam of the current user's watchlist movies (ordered by last added)
  Stream<List<MovieTeaser>> get watchlistMovies {
    _watchlistMoviesController?.close();
    _watchlistMoviesController = StreamController<List<MovieTeaser>>();
    _watchWatchlistSubscription?.cancel();
    _watchWatchlistSubscription = watchWatchlist.listen((list) {
      _movieDatabase
          .getMovies(list.movies)
          .then((movies) => _watchlistMoviesController!.add(movies.reversed.toList().toMovieTeasers()));
    });

    return _watchlistMoviesController!.stream;
  }

  /// Watches the user's watched list for changes
  Stream<MovieList> get watchWatched {
    final watchedId = _cacheManager.watchedId;
    return _listDatabase.watchList(id: watchedId).map(returnListOrThrow);
  }

  /// Watches the user's watchlist list for changes
  Stream<MovieList> get watchWatchlist {
    final watchlistId = _cacheManager.watchlistId;
    return _listDatabase.watchList(id: watchlistId).map(returnListOrThrow);
  }

  @visibleForTesting
  MovieList returnListOrThrow(MovieList? list) {
    if (list != null) {
      return list;
    }

    throw ArgumentError('list not found for current user');
  }

  /// Adds [movieId] to the current user's watched movies
  Future<void> addWatchedMovie(int movieId) async {
    final watchedId = _cacheManager.watchedId;
    await _listDatabase.addMovieToList(listId: watchedId, movieId: movieId);

    // in case the movie is on the watchlist, remove it
    await removeWatchlistMovie(movieId);
  }

  /// Removes [movieId] from the current user's watched movies
  Future<void> removeWatchedMovie(int movieId) async {
    final watchedId = _cacheManager.watchedId;
    await _listDatabase.removeMovieFromList(listId: watchedId, movieId: movieId);
  }

  /// Adds [movieId] to the current user's watchlist movies
  Future<void> addWatchlistMovie(int movieId) async {
    final watchlistId = _cacheManager.watchlistId;
    await _listDatabase.addMovieToList(listId: watchlistId, movieId: movieId);
  }

  /// Removes [movieId] from the current user's watchlist movies
  Future<void> removeWatchlistMovie(int movieId) async {
    final watchlistId = _cacheManager.watchlistId;
    await _listDatabase.removeMovieFromList(listId: watchlistId, movieId: movieId);
  }
}
