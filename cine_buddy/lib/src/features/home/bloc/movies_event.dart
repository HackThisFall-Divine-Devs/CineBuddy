part of 'movies_bloc.dart';

sealed class MoviesEvent {}

class MovieRenderRequest extends MoviesEvent {
  final int genre;

  MovieRenderRequest({required this.genre});
}
