/// A local database of user's settings
abstract class ILocalSettingsDatabase {
  /// Returns the user's region
  String get region;

  /// Sets the user's region
  set region(String value);

  /// Returns ther user's display name
  String get displayName;

  /// Sets the user's display name
  set displayName(String value);

  /// Initializes the database
  Future<void> initialize();

  /// Resets the database
  Future<void> reset();
}
