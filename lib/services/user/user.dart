import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    required String id,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default([]) List<String> watched,
    @Default([]) List<String> watchlist,
    @Default([]) List<String> lists,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
