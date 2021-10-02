enum ListType {
  watched,
  watchlist,
  custom,
}

extension ListTypeExtensions on ListType {
  bool get isWatched => this == ListType.watched;
  bool get isWatchList => this == ListType.watchlist;
  bool get isCustom => this == ListType.custom;
}
