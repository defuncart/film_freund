import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:film_freund/widgets/home_screen/popular/popular_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Wraps [child] for [ActiveView.popular]
Widget popularProvider(Widget child) => ProviderScope(
      overrides: [
        popularMoviesProvider.overrideWithValue(
          const AsyncValue.data(<MovieTeaser>[]),
        ),
      ],
      child: child,
    );
