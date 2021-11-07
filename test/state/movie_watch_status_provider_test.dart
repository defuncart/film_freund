import 'package:film_freund/state/movie_watch_status_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$MovieWatchStatus', () {
    test('Ensure equality', () {
      const status1 = MovieWatchStatus(isWatched: true, isWatchlist: true);
      const status2 = MovieWatchStatus(isWatched: true, isWatchlist: true);

      expect(status1, status2);
    });
  });
}
