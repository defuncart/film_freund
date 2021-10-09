import 'package:film_freund/services/local_settings/region.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$Region', () {
    test('countryCode', () {
      expect(Region.de.countryCode, 'de');
      expect(Region.pl.countryCode, 'pl');
      expect(Region.us.countryCode, 'gb');
      expect(Region.us.countryCode, 'us');
    });
  });
}
