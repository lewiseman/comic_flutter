class Movie {
  bool? adult;
  String backdropPath;
  List? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String overview;
  double? popularity;
  String? posterPath;
  String releaseDate;
  String title;
  bool? video;
  //var? voteAverage;
  int? voteCount;

  Movie(
      {this.adult,
      required this.backdropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      required this.overview,
      this.popularity,
      this.posterPath,
      required this.releaseDate,
      required this.title,
      this.video,
      //this.voteAverage,
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
      //voteAverage: json['vote_average'],
      voteCount: json['vote_count']);
}
