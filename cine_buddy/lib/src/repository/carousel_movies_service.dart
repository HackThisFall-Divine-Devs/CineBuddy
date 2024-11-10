import 'dart:convert';
import 'package:cine_buddy/src/models/movie/carousel_movies.dart';
import 'package:http/http.dart' as http;

class CarouselMovieService {
  static const String apiKey = '0b18c456c5aa02caa040c1aa7d307ca8';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  static Future<List<CarouselMovie>> fetchLatestMovies() async {
    final response =
        await http.get(Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final List moviesJson = json.decode(response.body)['results'];
      return moviesJson.map((json) => CarouselMovie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
