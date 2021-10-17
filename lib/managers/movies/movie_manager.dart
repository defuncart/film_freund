import 'package:film_freund/managers/cache/cache_manager.dart';
import 'package:film_freund/services/lists/i_list_database.dart';
import 'package:film_freund/services/lists/models/movie_list.dart';
import 'package:film_freund/services/local_settings/i_local_settings_database.dart';
import 'package:film_freund/services/local_settings/region.dart';
import 'package:film_freund/services/movies/i_movie_database.dart';
import 'package:film_freund/services/movies/models/movie.dart';
import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:flutter/material.dart';

/// A manager which handles movie database requests and updating user's movie lists
class MovieManager {
  const MovieManager({
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

  /// Returns the current user's watched movies
  Future<List<Movie>> get watchedMovies async {
    final watchedId = _cacheManager.watchedId;
    final list = await _listDatabase.getList(id: watchedId);

    if (list != null) {
      return _movieDatabase.getMovies(list.movies);
    }

    throw ArgumentError('No list $watchedId for current user');
  }

  /// Returns the current user's watchlist movies
  Future<List<Movie>> get watchlistMovies async {
    final watchlistId = _cacheManager.watchlistId;
    final list = await _listDatabase.getList(id: watchlistId);

    if (list != null) {
      return _movieDatabase.getMovies(list.movies);
    }

    throw ArgumentError('No list $watchlistId for current user');
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
