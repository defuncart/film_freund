import 'package:film_freund/services/lists/enums/list_type.dart';
import 'package:film_freund/services/lists/models/movie_list.dart';

/// A Database for [MovieList]
abstract class IListDatabase {
  /// Creates a list with [type] and [title], and retuns MovieList.id
  Future<String> createList({
    required ListType type,
    String? title,
  });

  /// Returns a list with [id]. If no such user exists, null is returned.
  Future<MovieList?> getList({required String id});

  /// Watches a list with [id]. If no such user exists, null is returned.
  Stream<MovieList?> watchList({required String id});

  /// Deletes a list by [id]
  ///
  /// Note that if no such list exists, no warning is returned.
  Future<void> deleteList({required String id});

  /// Adds [movieId] to list [listId]
  ///
  /// Note that if [listId] already contains [movieId], no warning is returned.
  Future<void> addMovieToList({
    required String listId,
    required int movieId,
  });

  /// Removes [movieId] from list [listId]
  ///
  /// Note that if [listId] doesn't contains [movieId], no warning is returned.
  Future<void> removeMovieFromList({
    required String listId,
    required int movieId,
  });
}
