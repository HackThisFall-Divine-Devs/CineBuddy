part of 'movies_bloc.dart';

sealed class MoviesState {}

final class MoviesInitial extends MoviesState {}

final class MoviesLoading extends MoviesState {}

final class MoviesSuccess extends MoviesState {
  final List<Movies> movies;

  MoviesSuccess({required this.movies});
}

final class MoviesFailure extends MoviesState {}
