import 'package:film_freund/services/local_settings/i_local_settings_database.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveLocalSettingsDatabase implements ILocalSettingsDatabase {
  /// A box to store objects
  late Box<dynamic> _box;

  /// A name for the box
  static const _boxName = 'settings';

  @override
  String get region => _box.get(_Keys.region, defaultValue: _Defaults.region);

  @override
  set region(String value) => _box.put(_Keys.region, value);

  @override
  String get displayName => _box.get(_Keys.displayName, defaultValue: _Defaults.displayName);

  @override
  set displayName(String value) => _box.put(_Keys.displayName, value);

  @override
  Future<void> initialize() async {
    if (!kIsWeb) {
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
    }

    _box = await Hive.openBox<dynamic>(_boxName);
  }

  @override
  Future<void> reset() => _box.deleteAll(_box.keys);
}

/// A class of keys used to store values
class _Keys {
  static const region = 'region';
  static const displayName = 'displayName';
}

/// A class of defaults for each key
class _Defaults {
  static const region = 'de';
  static const displayName = 'Film Freund';
}
