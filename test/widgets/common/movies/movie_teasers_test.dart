import 'package:film_freund/widgets/common/movie/movie_teaser_card.dart';
import 'package:film_freund/widgets/common/movie/movie_teasers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../test_utils.dart';

void main() {
  final movieTeasers = [
    TestInstance.movieTeaser(id: 1, title: 'title1'),
    TestInstance.movieTeaser(id: 2, title: 'title2'),
  ];

  testWidgets('ensure widget tree is correct', (tester) async {
    mockNetworkImagesFor(() async {
      final widget = wrapWithMaterialApp(
        MovieTeasers(
          movieTeasers: movieTeasers,
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.byType(MovieTeasers), findsOneWidget);
      expect(find.byType(MovieTeaserCard), findsNWidgets(movieTeasers.length));
    });
  });
}
