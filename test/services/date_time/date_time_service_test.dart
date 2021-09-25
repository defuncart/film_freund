import 'package:film_freund/services/date_time.dart/date_time_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$DateTimeService', () {
    final dateTimeService = DateTimeService();

    test('nowUtc', () {
      // As $DateTimeService will call now before expected calls now
      // the values will be out by a couple of microseconds
      // flatten both dates down to seconds level
      expect(
        dateTimeService.nowUtc.removeMilliseconds,
        DateTime.now().toUtc().removeMilliseconds,
      );
    });
  });
}

extension on DateTime {
  /// Removes milliseconds from DateTime instance
  DateTime get removeMilliseconds => DateTime.utc(year, month, day, hour, minute, second);
}
