// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieList _$MovieListFromJson(Map<String, dynamic> json) => MovieList(
      id: json['id'] as String,
      type: $enumDecode(_$ListTypeEnumMap, json['type']),
      title: json['title'] as String,
      movies: (json['movies'] as List<dynamic>).map((e) => e as int).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$MovieListToJson(MovieList instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$ListTypeEnumMap[instance.type]!,
      'title': instance.title,
      'movies': instance.movies,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$ListTypeEnumMap = {
  ListType.watched: 'watched',
  ListType.watchlist: 'watchlist',
  ListType.custom: 'custom',
};
