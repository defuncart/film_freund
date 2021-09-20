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
        expect(user2.watched, user1.watched);
        expect(user2.watchlist, user1.watchlist);
        expect(user2.lists, user1.lists);
        expect(user1 == user2, isFalse);
      });

      test('watched', () {
        const watched = ['1'];
        final user2 = user1.copyWith(watched: watched);

        expect(user2.id, user1.id);
        expect(user2.email, user1.email);
        expect(user2.displayName, user1.displayName);
        expect(user2.createdAt, user1.createdAt);
        expect(user2.updatedAt, user1.updatedAt);
        expect(user2.watched, watched);
        expect(user2.watchlist, user1.watchlist);
        expect(user2.lists, user1.lists);
        expect(user1 == user2, isFalse);
      });

      test('watchlist', () {
        const watchlist = ['1'];
        final user2 = user1.copyWith(watchlist: watchlist);

        expect(user2.id, user1.id);
        expect(user2.email, user1.email);
        expect(user2.displayName, user1.displayName);
        expect(user2.createdAt, user1.createdAt);
        expect(user2.updatedAt, user1.updatedAt);
        expect(user2.watched, user1.watched);
        expect(user2.watchlist, watchlist);
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
        expect(user2.watched, user1.watched);
        expect(user2.watchlist, user1.watchlist);
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
      expect(user2.watched, user1.watched);
      expect(user2.watchlist, user1.watchlist);
      expect(user2.lists, user1.lists);
      expect(user1 == user2, isFalse);
    });
  });
}
