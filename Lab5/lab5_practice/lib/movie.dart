class Movie {
  final String id, title, posterUrl, overview;
  final List<String> genres;
  final double rating;
  final List<Trailer> trailers;
  const Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.overview,
    required this.genres,
    required this.rating,
    required this.trailers,
  });
}

class Trailer {
  final String title;
  const Trailer(this.title);
}
