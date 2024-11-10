import 'package:cine_buddy/src/features/movies/movie_details.dart';
import 'package:cine_buddy/src/models/movie/genere.dart';
import 'package:cine_buddy/src/models/movie/movies.dart';
import 'package:cine_buddy/src/repository/movies_credit.dart';
import 'package:flutter/material.dart';

class MovieItem extends StatelessWidget {
  final Movies movie;
  final List<Genre> generes;

  const MovieItem({super.key, required this.movie, required this.generes});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        MovieCredits movieCredits = await fetchMovieCredits(movie.id);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetails(
                    movie: movie,
                    generes: generes,
                    movieCredits: movieCredits)));
      },
      child: Card(
        margin: const EdgeInsets.all(12.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.transparent,
        child: SizedBox(
          width: 154.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w154${movie.posterPath}',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  movie.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 16.0,
                        overflow: TextOverflow.ellipsis,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
