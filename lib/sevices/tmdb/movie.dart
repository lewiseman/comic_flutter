class Movie {
  bool? adult;
  String backdropPath;
  List? genreIds;
  int id;
  String? originalLanguage;
  String? originalTitle;
  String overview;
  double? popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool? video;

  dynamic voteAverage;
  int? voteCount;

  Movie(
      {this.adult,
      required this.backdropPath,
      this.genreIds,
      required this.id,
      this.originalLanguage,
      this.originalTitle,
      required this.overview,
      this.popularity,
      required this.posterPath,
      required this.releaseDate,
      required this.title,
      this.video,
      this.voteAverage,
      this.voteCount});

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        genreIds: json['genre_ids'],
        id: json['id'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        releaseDate: json['release_date'],
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
      );
}

class SingleMovie {
  bool adult;
  String backdropPath;
  List genre;
  int id;
  String homepage;
  String originalLanguage;
  String status;
  String originalTitle;
  String overview;
  double popularity;
  String tagline;
  String posterPath;
  String releaseDate;
  int runtime;
  String title;
  bool video;
  dynamic voteAverage;
  int voteCount;

  SingleMovie({
    required this.adult,
    required this.backdropPath,
    required this.genre,
    required this.id,
    required this.homepage,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.status,
    required this.popularity,
    required this.posterPath,
    required this.runtime,
    required this.tagline,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory SingleMovie.fromJson(Map<String, dynamic> json) => SingleMovie(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        genre: json['genres'],
        id: json['id'],
        homepage: json['homepage'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        tagline: json['tagline'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        releaseDate: json['release_date'],
        runtime: json['runtime'],
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
        status: json['status'],
      );
}
