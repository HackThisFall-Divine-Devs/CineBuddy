import 'package:cine_buddy/main.dart';
import 'package:cine_buddy/src/models/groups/group.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc() : super(CreateGroupInitial()) {
    on<CreateGroup>((event, emit) => createGroup(event, emit));
    on<FetchGroups>((event, emit) => fetchGroups(event, emit));
    on<FetchNotification>((event, emit) => fetchNotifications(event, emit));
    on<FetchMovieGroups>((event, emit) => fetchMovieGroups(event, emit));
    on<FetchMyGroups>((event, emit) => fetchMyGroups(event, emit));
  }

  Future<void> createGroup(CreateGroup event, Emitter<GroupState> emit) async {
    try {
      emit(CreateGroupLoading());
      final url =
          Uri.parse('https://cine-buddy-backend.vercel.app/api/rooms/create');
      final token = await MyApp().getAuthToken();

      print(json.encode(event.payload["movieData"]));

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: json.encode(event.payload),
      );

      print(response.body);
      if (response.statusCode == 200) {
        emit(CreateGroupSuccess());
      } else {
        print(response.body);

        emit(CreateGroupFailure(
            'Failed to create group: ${response.statusCode}'));
      }
    } catch (e) {
      print(e);
      emit(CreateGroupFailure("Authentication Failed!"));
    }
  }

  fetchGroups(FetchGroups event, Emitter<GroupState> emit) async {
    try {
      emit(FetchGroupLoading());

      final url =
          Uri.parse('https://cine-buddy-backend.vercel.app/api/rooms/public');
      final token = await MyApp().getAuthToken();

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final rooms = data['rooms'] as List;
        List<Group> groups = [];

        for (var room in rooms) {
          final group = Group(
            id: room['_id'],
            groupName: room['groupName'],
            movieName: room['movieName'],
            isPublic: room['public'],
            timePreference: room['timePreference'],
            timezone: room['timezone'],
            date: DateTime.parse(room['date']),
            membersLimit: room['membersLimit'],
            joinedMembers: List.from(room['joinedMembers']),
            pendingRequests: List.from(room['pendingRequests']),
            ageGroup: room['ageGroup'],
            genderPreference: room['genderPreference'],
            languagePreference: List<String>.from(room['languagePreference']),
            type: room['type'],
            createdBy: CreatedBy.fromJson(room['createdBy']),
            genre: room['genre'],
            movie: Movie.fromJson(room['movie']),
            createdAt: DateTime.parse(room['createdAt']),
          );

          groups.add(group);
        }

        emit(FetchGroupSuccess(groups));
      } else {
        emit(FetchGroupFailure(
            'Failed to fetch groups: ${response.statusCode}'));
      }
    } on Exception catch (_) {
      emit(FetchGroupFailure("Failed to Fetch Data!"));
    }
  }

  fetchMovieGroups(FetchMovieGroups event, Emitter<GroupState> emit) async {
    try {
      emit(FetchMovieGroupLoading());

      final url = Uri.parse(
        'https://cine-buddy-backend.vercel.app/api/rooms/search?movieName=${event.movieName}',
      );
      final token = await MyApp().getAuthToken();

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final rooms = data['rooms'] as List;
        List<Group> groups = [];
        print(data);

        for (var room in rooms) {
          final group = Group(
            id: room['_id'],
            groupName: room['groupName'],
            movieName: room['movieName'],
            isPublic: room['public'],
            timePreference: room['timePreference'],
            timezone: room['timezone'],
            date: DateTime.parse(room['date']),
            membersLimit: room['membersLimit'],
            joinedMembers: List.from(room['joinedMembers']),
            pendingRequests: List.from(room['pendingRequests']),
            ageGroup: room['ageGroup'],
            genderPreference: room['genderPreference'],
            languagePreference: List<String>.from(room['languagePreference']),
            type: room['type'],
            createdBy: CreatedBy.fromJson(room['createdBy']),
            genre: room['genre'],
            movie: Movie.fromJson(room['movie']),
            createdAt: DateTime.parse(room['createdAt']),
          );

          groups.add(group);
        }

        print(groups);

        emit(FetchMovieGroupSuccess(groups));
      } else {
        emit(FetchMovieGroupFailure(
            'Failed to fetch groups: ${response.statusCode}'));
      }
    } on Exception catch (_) {
      emit(FetchMovieGroupFailure("Failed to Fetch Data!"));
    }
  }

  fetchMyGroups(FetchMyGroups event, Emitter<GroupState> emit) async {
    try {
      emit(FetchMyGroupLoading());

      final url = Uri.parse(
        'https://cine-buddy-backend.vercel.app/api/users/my-rooms',
      );
      final token = await MyApp().getAuthToken();

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final rooms = data['rooms'] as List;
        List<Group> groups = [];
        print(data);

        for (var room in rooms) {
          final group = Group(
            id: room['_id'],
            groupName: room['groupName'],
            movieName: room['movieName'],
            isPublic: room['public'],
            timePreference: room['timePreference'],
            timezone: room['timezone'],
            date: DateTime.parse(room['date']),
            membersLimit: room['membersLimit'],
            joinedMembers: List.from(room['joinedMembers']),
            pendingRequests: List.from(room['pendingRequests']),
            ageGroup: room['ageGroup'],
            genderPreference: room['genderPreference'],
            languagePreference: List<String>.from(room['languagePreference']),
            type: room['type'],
            createdBy: CreatedBy.fromJson(room['createdBy']),
            genre: room['genre'],
            movie: Movie.fromJson(room['movie']),
            createdAt: DateTime.parse(room['createdAt']),
          );

          groups.add(group);
        }

        print(groups);

        emit(FetchMyGroupSuccess(groups));
      } else {
        emit(FetchMyGroupFailure(
            'Failed to fetch groups: ${response.statusCode}'));
      }
    } on Exception catch (_) {
      emit(FetchMyGroupFailure("Failed to Fetch Data!"));
    }
  }

  fetchNotifications(FetchNotification event, Emitter<GroupState> emit) async {
    try {
      emit(FetchNotificationLoading());
      final token = await MyApp().getAuthToken();

      final requestsResponse = await http.get(
        Uri.parse(
            'https://cine-buddy-backend.vercel.app/api/users/fetch-requests'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3MmY1YWY2N2NiOTJlODE1MDIyMjdiNCIsImlhdCI6MTczMTE1NjcyNiwiZXhwIjoxNzMxMjQzMTI2fQ.N9TDVizIS2OS4fR_TK3EK8R9Du_U6cl7r8Iailt6irk',
        },
      );

      if (requestsResponse.statusCode == 200) {
        final requestsData = json.decode(requestsResponse.body);

        if (requestsData['success'] == true &&
            requestsData['requests'].isEmpty) {
          emit(
              FetchNotificationFailure('No join requests found for this user'));
          return;
        }

        List<Map<String, dynamic>> groupsList = [];

        for (var requestId in requestsData['requests']) {
          final roomResponse = await http.get(
            Uri.parse(
                'https://cine-buddy-backend.vercel.app/api/rooms/$requestId'),
            headers: {
              'Authorization': 'Bearer $token',
            },
          );

          if (roomResponse.statusCode == 200) {
            final data = jsonDecode(roomResponse.body);

            final rooms = data['room'];
            Map<String, dynamic> groups = {};
            groups.putIfAbsent("groupName", () => rooms["groupName"]);
            groups.putIfAbsent("groupId", () => rooms["_id"]);
            groups.putIfAbsent("requestId", () => requestId);

            if (data['success'] == true) {
              groupsList.add(groups);
            } else {
              emit(FetchNotificationFailure(
                  'Failed to fetch room data for request: $requestId'));
              return;
            }
          } else {
            emit(FetchNotificationFailure(
                'Failed to fetch room data for request: $requestId'));
            return;
          }
        }
        print(groupsList);
        emit(FetchNotificationSuccess(groupsList));
      } else {
        emit(FetchNotificationFailure(
          'Failed to fetch requests: ${requestsResponse.statusCode}',
        ));
      }
    } on Exception catch (_) {
      emit(FetchNotificationFailure("Failed to Fetch Data!"));
    }
  }
}
