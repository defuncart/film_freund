import 'package:film_freund/services/local_settings/i_local_settings_database.dart';
import 'package:film_freund/services/local_settings/region.dart';
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
  Region get region =>  (_box.get(_Keys.region, defaultValue: Defaults.region) as int).asRegion;

  @override
  set region(Region value) => _box.put(_Keys.region, value.index);

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

extension IntExtensions on int {
  @visibleForTesting
  Region get asRegion {
    assert(this >= 0 && this < Region.values.length, '$this is an invalid index for $Region');

    return Region.values[this];
  }
}

/// A class of keys used to store values
class _Keys {
  static const region = 'region';
}

/// A class of defaults for each key
@visibleForTesting
class Defaults {
  static const region = 0;
}
