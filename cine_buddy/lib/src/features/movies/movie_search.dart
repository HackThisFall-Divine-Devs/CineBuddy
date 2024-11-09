import 'dart:convert';
import 'package:cine_buddy/src/features/home/bloc/movie_categories_bloc.dart';
import 'package:cine_buddy/src/features/home/widgets/movie_item.dart';
import 'package:cine_buddy/src/models/movie/genere.dart';
import 'package:cine_buddy/src/models/movie/movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Movies> _movies = [];
  bool _isLoading = false;

  Future<void> _searchMovies(String query) async {
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=YOUR_API_KEY&query=$query');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _movies = (data['results'] as List)
            .map((json) => Movies.fromJson(json))
            .toList();
      });
    } else {
      print("Failed to load movies: ${response.statusCode}");
    }

    setState(() {
      _isLoading = false;
    });
  }

  List<Genre> _mapGenreIdsToObjects(List<int> genreIds, List<Genre> genres) {
    return genreIds.map((id) {
      return genres.firstWhere((genre) => genre.id == id,
          orElse: () => Genre(id: id, name: 'Unknown'));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movies'),
      ),
      body: BlocBuilder<MovieCategoriesBloc, MovieCategoriesState>(
        builder: (context, state) {
          if (state is MovieCategoriesLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MovieCategoriesFailure) {
            return Center(child: Text("Failed to load genres."));
          } else if (state is MovieCategoriesSuccess) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for movies...',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () => _searchMovies(_searchController.text),
                      ),
                    ),
                    onSubmitted: _searchMovies,
                  ),
                ),
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(8.0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: _movies.length,
                          itemBuilder: (context, index) {
                            final movie = _movies[index];
                            final movieGenres = _mapGenreIdsToObjects(
                                movie.genreIds, state.genre);
                            return MovieItem(
                                movie: movie, generes: movieGenres);
                          },
                        ),
                      ),
              ],
            );
          }
          return Center(child: Text("No genres available."));
        },
      ),
    );
  }
}
