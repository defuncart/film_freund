import 'package:flutter/foundation.dart' show describeEnum;

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
  String get title => describeEnum(this);
}
