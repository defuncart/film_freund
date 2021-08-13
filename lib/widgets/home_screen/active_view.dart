import 'package:film_freund/generated/l10n.dart';

enum ActiveView {
  popular,
  search,
  watched,
  liked,
  watchlist,
  lists,
  settings,
}

extension ActiveViewExtensions on ActiveView {
  String get title {
    switch (this) {
      case ActiveView.popular:
        return AppLocalizations.current.activeViewPopularTitle;
      case ActiveView.search:
        return AppLocalizations.current.activeViewSearchTitle;
      case ActiveView.watched:
        return AppLocalizations.current.activeViewWatchedTitle;
      case ActiveView.liked:
        return AppLocalizations.current.activeViewLikedTitle;
      case ActiveView.watchlist:
        return AppLocalizations.current.activeViewWatchlistTitle;
      case ActiveView.lists:
        return AppLocalizations.current.activeViewListsTitle;
      case ActiveView.settings:
        return AppLocalizations.current.activeViewSettingsTitle;
    }
  }
}
