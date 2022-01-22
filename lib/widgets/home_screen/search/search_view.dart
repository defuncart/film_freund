import 'dart:async' show Timer;

import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:film_freund/services/service_locator.dart';
import 'package:film_freund/widgets/common/movie/movie_teasers_async_value.dart';
import 'package:film_freund/widgets/home_screen/active_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget for [ActiveView.search]
class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

@visibleForTesting
const debounceDuration = Duration(milliseconds: 200);

class _SearchViewState extends State<SearchView> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  var _searchTerm = '';
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController()
      ..addListener(() {
        if (_debounce?.isActive ?? false) {
          _debounce?.cancel();
        }
        _debounce = Timer(debounceDuration, () {
          if (_searchTerm != _controller.text) {
            setState(() => _searchTerm = _controller.text);
          }
        });
      });
    _focusNode = FocusNode()..requestFocus();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListView(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.clear),
                padding: EdgeInsets.zero,
                onPressed: () => setState(() {
                  _controller.text = '';
                  _focusNode.requestFocus();
                }),
              ),
            ],
          ),
          if (_searchTerm.isNotEmpty) ...[
            const SizedBox(height: 16),
            Center(
              child: MovieTeasersFamilyConsumer(
                provider: searchMoviesProvider,
                searchTerm: _searchTerm,
                noResultsFound: Text(AppLocalizations.of(context).searchViewNoMoviesFoundText),
              ),
            ),
          ],
        ],
      );
}

@visibleForTesting
final searchMoviesProvider = FutureProvider.family.autoDispose<List<MovieTeaser>, String>(
  (_, searchTerm) => ServiceLocator.movieManager.searchMovies(searchTerm),
);

@visibleForTesting
class MovieTeasersFamilyConsumer extends ConsumerWidget {
  const MovieTeasersFamilyConsumer({
    required this.provider,
    required this.searchTerm,
    required this.noResultsFound,
    Key? key,
  }) : super(key: key);

  final AutoDisposeFutureProviderFamily<List<MovieTeaser>, String> provider;
  final String searchTerm;
  final Widget noResultsFound;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(provider(searchTerm));

    return MovieTeasersAsyncValue(
      movies,
      noData: noResultsFound,
    );
  }
}
