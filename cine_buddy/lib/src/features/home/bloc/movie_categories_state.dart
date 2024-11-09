part of 'movie_categories_bloc.dart';

sealed class MovieCategoriesState {}

final class MovieCategoriesInitial extends MovieCategoriesState {}

final class MovieCategoriesLoading extends MovieCategoriesState {}

final class MovieCategoriesSuccess extends MovieCategoriesState {
  final List<Genre> genre;

  MovieCategoriesSuccess({required this.genre});
}

final class MovieCategoriesFailure extends MovieCategoriesState {}
