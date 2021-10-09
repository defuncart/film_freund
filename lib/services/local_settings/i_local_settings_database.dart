import 'package:film_freund/services/local_settings/region.dart';

/// A local database of user's settings
abstract class ILocalSettingsDatabase {
  /// Returns the user's region
  Region get region;

  /// Sets the user's region
  set region(Region value);

  /// Initializes the database
  Future<void> initialize();

  /// Resets the database
  Future<void> reset();
}
