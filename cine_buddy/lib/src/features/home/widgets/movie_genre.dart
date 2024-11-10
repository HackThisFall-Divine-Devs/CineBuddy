import 'package:cine_buddy/src/features/home/bloc/movie_categories_bloc.dart';
import 'package:cine_buddy/src/features/home/widgets/movie_list.dart';
import 'package:cine_buddy/src/models/movie/genere.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesByGenre extends StatefulWidget {
  const MoviesByGenre({super.key});

  @override
  _MoviesByGenreScreenState createState() => _MoviesByGenreScreenState();
}

class _MoviesByGenreScreenState extends State<MoviesByGenre> {
  @override
  void initState() {
    super.initState();
    context.read<MovieCategoriesBloc>().add(MovieCategoriesRenderRequest());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieCategoriesBloc, MovieCategoriesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is MovieCategoriesLoading) {
          return SliverList(
            delegate: SliverChildListDelegate(
              [
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
        } else if (state is MovieCategoriesSuccess) {
          final successState = state as MovieCategoriesSuccess;
          List<Genre> genres = successState.genre;

          return SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: genres.map((genre) {
                  return MovieList(genre: genre, generes: genres);
                }).toList(),
              ),
            ]),
          );
        } else if (state is MovieCategoriesFailure) {
          return SliverList(
            delegate: SliverChildListDelegate(
              [
                const Center(
                  child: Text("Error loading the data!"),
                ),
              ],
            ),
          );
        } else if (state is MovieCategoriesInitial) {
          return SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(),
              ],
            ),
          );
        } else {
          return SliverList(
            delegate: SliverChildListDelegate(
              [
                const Center(
                  child: Text("Unexpected error occured!"),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
