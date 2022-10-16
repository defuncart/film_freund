import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:film_freund/widgets/home_screen/popular/popular_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'riverpod_provider_extension.dart';

/// A test util class with often used provider overrides
abstract class RiverpodOverrides {
  /// Wraps [child] for [ActiveView.popular]
  static Widget popularMovies(Widget child) => ProviderScope(
        overrides: [
          popularMoviesProvider.overrideWithValue(
            const AsyncValue.data(<MovieTeaser>[]),
          ),
        ],
        child: child,
      );
}
