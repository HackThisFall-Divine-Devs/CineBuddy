import 'dart:convert';

import 'package:cine_buddy/main.dart';
import 'package:cine_buddy/src/models/user/current_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>((event, emit) => _authLoginRequested(event, emit));
    on<AuthRegisterRequested>(
        (event, emit) => _authRegisterRequested(event, emit));
  }

  void _authLoginRequested(event, emit) async {
    try {
      emit(AuthLoading());
      final String email = event.email;
      final String password = event.password;

      final url =
          Uri.parse("https://cine-buddy-backend.vercel.app/api/users/login");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        print("Login success");
        final responseBody = json.decode(response.body);
        final token = responseBody['token'];
        final userId = responseBody['userId'];

        if (token != null) {
          await MyApp().storeAuthToken(token);
        }
        if (userId != null) {
          await MyApp().storeUserId(userId);
        }
        emit(AuthSuccess());
      } else if (response.statusCode == 401) {
        emit(AuthFailure("Invalid email or password!"));
      } else {
        emit(AuthFailure("Failed to login user: ${response.body}!"));
      }
    } catch (error) {
      emit(AuthFailure("Error logging in: $error!"));
    }
  }

  void _authRegisterRequested(event, emit) async {
    try {
      emit(AuthLoading());
      final String username = event.username;
      final String email = event.email;
      final String password = event.password;
      final List<String> selectedGenre = event.selectedGenre;
      final List<String> selectedOtherDetails = event.selectedOtherDetails;
      final List<String> selectedStreamingPlatform =
          event.selectedStreamingPlatform;

      //? Storing data to User Model;
      CurrentUser currentUser = CurrentUser(
        password: password,
        username: username,
        email: email,
        genre: selectedGenre,
        platforms: selectedStreamingPlatform,
        other: selectedOtherDetails,
        listOfMovies: [],
      );

      final url =
          Uri.parse("https://cine-buddy-backend.vercel.app/api/users/register");

      try {
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'password': currentUser.password,
            'username': currentUser.username,
            'email': currentUser.email,
            'platforms': currentUser.platforms,
            'listOfMovies': currentUser.listOfMovies,
            'genre': currentUser.genre,
            'others': currentUser.other,
          }),
        );

        if (response.statusCode == 201) {
          print("success");
          print(response);
          final responseBody = json.decode(response.body);
          final token = responseBody['token'];

          if (token != null) {
            await MyApp().storeAuthToken(token);
          }
          emit(AuthSuccess());
        } else if (response.statusCode == 400) {
          emit(AuthFailure("User already registered!"));
        } else {
          emit(AuthFailure("Failed to register user: ${response.body}!"));
        }
      } catch (error) {
        emit(AuthFailure("Error registering user: $error!"));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthFailure("The password provided is too weak!"));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthFailure("The account already exists for that email!"));
      } else {
        emit(AuthFailure("Unable to create user!"));
      }
    } catch (e) {
      emit(AuthFailure("Unable to create user!"));
    }
  }
}
