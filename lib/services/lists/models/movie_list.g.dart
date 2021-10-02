// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieList _$MovieListFromJson(Map<String, dynamic> json) {
  return MovieList(
    id: json['id'] as String,
    type: _$enumDecode(_$ListTypeEnumMap, json['type']),
    title: json['title'] as String,
    movies: (json['movies'] as List<dynamic>).map((e) => e as int).toList(),
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );
}

Map<String, dynamic> _$MovieListToJson(MovieList instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$ListTypeEnumMap[instance.type],
      'title': instance.title,
      'movies': instance.movies,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$ListTypeEnumMap = {
  ListType.watched: 'watched',
  ListType.watchlist: 'watchlist',
  ListType.custom: 'custom',
};
