class Cast {
  final bool? adult;
  final int? gender;
  final int? id;
  final String? knownForDepartment;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? profilePath;
  final int? castId;
  final String? character;
  final String? creditId;
  final int? order;

  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json['adult'] as bool,
        gender: json['gender'] as int,
        id: json['id'] as int,
        knownForDepartment: json['known_for_department'] as String,
        name: json['name'] as String,
        originalName: json['original_name'] as String?,
        popularity: json['popularity'] as double,
        profilePath: json['profile_path'] as String?,
        castId: json['cast_id'] as int,
        character: json['character'] as String,
        creditId: json['credit_id'] as String,
        order: json['order'] as int,
      );
}
