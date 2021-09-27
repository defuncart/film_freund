import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:film_freund/services/service_locator.dart';
import 'package:film_freund/widgets/common/movie/movie_teasers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpcomingView extends ConsumerWidget {
  const UpcomingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(upcomingMoviesProvider);

    return movies.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (movies) => MovieTeasers(
        movieTeasers: movies,
      ),
    );
  }
}

final upcomingMoviesProvider = FutureProvider.autoDispose<List<MovieTeaser>>(
  (ref) => ServiceLocator.movieDatabase.getUpcoming(),
);
