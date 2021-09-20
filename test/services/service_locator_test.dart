import 'package:film_freund/services/date_time.dart/date_time_service.dart';
import 'package:film_freund/services/service_locator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks.dart';
import '../test_service_locator.dart';

void main() {
  group('$ServiceLocator', () {
    late DateTimeService mockDateTimeService;

    setUp(() {
      mockDateTimeService = MockDateTimeService();
      TestServiceLocator.register(
        dateTimeService: mockDateTimeService,
      );
    });

    tearDown(TestServiceLocator.rest);

    test('When $ServiceLocator is initialized, expect access to services', () {
      expect(
        () => ServiceLocator.dateTimeService,
        returnsNormally,
      );
    });
  });
}
