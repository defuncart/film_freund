import 'package:film_freund/services/user/models/user.dart';
import 'package:film_freund/state/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserProvider = FutureProvider.autoDispose<User>((ref) async {
  return ref.read(userManagerProvider).currentUser;
});
