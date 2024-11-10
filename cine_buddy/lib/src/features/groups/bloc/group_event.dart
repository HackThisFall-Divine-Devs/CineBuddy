// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'group_bloc.dart';

sealed class GroupEvent {}

class CreateGroup extends GroupEvent {
  Map<String, Object> payload;
  CreateGroup({required this.payload});
}

class FetchGroups extends GroupEvent {
  FetchGroups();
}

class FetchMovieGroups extends GroupEvent {
  String movieName;
  FetchMovieGroups(
    this.movieName,
  );
}

class FetchMyGroups extends GroupEvent {
  FetchMyGroups();
}

class FetchNotification extends GroupEvent {
  FetchNotification();
}
