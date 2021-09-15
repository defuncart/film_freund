// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$_$_UserFromJson(Map<String, dynamic> json) {
  return _$_User(
    id: json['id'] as String,
    firstName: json['firstName'] as String? ?? '',
    lastName: json['lastName'] as String? ?? '',
    watched:
        (json['watched'] as List<dynamic>?)?.map((e) => e as String).toList() ??
            [],
    watchlist: (json['watchlist'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    lists:
        (json['lists'] as List<dynamic>?)?.map((e) => e as String).toList() ??
            [],
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );
}

Map<String, dynamic> _$_$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'watched': instance.watched,
      'watchlist': instance.watchlist,
      'lists': instance.lists,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
