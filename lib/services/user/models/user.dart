import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user.g.dart';

@JsonSerializable()
@immutable
class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    this.displayName = '',
    required this.createdAt,
    required this.updatedAt,
    required this.watchedId,
    required this.watchlistId,
    this.lists = const [],
  });

  final String id;
  final String email;
  final String displayName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String watchedId;
  final String watchlistId;
  final List<String> lists;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// Returns a copy of current instance with overriden params
  User copyWith({
    String? displayName,
    List<String>? lists,
  }) =>
      User(
        id: id,
        email: email,
        displayName: displayName ?? this.displayName,
        createdAt: createdAt,
        updatedAt: updatedAt,
        watchedId: watchedId,
        watchlistId: watchlistId,
        lists: lists ?? this.lists,
      );

  /// Returns a copy of current instance with overriden [updatedAt]
  User setUpdatedAt(DateTime updatedAt) => User(
        id: id,
        email: email,
        displayName: displayName,
        createdAt: createdAt,
        updatedAt: updatedAt,
        watchedId: watchedId,
        watchlistId: watchlistId,
        lists: lists,
      );

  @override
  List<Object?> get props => [
        id,
        email,
        displayName,
        createdAt,
        updatedAt,
        watchedId,
        watchlistId,
        lists,
      ];
}
