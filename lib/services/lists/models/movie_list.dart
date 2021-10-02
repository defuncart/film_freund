import 'package:equatable/equatable.dart';
import 'package:film_freund/services/lists/enums/list_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'movie_list.g.dart';

/// A model representing a movie list
@JsonSerializable()
@immutable
class MovieList extends Equatable {
  const MovieList({
    required this.id,
    required this.type,
    required this.title,
    required this.movies,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final ListType type;
  final String title;
  final List<int> movies;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory MovieList.fromJson(Map<String, dynamic> json) => _$MovieListFromJson(json);

  Map<String, dynamic> toJson() => _$MovieListToJson(this);

  @override
  List<Object?> get props => [
        id,
        type,
        title,
        movies,
        createdAt,
        updatedAt,
      ];
}
