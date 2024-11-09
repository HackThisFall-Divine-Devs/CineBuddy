import 'dart:convert';

class CurrentUser {
  final String password;
  final String username;
  final String email;
  final List<String> platforms;
  final List<String> listOfMovies;
  final List<String> genre;
  final List<String> other;

  CurrentUser({
    required this.password,
    required this.username,
    required this.email,
    required this.platforms,
    required this.listOfMovies,
    required this.genre,
    required this.other,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
      'username': username,
      'email': email,
      'platforms': platforms,
      'listOfMovies': listOfMovies,
      'genre': genre,
      'other': other,
    };
  }

  factory CurrentUser.fromMap(Map<String, dynamic> map) {
    return CurrentUser(
      password: map['password'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      platforms: List<String>.from((map['platforms'] as List) ?? []),
      listOfMovies: List<String>.from((map['listOfMovies'] as List) ?? []),
      genre: List<String>.from((map['genre'] as List) ?? []),
      other: List<String>.from((map['other'] as List) ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentUser.fromJson(String source) =>
      CurrentUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
