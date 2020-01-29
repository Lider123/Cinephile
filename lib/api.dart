import 'package:cinephile/secrets.dart';
import 'package:http/http.dart' as http;

const BASE_URL = "https://api.themoviedb.org/3";
const IMAGE_URL = "http://image.tmdb.org/t/p/w400/";

class Api {

  static Future fetchPopularMovies() async {
    final secret = await SecretLoader(secretPath: "secrets.json").load();
    return http.get(BASE_URL + "/movie/popular?api_key=${secret.apiKey}");
  }
}