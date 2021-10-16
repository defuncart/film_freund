import 'dart:convert';

import 'package:film_freund/services/user/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utils.dart';

void main() {
  group('$User', () {
    test('Ensure equality', () {
      final user1 = TestInstance.user();
      final user2 = TestInstance.user();

      expect(user1, user2);
      expect(user1 == user2, isTrue);
    });

    group('copyWith', () {
      final user1 = TestInstance.user();

      test('displayName', () {
        const displayName = 'Max';
        final user2 = user1.copyWith(displayName: displayName);

        expect(user2.id, user1.id);
        expect(user2.email, user1.email);
        expect(user2.displayName, displayName);
        expect(user2.createdAt, user1.createdAt);
        expect(user2.updatedAt, user1.updatedAt);
        expect(user2.watchedId, user1.watchedId);
        expect(user2.watchlistId, user1.watchlistId);
        expect(user2.lists, user1.lists);
        expect(user1 == user2, isFalse);
      });

      test('lists', () {
        const lists = ['1'];
        final user2 = user1.copyWith(lists: lists);

        expect(user2.id, user1.id);
        expect(user2.email, user1.email);
        expect(user2.displayName, user1.displayName);
        expect(user2.createdAt, user1.createdAt);
        expect(user2.updatedAt, user1.updatedAt);
        expect(user2.watchedId, user1.watchedId);
        expect(user2.watchlistId, user1.watchlistId);
        expect(user2.lists, lists);
        expect(user1 == user2, isFalse);
      });
    });

    test('setUpdatedAt', () {
      final updatedAt = DateTime(2021);
      final user1 = TestInstance.user();
      final user2 = user1.setUpdatedAt(updatedAt);

      expect(user2.id, user1.id);
      expect(user2.email, user1.email);
      expect(user2.displayName, user1.displayName);
      expect(user2.createdAt, user1.createdAt);
      expect(user2.updatedAt, updatedAt);
      expect(user2.watchedId, user1.watchedId);
      expect(user2.watchlistId, user1.watchlistId);
      expect(user2.lists, user1.lists);
      expect(user1 == user2, isFalse);
    });

    group('Serialization', () {
      final expectedUser = TestInstance.user(
        id: 'id',
        email: 'max@test.de',
        displayName: 'max',
        createdAt: DateTime.utc(2021),
        updatedAt: DateTime.utc(2021, 2),
        watchedId: 'id1',
        watchlistId: 'id2',
        lists: ['id3'],
      );

      const jsonString = '''
{
  "id": "id",
  "email": "max@test.de",
  "displayName": "max",
  "createdAt": "2021-01-01T00:00:00.000Z",
  "updatedAt": "2021-02-01T00:00:00.000Z",
  "watchedId": "id1",
  "watchlistId": "id2",
  "lists": [
    "id3"
  ]
}
''';
      final expectedJson = jsonDecode(jsonString);

      test('fromJson', () {
        expect(User.fromJson(expectedJson), expectedUser);
      });

      test('toJson', () {
        expect(expectedUser.toJson(), expectedJson);
      });
    });
  });
}
