import 'package:cine_buddy/src/models/movie/genere.dart';
import 'package:cine_buddy/src/repository/movies_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_categories_event.dart';
part 'movie_categories_state.dart';

class MovieCategoriesBloc
    extends Bloc<MovieCategoriesEvent, MovieCategoriesState> {
  MovieCategoriesBloc() : super(MovieCategoriesInitial()) {
    on<MovieCategoriesRenderRequest>((event, emit) => _fetchGenre(event, emit));
  }

  void _fetchGenre(event, emit) async {
    emit(MovieCategoriesLoading());
    try {
      List<Genre> genres = await MovieService.fetchGenres();
      emit(MovieCategoriesSuccess(genre: genres));
    } catch (e) {
      emit(MovieCategoriesFailure());
    }
  }
}
