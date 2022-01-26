import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:film_freund/services/date_time/date_time_service.dart';
import 'package:film_freund/services/user/firebase_user_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.dart';
import '../../test_utils.dart';

void main() {
  group('$FirebaseUserDatabase', () {
    late FirebaseFirestore fakeFirebaseFirestore;
    late DateTimeService mockDateTimeService;
    late FirebaseUserDatabase userDatabase;

    setUp(() {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
      mockDateTimeService = MockDateTimeService();
      userDatabase = FirebaseUserDatabase(
        firebaseFirestore: fakeFirebaseFirestore,
        dateTimeService: mockDateTimeService,
      );
    });

    group('createUser', () {
      const id = 'id';
      const email = 'email@bla.dev';
      const displayName = 'displayName';
      const watchedId = 'watchedId';
      const watchlistId = 'watchlistId';

      setUp(() {
        final now = DateTime(1);
        when(mockDateTimeService.nowUtc).thenReturn(now);
      });

      test('when displayName is given, expect displayName', () async {
        await userDatabase.createUser(
          id: id,
          email: email,
          displayName: displayName,
          watchedId: watchedId,
          watchlistId: watchlistId,
        );

        final snapshot = await fakeFirebaseFirestore.collection('users').doc(id).get();

        expect(
          snapshot.data(),
          {
            'id': 'id',
            'email': 'email@bla.dev',
            'displayName': 'displayName',
            'createdAt': '0001-01-01T00:00:00.000',
            'updatedAt': '0001-01-01T00:00:00.000',
            'watchedId': 'watchedId',
            'watchlistId': 'watchlistId',
            'lists': [],
          },
        );
      });

      test('when displayName is not given, expect text before @', () async {
        await userDatabase.createUser(
          id: id,
          email: email,
          watchedId: watchedId,
          watchlistId: watchlistId,
        );

        final snapshot = await fakeFirebaseFirestore.collection('users').doc(id).get();

        expect(
          snapshot.data(),
          {
            'id': 'id',
            'email': 'email@bla.dev',
            'displayName': 'email',
            'createdAt': '0001-01-01T00:00:00.000',
            'updatedAt': '0001-01-01T00:00:00.000',
            'watchedId': 'watchedId',
            'watchlistId': 'watchlistId',
            'lists': [],
          },
        );
      });
    });

    group('getUser', () {
      const id = 'id';

      test('when no user in db, expect isNull', () async {
        final user = await userDatabase.getUser(id: id);
        expect(user, isNull);
      });

      test('when user data in db is empty, expect isNull', () async {
        await fakeFirebaseFirestore.collection('users').doc(id).set({});
        final user = await userDatabase.getUser(id: id);
        expect(user, isNull);
      });

      test('when user data in db is invalid, expect isNull', () async {
        await fakeFirebaseFirestore.collection('users').doc(id).set({'bla': 'bla'});
        final user = await userDatabase.getUser(id: id);
        expect(user, isNull);
      });

      test('when user in db, expect model', () async {
        await fakeFirebaseFirestore.collection('users').doc(id).set({
          'id': 'id',
          'email': 'email',
          'displayName': 'displayName',
          'createdAt': '0001-01-01T00:00:00.000',
          'updatedAt': '0001-01-01T00:00:00.000',
          'watchedId': 'watchedId',
          'watchlistId': 'watchlistId',
          'lists': [],
        });

        final user = await userDatabase.getUser(id: id);

        expect(user, TestInstance.user());
      });
    });

    group('watchUser', () {
      const id = 'id';

      test('when no user in db, expect isNull', () {
        final stream = userDatabase.watchUser(id: id);
        expect(stream, emitsInOrder([isNull]));
      });

      test('when user in db, expect model', () async {
        await fakeFirebaseFirestore.collection('users').doc(id).set({
          'id': 'id',
          'email': 'email',
          'displayName': 'displayName',
          'createdAt': '0001-01-01T00:00:00.000',
          'updatedAt': '0001-01-01T00:00:00.000',
          'watchedId': 'watchedId',
          'watchlistId': 'watchlistId',
          'lists': [],
        });

        final stream = userDatabase.watchUser(id: id);

        expect(stream, emitsInOrder([TestInstance.user()]));
      });
    });

    group('updateUser', () {
      const id = 'id';

      final now = DateTime(2);

      group('when user is in db', () {
        setUp(() async {
          await fakeFirebaseFirestore.collection('users').doc(id).set({
            'id': 'id',
            'email': 'email',
            'displayName': 'displayName',
            'createdAt': '0001-01-01T00:00:00.000',
            'updatedAt': '0001-01-01T00:00:00.000',
            'watchedId': 'watchedId',
            'watchlistId': 'watchlistId',
            'lists': [],
          });
        });

        group('and neither displayName nor lists are different', () {
          setUp(() async {
            await userDatabase.updateUser(
              user: TestInstance.user(),
              displayName: null,
              lists: null,
            );
          });

          test('expect that nothing happens', () async {
            expect(
              (await fakeFirebaseFirestore.collection('users').doc(id).get()).data(),
              {
                'id': 'id',
                'email': 'email',
                'displayName': 'displayName',
                'createdAt': '0001-01-01T00:00:00.000',
                'updatedAt': '0001-01-01T00:00:00.000',
                'watchedId': 'watchedId',
                'watchlistId': 'watchlistId',
                'lists': [],
              },
            );
          });
        });

        group('and displayName is updated', () {
          setUp(() async {
            when(mockDateTimeService.nowUtc).thenReturn(now);
            await userDatabase.updateUser(
              user: TestInstance.user(),
              displayName: 'newDisplayName',
            );
          });

          test('expect db is updated', () async {
            expect(
              (await fakeFirebaseFirestore.collection('users').doc(id).get()).data(),
              {
                'id': 'id',
                'email': 'email',
                'displayName': 'newDisplayName',
                'createdAt': '0001-01-01T00:00:00.000',
                'updatedAt': '0002-01-01T00:00:00.000',
                'watchedId': 'watchedId',
                'watchlistId': 'watchlistId',
                'lists': [],
              },
            );
          });
        });

        group('and lists is updated', () {
          setUp(() async {
            when(mockDateTimeService.nowUtc).thenReturn(now);
            await userDatabase.updateUser(
              user: TestInstance.user(),
              lists: ['a'],
            );
          });

          test('expect db is updated', () async {
            expect(
              (await fakeFirebaseFirestore.collection('users').doc(id).get()).data(),
              {
                'id': 'id',
                'email': 'email',
                'displayName': 'displayName',
                'createdAt': '0001-01-01T00:00:00.000',
                'updatedAt': '0002-01-01T00:00:00.000',
                'watchedId': 'watchedId',
                'watchlistId': 'watchlistId',
                'lists': ['a'],
              },
            );
          });
        });
      });

      group('when user is not in db', () {
        group('and neither displayName nor lists are different', () {
          setUp(() async {
            await userDatabase.updateUser(
              user: TestInstance.user(),
              displayName: null,
              lists: null,
            );
          });

          test('expect that nothing happens', () async {
            expect(
              (await fakeFirebaseFirestore.collection('users').doc(id).get()).exists,
              isFalse,
            );
          });
        });

        group('and displayName is updated', () {
          setUp(() async {
            when(mockDateTimeService.nowUtc).thenReturn(now);
            await userDatabase.updateUser(
              user: TestInstance.user(),
              displayName: 'newDisplayName',
            );
          });

          test('expect db is updated', () async {
            final snapshot = await fakeFirebaseFirestore.collection('users').doc(id).get();
            expect(snapshot.exists, isTrue);
            expect(
              snapshot.data(),
              {
                'id': 'id',
                'email': 'email',
                'displayName': 'newDisplayName',
                'createdAt': '0001-01-01T00:00:00.000',
                'updatedAt': '0002-01-01T00:00:00.000',
                'watchedId': 'watchedId',
                'watchlistId': 'watchlistId',
                'lists': [],
              },
            );
          });
        });

        group('and lists is updated', () {
          setUp(() async {
            when(mockDateTimeService.nowUtc).thenReturn(now);
            await userDatabase.updateUser(
              user: TestInstance.user(),
              lists: ['a'],
            );
          });

          test('expect db is updated', () async {
            final snapshot = await fakeFirebaseFirestore.collection('users').doc(id).get();
            expect(snapshot.exists, isTrue);
            expect(
              snapshot.data(),
              {
                'id': 'id',
                'email': 'email',
                'displayName': 'displayName',
                'createdAt': '0001-01-01T00:00:00.000',
                'updatedAt': '0002-01-01T00:00:00.000',
                'watchedId': 'watchedId',
                'watchlistId': 'watchlistId',
                'lists': ['a'],
              },
            );
          });
        });
      });
    });

    group('deleteUser', () {
      const id = 'id';

      test('when user in db, expect removal', () async {
        await fakeFirebaseFirestore.collection('users').doc(id).set({
          'id': 'id',
          'email': 'email',
          'displayName': 'displayName',
          'createdAt': '0001-01-01T00:00:00.000',
          'updatedAt': '0001-01-01T00:00:00.000',
          'watchedId': 'watchedId',
          'watchlistId': 'watchlistId',
          'lists': [],
        });

        var snapshot = await fakeFirebaseFirestore.collection('users').doc(id).get();
        expect(snapshot.exists, isTrue);

        await userDatabase.deleteUser(id: id);

        snapshot = await fakeFirebaseFirestore.collection('users').doc(id).get();
        expect(snapshot.exists, isFalse);
      });
    });
  });
}
