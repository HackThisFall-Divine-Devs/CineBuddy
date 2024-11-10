class Crew {
  final bool? adult;
  final int? gender;
  final int? id;
  final String? knownForDepartment;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? profilePath;
  final String? creditId;
  final String? department;
  final String? job;

  Crew({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.creditId,
    required this.department,
    required this.job,
  });

  factory Crew.fromJson(Map<String?, dynamic> json) => Crew(
        adult: json['adult'] as bool,
        gender: json['gender'] as int,
        id: json['id'] as int,
        knownForDepartment: json['known_for_department'] as String,
        name: json['name'] as String,
        originalName: json['original_name'] as String?,
        popularity: json['popularity'] as double,
        profilePath: json['profile_path'] as String?,
        creditId: json['credit_id'] as String,
        department: json['department'] as String,
        job: json['job'] as String,
      );
}
