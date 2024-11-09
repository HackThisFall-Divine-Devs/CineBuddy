import 'package:cine_buddy/src/models/movie/movies.dart';
import 'package:cine_buddy/src/repository/movies_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial()) {
    on<MovieRenderRequest>((event, emit) => _getMovies(event, emit));
  }

  void _getMovies(event, emit) async {
    emit(MoviesLoading());
    try {
      List<Movies> movies = await MovieService.fetchMoviesByGenre(event.genre);
      emit(MoviesSuccess(movies: movies));
    } catch (e) {
      emit(MoviesFailure());
    }
  }
}
