import 'package:sprintf/sprintf.dart';

import '../constants.dart';

class Movie {
  final double popularity;
  final int voteCount;
  final bool video;
  final String posterPath;
  final int id;
  final bool adult;
  final String backdropPath;
  final String originalLanguage;
  final String originalTitle;
  final List genreIds;
  final String title;
  final num voteAverage;
  final String overview;
  final String releaseDate;

  Movie(this.popularity, this.voteCount, this.video, this.posterPath, this.id,
      this.adult, this.backdropPath, this.originalLanguage, this.originalTitle,
      this.genreIds, this.title, this.voteAverage, this.overview,
      this.releaseDate);

  Movie.fromJson(Map json)
      : popularity = json["popularity"],
        voteCount = json["vote_count"],
        video = json["video"],
        posterPath = json["poster_path"],
        id = json["id"],
        adult = json["adult"],
        backdropPath = json["backdrop_path"],
        originalLanguage = json["original_language"],
        originalTitle = json["original_title"],
        genreIds = json["genre_ids"],
        title = json["title"],
        voteAverage = json["vote_average"],
        overview = json["overview"],
        releaseDate = json["release_date"];
}

class Video {
  final String id;
  final String key;
  final String name;
  final String site;
  final int size;
  final String type;
  final String srcUrl;

  Video({this.id, this.key, this.name, this.site, this.size, this.type, this.srcUrl});

  factory Video.fromJson(Map json) {
    String _srcUrl;
    String _site = json["site"];
    String _key = json["key"];
    switch (_site) {
      case "YouTube": _srcUrl = sprintf(Site.YOUTUBE, [_key]); break;
      default: _srcUrl = "https://google.com";
    }
    return new Video(
        id: json["id"],
        key: _key,
        name: json["name"],
        site: _site,
        size: json["size"],
        type: json["type"],
        srcUrl: _srcUrl
    );
  }
}
