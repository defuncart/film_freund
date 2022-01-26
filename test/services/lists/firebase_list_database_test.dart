import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:film_freund/services/date_time/date_time_service.dart';
import 'package:film_freund/services/lists/enums/list_type.dart';
import 'package:film_freund/services/lists/firebase_list_database.dart';
import 'package:film_freund/services/uuid/uuid_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.dart';
import '../../test_utils.dart';

void main() {
  group('$FirebaseListDatabase', () {
    late FirebaseFirestore fakeFirebaseFirestore;
    late DateTimeService mockDateTimeService;
    late UUIDService mockUuidService;
    late FirebaseListDatabase listDatabase;

    setUp(() {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
      mockDateTimeService = MockDateTimeService();
      mockUuidService = MockUUIDService();
      listDatabase = FirebaseListDatabase(
        firebaseFirestore: fakeFirebaseFirestore,
        dateTimeService: mockDateTimeService,
        uuidService: mockUuidService,
      );
    });

    group('createList', () {
      const id = 'id';
      late ListType type;

      setUp(() {
        final now = DateTime(1);
        when(mockDateTimeService.nowUtc).thenReturn(now);
        when(mockUuidService.generate()).thenReturn(id);
      });

      group('when list is custom', () {
        setUp(() {
          type = ListType.custom;
        });

        test('when title is given, expect displayName', () async {
          const title = 'title';

          await listDatabase.createList(
            type: type,
            title: title,
          );

          final snapshot = await fakeFirebaseFirestore.collection('lists').doc(id).get();

          expect(
            snapshot.data(),
            {
              'id': 'id',
              'type': 'custom',
              'title': 'title',
              'createdAt': '0001-01-01T00:00:00.000',
              'updatedAt': '0001-01-01T00:00:00.000',
              'movies': [],
            },
          );
        });

        test('when title is not given, expect assertion', () async {
          expect(
            () => listDatabase.createList(type: type),
            throwsAssertionError,
          );
        });
      });

      group('when list is not custom', () {
        setUp(() {
          type = ListType.watched;
        });

        test('when title is given, expect displayName', () async {
          const title = 'title';

          await listDatabase.createList(
            type: type,
            title: title,
          );

          final snapshot = await fakeFirebaseFirestore.collection('lists').doc(id).get();

          expect(
            snapshot.data(),
            {
              'id': 'id',
              'type': 'watched',
              'title': 'title',
              'createdAt': '0001-01-01T00:00:00.000',
              'updatedAt': '0001-01-01T00:00:00.000',
              'movies': [],
            },
          );
        });

        test('when title is not given, expect empty string', () async {
          await listDatabase.createList(type: type);

          final snapshot = await fakeFirebaseFirestore.collection('lists').doc(id).get();

          expect(
            snapshot.data(),
            {
              'id': 'id',
              'type': 'watched',
              'title': '',
              'createdAt': '0001-01-01T00:00:00.000',
              'updatedAt': '0001-01-01T00:00:00.000',
              'movies': [],
            },
          );
        });
      });
    });

    group('getList', () {
      const id = 'id';

      test('when no list in db, expect isNull', () async {
        final list = await listDatabase.getList(id: id);
        expect(list, isNull);
      });

      test('when list data in db is empty, expect isNull', () async {
        await fakeFirebaseFirestore.collection('lists').doc(id).set({});
        final list = await listDatabase.getList(id: id);
        expect(list, isNull);
      });

      test('when list data in db is invalid, expect isNull', () async {
        await fakeFirebaseFirestore.collection('lists').doc(id).set({'bla': 'bla'});
        final list = await listDatabase.getList(id: id);
        expect(list, isNull);
      });

      test('when list in db, expect model', () async {
        await fakeFirebaseFirestore.collection('lists').doc(id).set({
          'id': 'id',
          'type': 'custom',
          'title': 'title',
          'createdAt': '0001-01-01T00:00:00.000',
          'updatedAt': '0001-01-01T00:00:00.000',
          'movies': [],
        });

        final list = await listDatabase.getList(id: id);

        expect(list, TestInstance.movieList());
      });
    });

    group('watchList', () {
      const id = 'id';

      test('when no list in db, expect isNull', () {
        final stream = listDatabase.watchList(id: id);
        expect(stream, emitsInOrder([isNull]));
      });

      test('when list in db, expect model', () async {
        await fakeFirebaseFirestore.collection('lists').doc(id).set({
          'id': 'id',
          'type': 'custom',
          'title': 'title',
          'createdAt': '0001-01-01T00:00:00.000',
          'updatedAt': '0001-01-01T00:00:00.000',
          'movies': [],
        });

        final stream = listDatabase.watchList(id: id);

        expect(stream, emitsInOrder([TestInstance.movieList()]));
      });
    });

    group('deleteList', () {
      const id = 'id';

      test('when list in db, expect removal', () async {
        await fakeFirebaseFirestore.collection('lists').doc(id).set({
          'id': 'id',
          'type': 'custom',
          'title': 'title',
          'createdAt': '0001-01-01T00:00:00.000',
          'updatedAt': '0001-01-01T00:00:00.000',
          'movies': [],
        });

        var snapshot = await fakeFirebaseFirestore.collection('lists').doc(id).get();
        expect(snapshot.exists, isTrue);

        await listDatabase.deleteList(id: id);

        snapshot = await fakeFirebaseFirestore.collection('lists').doc(id).get();
        expect(snapshot.exists, isFalse);
      });
    });

    group('addMovieToList', () {
      const listId = 'listId';
      const movieId = 1;

      setUp(() {
        final now = DateTime(2);
        when(mockDateTimeService.nowUtc).thenReturn(now);
      });

      group('when list is in db', () {
        group('and movie is not a part of list', () {
          setUp(() async {
            await fakeFirebaseFirestore.collection('lists').doc(listId).set({
              'id': 'listId',
              'type': 'custom',
              'title': 'title',
              'createdAt': '0001-01-01T00:00:00.000',
              'updatedAt': '0001-01-01T00:00:00.000',
              'movies': [],
            });
            await listDatabase.addMovieToList(listId: listId, movieId: movieId);
          });
          test('expect movie is added to list', () async {
            expect(
              (await fakeFirebaseFirestore.collection('lists').doc(listId).get()).data(),
              {
                'id': 'listId',
                'type': 'custom',
                'title': 'title',
                'createdAt': '0001-01-01T00:00:00.000',
                'updatedAt': '0002-01-01T00:00:00.000',
                'movies': [1],
              },
            );
          });
        });

        group('and movie part of list', () {
          setUp(() async {
            await fakeFirebaseFirestore.collection('lists').doc(listId).set({
              'id': 'listId',
              'type': 'custom',
              'title': 'title',
              'createdAt': '0001-01-01T00:00:00.000',
              'updatedAt': '0001-01-01T00:00:00.000',
              'movies': [1],
            });
            await listDatabase.addMovieToList(listId: listId, movieId: movieId);
          });
          test('expect movie list remains the same', () async {
            expect(
              (await fakeFirebaseFirestore.collection('lists').doc(listId).get()).data(),
              {
                'id': 'listId',
                'type': 'custom',
                'title': 'title',
                'createdAt': '0001-01-01T00:00:00.000',
                'updatedAt': '0002-01-01T00:00:00.000',
                'movies': [1],
              },
            );
          });
        });
      });

      // TODO fake_cloud_firestore creates list, real firebase throws
      group('when list is not in db', () {
        setUp(() async {
          await listDatabase.addMovieToList(listId: listId, movieId: movieId);
        });

        test('expect list is not added to db', () async {
          expect(
            (await fakeFirebaseFirestore.collection('lists').doc(listId).get()).exists,
            isFalse,
          );
        }, skip: true);
      });
    });

    group('removeMovieFromList', () {
      const listId = 'listId';
      const movieId = 1;

      setUp(() {
        final now = DateTime(2);
        when(mockDateTimeService.nowUtc).thenReturn(now);
      });

      group('when list is in db', () {
        group('and movie part of list', () {
          setUp(() async {
            await fakeFirebaseFirestore.collection('lists').doc(listId).set({
              'id': 'listId',
              'type': 'custom',
              'title': 'title',
              'createdAt': '0001-01-01T00:00:00.000',
              'updatedAt': '0001-01-01T00:00:00.000',
              'movies': [1],
            });
            await listDatabase.removeMovieFromList(listId: listId, movieId: movieId);
          });
          test('expect movie removed from list', () async {
            expect(
              (await fakeFirebaseFirestore.collection('lists').doc(listId).get()).data(),
              {
                'id': 'listId',
                'type': 'custom',
                'title': 'title',
                'createdAt': '0001-01-01T00:00:00.000',
                'updatedAt': '0002-01-01T00:00:00.000',
                'movies': [],
              },
            );
          });
        });

        group('and movie is not a part of list', () {
          setUp(() async {
            await fakeFirebaseFirestore.collection('lists').doc(listId).set({
              'id': 'listId',
              'type': 'custom',
              'title': 'title',
              'createdAt': '0001-01-01T00:00:00.000',
              'updatedAt': '0001-01-01T00:00:00.000',
              'movies': [],
            });
            await listDatabase.removeMovieFromList(listId: listId, movieId: movieId);
          });
          test('expect movie list remains the same', () async {
            expect(
              (await fakeFirebaseFirestore.collection('lists').doc(listId).get()).data(),
              {
                'id': 'listId',
                'type': 'custom',
                'title': 'title',
                'createdAt': '0001-01-01T00:00:00.000',
                'updatedAt': '0002-01-01T00:00:00.000',
                'movies': [],
              },
            );
          });
        });
      });

      // TODO fake_cloud_firestore creates list, real firebase throws
      group('when list is not in db', () {
        setUp(() async {
          await listDatabase.removeMovieFromList(listId: listId, movieId: movieId);
        });

        test('expect list is not added to db', () async {
          expect(
            (await fakeFirebaseFirestore.collection('lists').doc(listId).get()).exists,
            isFalse,
          );
        }, skip: true);
      });
    });
  });
}
