import 'package:film_freund/services/lists/enums/list_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$ListType', () {
    test('${ListType.watched}', () {
      expect(ListType.watched.isWatched, isTrue);
      expect(ListType.watched.isWatchList, isFalse);
      expect(ListType.watched.isCustom, isFalse);
    });

    test('${ListType.watchlist}', () {
      expect(ListType.watchlist.isWatched, isFalse);
      expect(ListType.watchlist.isWatchList, isTrue);
      expect(ListType.watchlist.isCustom, isFalse);
    });

    test('${ListType.custom}', () {
      expect(ListType.custom.isWatched, isFalse);
      expect(ListType.custom.isWatchList, isFalse);
      expect(ListType.custom.isCustom, isTrue);
    });
  });
}
