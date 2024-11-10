part of 'carousel_bloc.dart';

sealed class CarouselBlocState {}

final class CarouselInitial extends CarouselBlocState {}

final class CarouselLoading extends CarouselBlocState {}

final class CarouselSuccess extends CarouselBlocState {
  final List<CarouselMovie> carouselMovies;

  CarouselSuccess({required this.carouselMovies});
}

final class CarouselFailure extends CarouselBlocState {}
