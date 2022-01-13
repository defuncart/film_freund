import 'package:film_freund/services/movies/models/movie.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utils.dart';

void main() {
  group('$Movie', () {
    test('Expect toString is overridden', () {
      expect(
        TestInstance.movie().toString(),
        isNot('Instance of \'$Movie\''),
      );
    });

    test('Expect equality', () {
      final movie1 = TestInstance.movie();
      final movie2 = TestInstance.movie();

      expect(movie1, movie2);
    });
  });
}
