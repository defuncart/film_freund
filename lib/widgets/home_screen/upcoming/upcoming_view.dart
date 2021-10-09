import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:film_freund/services/service_locator.dart';
import 'package:film_freund/widgets/common/movie/movie_teasers_container.dart';
import 'package:film_freund/widgets/home_screen/active_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget for [ActiveView.upcoming]
class UpcomingView extends StatelessWidget {
  const UpcomingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MovieTeasersContainer(
        provider: upcomingMoviesProvider,
      );
}

@visibleForTesting
final upcomingMoviesProvider = FutureProvider.autoDispose<List<MovieTeaser>>(
  (ref) => ServiceLocator.movieManager.getUpcoming(),
);
