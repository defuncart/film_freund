import 'package:flutter/foundation.dart';

/// An enum describing the support regions
enum Region {
  de,
  pl,
  gb,
  us,
}

extension RegionExtensions on Region {
  /// Returns [Region] as [String]
  String get countryCode => describeEnum(this);
}
