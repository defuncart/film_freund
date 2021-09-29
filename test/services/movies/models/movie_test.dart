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
  });
}
