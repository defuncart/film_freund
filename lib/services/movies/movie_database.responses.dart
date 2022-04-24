part of 'movie_database.dart';

@visibleForTesting
class MovieResponse {
  const MovieResponse({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String? backdropPath;
  final BelongsToCollection? belongsToCollection;
  final int budget;
  final List<Genre> genres;
  final String? homepage;
  final int id;
  final String? imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String? overview;
  final double popularity;
  final String? posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final DateTime releaseDate;
  final int revenue;
  final int? runtime;
  final List<SpokenLanguage> spokenLanguages;
  // TODO
  // Rumored, Planned, In Production, Post Production, Released, Canceled
  final String status;
  final String? tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        belongsToCollection:
            json['belongs_to_collection'] != null ? BelongsToCollection.fromJson(json['belongs_to_collection']) : null,
        budget: json['budget'],
        genres: List<Genre>.from(json['genres'].map((x) => Genre.fromJson(x))),
        homepage: json['homepage'],
        id: json['id'],
        imdbId: json['imdb_id'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'].toDouble(),
        posterPath: json['poster_path'],
        productionCompanies:
            List<ProductionCompany>.from(json['production_companies'].map((x) => ProductionCompany.fromJson(x))),
        productionCountries:
            List<ProductionCountry>.from(json['production_countries'].map((x) => ProductionCountry.fromJson(x))),
        releaseDate: DateTime.parse(json['release_date']),
        revenue: json['revenue'],
        runtime: json['runtime'],
        spokenLanguages: List<SpokenLanguage>.from(json['spoken_languages'].map((x) => SpokenLanguage.fromJson(x))),
        status: json['status'],
        tagline: json['tagline'],
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average'].toDouble(),
        voteCount: json['vote_count'],
      );
}

@visibleForTesting
class BelongsToCollection {
  const BelongsToCollection({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
  });

  final int id;
  final String name;
  final String? posterPath;
  final String? backdropPath;

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) => BelongsToCollection(
        id: json['id'],
        name: json['name'],
        posterPath: json['poster_path'],
        backdropPath: json['backdrop_path'],
      );
}

@visibleForTesting
class Genre {
  const Genre({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json['id'],
        name: json['name'],
      );
}

@visibleForTesting
class ProductionCompany {
  const ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  factory ProductionCompany.fromJson(Map<String, dynamic> json) => ProductionCompany(
        id: json['id'],
        logoPath: json['logo_path'],
        name: json['name'],
        originCountry: json['origin_country'],
      );
}

@visibleForTesting
class ProductionCountry {
  const ProductionCountry({
    required this.iso31661,
    required this.name,
  });

  final String iso31661;
  final String name;

  factory ProductionCountry.fromJson(Map<String, dynamic> json) => ProductionCountry(
        iso31661: json['iso_3166_1'],
        name: json['name'],
      );
}

@visibleForTesting
class SpokenLanguage {
  const SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  final String englishName;
  final String iso6391;
  final String name;

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
        englishName: json['english_name'],
        iso6391: json['iso_639_1'],
        name: json['name'],
      );
}

@visibleForTesting
class PopularResponse {
  const PopularResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<MovieListResult> results;
  final int totalPages;
  final int totalResults;

  factory PopularResponse.fromJson(Map<String, dynamic> json) => PopularResponse(
        page: json['page'],
        results: List<MovieListResult>.from(json['results'].map((x) => MovieListResult.fromJson(x))),
        totalPages: json['total_pages'],
        totalResults: json['total_results'],
      );
}

@visibleForTesting
class MovieListResult {
  const MovieListResult({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  factory MovieListResult.fromJson(Map<String, dynamic> json) => MovieListResult(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
        id: json['id'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'].toDouble(),
        posterPath: json['poster_path'],
        releaseDate: DateTime.parse(json['release_date']),
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average'].toDouble(),
        voteCount: json['vote_count'],
      );
}

class UpcomingResponse {
  const UpcomingResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final Dates dates;
  final int page;
  final List<MovieListResult> results;
  final int totalPages;
  final int totalResults;

  factory UpcomingResponse.fromJson(Map<String, dynamic> json) => UpcomingResponse(
        dates: Dates.fromJson(json['dates']),
        page: json['page'],
        results: List<MovieListResult>.from(json['results'].map((x) => MovieListResult.fromJson(x))),
        totalPages: json['total_pages'],
        totalResults: json['total_results'],
      );
}

class Dates {
  const Dates({
    required this.maximum,
    required this.minimum,
  });

  final DateTime maximum;
  final DateTime minimum;

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json['maximum']),
        minimum: DateTime.parse(json['minimum']),
      );
}
