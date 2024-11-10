import 'package:cine_buddy/src/models/movie/carousel_movies.dart';
import 'package:cine_buddy/src/repository/carousel_movies_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'carousel_event.dart';
part 'carousel_state.dart';

class CarouselBloc extends Bloc<CarouselEvent, CarouselBlocState> {
  CarouselBloc() : super(CarouselInitial()) {
    on<CarouselRenderRequest>((event, emit) => _getLatestMovies(event, emit));
  }

  void _getLatestMovies(event, emit) async {
    emit(CarouselLoading());
    try {
      List<CarouselMovie> carouselMovies =
          await CarouselMovieService.fetchLatestMovies();
      emit(CarouselSuccess(carouselMovies: carouselMovies));
    } catch (e) {
      emit(CarouselFailure());
    }
  }
}
