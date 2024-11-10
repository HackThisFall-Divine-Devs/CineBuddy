import 'package:cine_buddy/src/features/home/bloc/movies_bloc.dart';
import 'package:cine_buddy/src/features/home/widgets/movie_item.dart';
import 'package:cine_buddy/src/models/movie/genere.dart';
import 'package:cine_buddy/src/models/movie/movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieList extends StatefulWidget {
  final Genre genre;
  final List<Genre> generes;

  const MovieList({
    super.key,
    required this.genre,
    required this.generes,
  });

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late MoviesBloc _moviesBloc;

  @override
  void initState() {
    _moviesBloc = MoviesBloc();
    _moviesBloc.add(MovieRenderRequest(genre: widget.genre.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MoviesBloc>(
      create: (context) => _moviesBloc,
      child: BlocConsumer<MoviesBloc, MoviesState>(
        listener: (BuildContext context, MoviesState state) {},
        builder: (context, state) {
          if (state is MoviesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MoviesSuccess) {
            final successState = state as MoviesSuccess;
            List<Movies> movies = successState.movies;

            return SizedBox(
              height: 340.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      widget.genre.name,
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 22.0),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(8.0),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return MovieItem(movie: movie, generes: widget.generes);
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is MoviesFailure) {
            return const Center(
              child: Text("Error loading the data!"),
            );
          } else if (state is MoviesInitial) {
            return const SizedBox();
          } else {
            return const Center(
              child: Text("Unexpected error occured!"),
            );
          }
        },
      ),
    );
  }
}
