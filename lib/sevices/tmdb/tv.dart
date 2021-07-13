class Tv {
  bool? adult;
  String? backdropPath;
  List? genreIds;
  int? id;
  List? originCountry;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? firstAirDate;
  String? name;
  bool? video;
  //var? voteAverage;
  int? voteCount;

  Tv(
      {this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originCountry,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.firstAirDate,
      this.name,
      this.video,
      //this.voteAverage,
      this.voteCount});

  factory Tv.fromJson(Map<String, dynamic> json) => Tv(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      genreIds: json['genre_ids'],
      id: json['id'],
      originCountry: json['origin_country'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      firstAirDate: json['first_air_date'],
      name: json['name'],
      video: json['video'],
      //voteAverage: json['vote_average'],
      voteCount: json['vote_count']);
}