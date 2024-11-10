class CarouselMovie {
  final String title;
  final String posterPath;

  CarouselMovie({required this.title, required this.posterPath});

  factory CarouselMovie.fromJson(Map<String, dynamic> json) {
    return CarouselMovie(
      title: json['title'],
      posterPath: json['poster_path'],
    );
  }
}
