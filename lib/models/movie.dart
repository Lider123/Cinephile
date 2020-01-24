import 'cast.dart';
import 'genre.dart';
import 'video.dart';

class Movie {
  int id;
  int voteCount;
  double voteAverage;
  int runtime;
  String title;
  String releaseDate;
  String posterPath;
  String backdropPath;
  List<Genre> genres;
  String overview;
  List<Cast> credits;
  List<Video> videos;

  Movie(this.title);
}
