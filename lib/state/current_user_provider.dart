import 'package:film_freund/services/service_locator.dart';
import 'package:film_freund/services/user/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserProvider = FutureProvider.autoDispose<User>((ref) async {
  return ServiceLocator.userManager.currentUser;
});
