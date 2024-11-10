import 'dart:convert';
import 'package:cine_buddy/src/models/movie/genere.dart';
import 'package:cine_buddy/src/models/movie/movies.dart';
import 'package:http/http.dart' as http;

class MovieService {
  static const String _apiKey = '0b18c456c5aa02caa040c1aa7d307ca8';
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  static Future<List<Genre>> fetchGenres() async {
    final response = await http
        .get(Uri.parse('$_baseUrl/genre/movie/list?api_key=$_apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List genres = data['genres'];
      return genres.map((genre) => Genre.fromJson(genre)).toList();
    } else {
      throw Exception('Failed to load genres');
    }
  }

  static Future<List<Movies>> fetchMoviesByGenre(int genreId) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/discover/movie?api_key=$_apiKey&with_genres=$genreId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List movies = data['results'];
      return movies.map((movie) => Movies.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
