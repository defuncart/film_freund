/// A service to generate [DateTime]'s
class DateTimeService {
  /// Returns the current [DateTime] in utc
  DateTime get nowUtc => DateTime.now().toUtc();
}
