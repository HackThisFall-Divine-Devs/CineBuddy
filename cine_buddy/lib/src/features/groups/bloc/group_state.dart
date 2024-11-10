part of 'group_bloc.dart';

sealed class GroupState {}

final class CreateGroupInitial extends GroupState {}

final class CreateGroupLoading extends GroupState {}

final class CreateGroupSuccess extends GroupState {}

final class CreateGroupFailure extends GroupState {
  final String error;

  CreateGroupFailure(this.error);
}

final class FetchGroupInitial extends GroupState {}

final class FetchGroupLoading extends GroupState {}

final class FetchGroupSuccess extends GroupState {
  List<Group> group;
  FetchGroupSuccess(this.group);
}

final class FetchGroupFailure extends GroupState {
  final String error;

  FetchGroupFailure(this.error);
}

final class FetchMovieGroupInitial extends GroupState {}

final class FetchMovieGroupLoading extends GroupState {}

final class FetchMovieGroupSuccess extends GroupState {
  List<Group> group;
  FetchMovieGroupSuccess(this.group);
}

final class FetchMovieGroupFailure extends GroupState {
  final String error;

  FetchMovieGroupFailure(this.error);
}

final class FetchMyGroupInitial extends GroupState {}

final class FetchMyGroupLoading extends GroupState {}

final class FetchMyGroupSuccess extends GroupState {
  List<Group> group;
  FetchMyGroupSuccess(this.group);
}

final class FetchMyGroupFailure extends GroupState {
  final String error;

  FetchMyGroupFailure(this.error);
}

final class FetchNotificationInitial extends GroupState {}

final class FetchNotificationLoading extends GroupState {}

final class FetchNotificationSuccess extends GroupState {
  List<Map<String, dynamic>> group;
  FetchNotificationSuccess(this.group);
}

final class FetchNotificationFailure extends GroupState {
  final String error;

  FetchNotificationFailure(this.error);
}
