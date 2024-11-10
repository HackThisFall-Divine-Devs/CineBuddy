import 'dart:convert';
import 'package:cine_buddy/src/models/movie/cast.dart';
import 'package:cine_buddy/src/models/movie/crew.dart';
import 'package:http/http.dart' as http;

class MovieCredits {
  final List<Cast> cast;
  final List<Crew> crew;

  MovieCredits({required this.cast, required this.crew});

  factory MovieCredits.fromJson(Map<String, dynamic> json) => MovieCredits(
        cast: (json['cast'] as List?)
                ?.map((dynamic item) => Cast.fromJson(item))
                .toList() ??
            [],
        crew: (json['crew'] as List?)
                ?.map((dynamic item) => Crew.fromJson(item))
                .toList() ??
            [],
      );
}

Future<MovieCredits> fetchMovieCredits(int movieId) async {
  final apiKey = '0b18c456c5aa02caa040c1aa7d307ca8';
  final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey&language=en-US');

  final response = await http.get(url);
  if (response.statusCode == 200) {
    return MovieCredits.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to fetch movie credits');
  }
}
