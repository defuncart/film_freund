import 'package:equatable/equatable.dart';
import 'package:film_freund/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_transform/stream_transform.dart';

final movieWatchStatusProvider = StreamProvider.family<MovieWatchStatus, int>((ref, id) {
  final isWatched = ref.read(isMovieWatchedProvider(id).stream);
  final isWatchlist = ref.read(isMovieWatchlistProvider(id).stream);

  return isWatched.combineLatest(
    isWatchlist,
    (bool a, bool b) => MovieWatchStatus(isWatched: a, isWatchlist: b),
  );
});

@visibleForTesting
final isMovieWatchedProvider = StreamProvider.family<bool, int>((ref, id) {
  return ServiceLocator.movieManager.watchWatched.map((list) => list.movies.contains(id));
});

@visibleForTesting
final isMovieWatchlistProvider = StreamProvider.family<bool, int>((ref, id) {
  return ServiceLocator.movieManager.watchWatchlist.map((list) => list.movies.contains(id));
});

class MovieWatchStatus extends Equatable {
  const MovieWatchStatus({
    required this.isWatched,
    required this.isWatchlist,
  });

  final bool isWatched;
  final bool isWatchlist;

  @override
  List<Object?> get props => [
        isWatched,
        isWatchlist,
      ];
}
