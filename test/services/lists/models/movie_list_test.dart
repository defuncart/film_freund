import 'dart:convert';

import 'package:film_freund/services/lists/enums/list_type.dart';
import 'package:film_freund/services/lists/models/movie_list.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utils.dart';

void main() {
  group('$MovieList', () {
    test('Ensure equality', () {
      final list1 = TestInstance.movieList();
      final list2 = TestInstance.movieList();

      expect(list1, list2);
      expect(list1 == list2, isTrue);
    });

    group('Serialization', () {
      final expectedModel = TestInstance.movieList(
        id: 'id',
        type: ListType.custom,
        title: 'title',
        movies: [
          1,
        ],
        createdAt: DateTime.utc(2021),
        updatedAt: DateTime.utc(2021, 2),
      );

      const jsonString = '''
{
  "id": "id",
  "type": "custom",
  "title": "title",
  "movies": [
    1
  ],
  "createdAt": "2021-01-01T00:00:00.000Z",
  "updatedAt": "2021-02-01T00:00:00.000Z"
}
''';
      final expectedJson = jsonDecode(jsonString);

      test('fromJson', () {
        expect(MovieList.fromJson(expectedJson), expectedModel);
      });

      test('toJson', () {
        expect(expectedModel.toJson(), expectedJson);
      });
    });
  });
}
