import 'package:film_freund/services/uuid/uuid_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$UUIDService', () {
    final uuidService = UUIDService();

    group('generate', () {
      test('expect generated uuids are valid', () {
        final uuid = uuidService.generate();
        expect(uuid.isValidUUID, isTrue);
      });
    });
  });
}

extension on String {
  static final _regex = RegExp('[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}');

  bool get isValidUUID {
    return _regex.hasMatch(this);
  }
}
