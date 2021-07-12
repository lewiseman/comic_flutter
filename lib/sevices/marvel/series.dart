import 'package:comics/sevices/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<List<Series>> getSeries(String address) async {
  final Uri url = Uri.parse(
    marvelUrl +
        '$address' +
        '?ts=$ts' +
        '&apikey=$marvelPublicKey' +
        '&hash=$hash',
  );
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return seriesFromJson(response.body);
  } else {
    print('Errrrroor !!!! ${response.statusCode}');
    print(response.body);
    throw UnimplementedError();
  }
}

List<Series> seriesFromJson(String body) {
  final jsonData = convert.jsonDecode(body);
  final jsonBody = jsonData['data']['results'];
  return List<Series>.from(
      jsonBody.map((dynamic body) => Series.fromJson(body)));
}

class Series {
  int id;
  String title;
  String thumbnail;

  Series({required this.id, required this.title, required this.thumbnail});

  factory Series.fromJson(Map<String, dynamic> json) => Series(
        id: json['id'],
        title: json['title'],
        thumbnail:
            json['thumbnail']['path'] + '.' + json['thumbnail']['extension'],
      );
}
