import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:film_freund/services/service_locator.dart';
import 'package:film_freund/widgets/common/movie/movie_teasers_stream_consumer.dart';
import 'package:film_freund/widgets/home_screen/active_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget for [ActiveView.watched]
class WatchedView extends StatelessWidget {
  const WatchedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MovieTeasersStreamConsumer(
        provider: watchedMoviesProvider,
      );
}

@visibleForTesting
final watchedMoviesProvider = StreamProvider.autoDispose<List<MovieTeaser>>(
  (_) => ServiceLocator.movieManager.watchedMovies,
);
