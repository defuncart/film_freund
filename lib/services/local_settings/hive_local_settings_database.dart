import 'package:film_freund/services/local_settings/i_local_settings_database.dart';
import 'package:film_freund/services/platform/i_platform_service.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveLocalSettingsDatabase implements ILocalSettingsDatabase {
  HiveLocalSettingsDatabase({
    required IPlatformService platformService,
    HiveInterface? hive,
  })  : _platformService = platformService,
        _hive = hive ?? Hive;

  final HiveInterface _hive;
  final IPlatformService _platformService;

  /// A box to store objects
  late Box<dynamic> _box;

  /// A name for the box
  @visibleForTesting
  static const boxName = 'settings';

  @override
  String get region => _box.get(_Keys.region, defaultValue: _Defaults.region);

  @override
  set region(String value) => _box.put(_Keys.region, value);

  @override
  Future<void> initialize() async {
    if (!_platformService.isRunningOnWeb) {
      final dir = await getApplicationDocumentsDirectory();
      _hive.init(dir.path);
    }

    _box = await _hive.openBox<dynamic>(boxName);
  }

  @override
  Future<void> reset() => _box.deleteAll(_box.keys);
}

/// A class of keys used to store values
class _Keys {
  static const region = 'region';
}

/// A class of defaults for each key
class _Defaults {
  static const region = 'de';
}
