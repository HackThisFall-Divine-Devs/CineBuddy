class Group {
  final String id;
  final String groupName;
  final String movieName;
  final bool isPublic;
  final String timePreference;
  final String timezone;
  final DateTime date;
  final int membersLimit;
  final List joinedMembers;
  final List pendingRequests;
  final String ageGroup;
  final String genderPreference;
  final List<String> languagePreference;
  final String type;
  final CreatedBy createdBy;
  final String genre;
  final Movie movie;
  final DateTime createdAt;

  Group({
    required this.id,
    required this.groupName,
    required this.movieName,
    required this.isPublic,
    required this.timePreference,
    required this.timezone,
    required this.date,
    required this.membersLimit,
    required this.joinedMembers,
    required this.pendingRequests,
    required this.ageGroup,
    required this.genderPreference,
    required this.languagePreference,
    required this.type,
    required this.createdBy,
    required this.genre,
    required this.movie,
    required this.createdAt,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['_id'],
      groupName: json['groupName'],
      movieName: json['movieName'],
      isPublic: json['public'],
      timePreference: json['timePreference'],
      timezone: json['timezone'],
      date: DateTime.parse(json['date']),
      membersLimit: json['membersLimit'],
      joinedMembers: List.from(json['joinedMembers']),
      pendingRequests: List.from(json['pendingRequests']),
      ageGroup: json['ageGroup'],
      genderPreference: json['genderPreference'],
      languagePreference: List<String>.from(json['languagePreference']),
      type: json['type'],
      createdBy: CreatedBy.fromJson(json['createdBy']),
      genre: json['genre'],
      movie: Movie.fromJson(json['movie']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class CreatedBy {
  final String id;
  final String username;
  final String email;

  CreatedBy({
    required this.id,
    required this.username,
    required this.email,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
    );
  }
}

class Movie {
  final String id;
  final bool adult;
  final String backdropPath;
  final List<String> genre;
  final int movieId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final double voteAverage;
  final int voteCount;

  Movie({
    required this.id,
    required this.adult,
    required this.backdropPath,
    required this.genre,
    required this.movieId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['_id'],
      adult: json['adult'],
      backdropPath: json['backdropPath'],
      genre: List<String>.from(json['genre']),
      movieId: json['id'],
      originalLanguage: json['originalLanguage'],
      originalTitle: json['originalTitle'],
      overview: json['overview'],
      popularity: json['popularity'].toDouble(),
      posterPath: json['posterPath'],
      releaseDate: DateTime.parse(json['releaseDate']),
      title: json['title'],
      voteAverage: json['voteAverage'].toDouble(),
      voteCount: json['voteCount'],
    );
  }
}
