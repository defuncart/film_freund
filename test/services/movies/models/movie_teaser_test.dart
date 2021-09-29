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
  });
}
