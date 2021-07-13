import 'package:comics/sevices/services.dart';
import 'package:comics/sevices/tmdb/movie.dart';
import 'package:comics/sevices/tmdb/tv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<List<Tv>> getTv(String item) async {
  final url = Uri.parse(
      'https://api.themoviedb.org/3/$item?api_key=$tmdbApiKey&language=en-US&page=1');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final jsonData = convert.jsonDecode(response.body);
    final jsonBody = jsonData['results'];
    List<Tv> movies =
        List<Tv>.from(jsonBody.map((dynamic body) => Tv.fromJson(body)));
    return movies;
  } else {
    throw Exception('Unable to fetch data from the TMDB API');
  }
}

Future<List<Movie>> getMovie(String type) async {
  final url = Uri.parse(
      'https://api.themoviedb.org/3/$type?api_key=$tmdbApiKey&language=en-US&page=1');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final jsonData = convert.jsonDecode(response.body);
    final jsonBody = jsonData['results'];
    List<Movie> movies =
        List<Movie>.from(jsonBody.map((dynamic body) => Movie.fromJson(body)));
    return movies;
  } else {
    throw Exception('Unable to fetch data from the TMDB API');
  }
}
