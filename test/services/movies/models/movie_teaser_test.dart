import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utils.dart';

void main() {
  group('$MovieTeaser', () {
    test('Expect toString is overridden', () {
      expect(
        TestInstance.movieTeaser().toString(),
        isNot('Instance of \'$MovieTeaser\''),
      );
    });

    test('Expect equality', () {
      final movieTeaser1 = TestInstance.movieTeaser();
      final movieTeaser2 = TestInstance.movieTeaser();

      expect(movieTeaser1, movieTeaser2);
    });
  });
}
