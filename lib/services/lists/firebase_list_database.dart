import 'dart:developer' show log;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:film_freund/services/date_time/date_time_service.dart';
import 'package:film_freund/services/lists/enums/list_type.dart';
import 'package:film_freund/services/lists/i_list_database.dart';
import 'package:film_freund/services/lists/models/movie_list.dart';
import 'package:film_freund/services/uuid/uuid_service.dart';

class FirebaseListDatabase implements IListDatabase {
  FirebaseListDatabase({
    FirebaseFirestore? firebaseFirestore,
    required DateTimeService dateTimeService,
    required UUIDService uuidService,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _dateTimeService = dateTimeService,
        _uuidService = uuidService;

  final FirebaseFirestore _firebaseFirestore;
  final DateTimeService _dateTimeService;
  final UUIDService _uuidService;

  static const _collection = 'lists';

  @override
  Future<String> createList({
    required ListType type,
    String? title,
  }) async {
    if (type.isCustom) {
      assert(title != null);
    }

    final now = _dateTimeService.nowUtc;
    final list = MovieList(
      id: _uuidService.generate(),
      type: type,
      // TODO decide if watched, watchlist need a title
      title: title ?? '',
      movies: const [],
      createdAt: now,
      updatedAt: now,
    );

    await _firebaseFirestore.collection(_collection).doc(list.id).set(list.toJson());

    log('FirebaseListDatabase create list $list');

    return list.id;
  }

  /// Maps [DocumentSnapshot] to [MovieList]
  MovieList? _snapshotToMovieList(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.exists && snapshot.data() != null) {
      try {
        return MovieList.fromJson(snapshot.data()!);
      } catch (_) {}
    }

    return null;
  }

  @override
  Future<MovieList?> getList({required String id}) async {
    final snapshot = await _firebaseFirestore.collection(_collection).doc(id).get();
    return _snapshotToMovieList(snapshot);
  }

  @override
  Stream<MovieList?> watchList({required String id}) =>
      _firebaseFirestore.collection(_collection).doc(id).snapshots().map(_snapshotToMovieList);

  @override
  Future<void> deleteList({required String id}) async {
    await _firebaseFirestore.collection(_collection).doc(id).delete();

    log('FirebaseListDatabase create list $id');
  }

  @override
  Future<void> addMovieToList({
    required String listId,
    required int movieId,
  }) async {
    try {
      await _firebaseFirestore.collection(_collection).doc(listId).update({
        'movies': FieldValue.arrayUnion([movieId]),
        'updatedAt': _dateTimeService.nowUtc.toIso8601String(),
      });

      log('FirebaseListDatabase add movie $movieId to list $listId');
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> removeMovieFromList({
    required String listId,
    required int movieId,
  }) async {
    try {
      await _firebaseFirestore.collection(_collection).doc(listId).update({
        'movies': FieldValue.arrayRemove([movieId]),
        'updatedAt': _dateTimeService.nowUtc.toIso8601String(),
      });

      log('FirebaseListDatabase remove movie $movieId from list $listId');
    } catch (e) {
      log(e.toString());
    }
  }
}
