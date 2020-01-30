import 'dart:convert';
import 'dart:developer';

import 'package:cinephile/config/colors.dart';
import 'package:cinephile/data/models.dart';
import 'package:flutter/material.dart';

import '../data/api.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> _movies = new List<Movie>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    Api.fetchPopularMovies()
        .then((response) {
          setState(() {
            _isLoading = false;
            Iterable items = json.decode(response.body)["results"];
            _movies = items.map((item) => Movie.fromJson(item)).toList();
          });
        })
        .catchError((error) {
          setState(() {
            _isLoading = false;
          });
          log(error);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home",
          style: TextStyle(
            color: colorOnPrimary,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Visibility(
            visible: _isLoading,
            child: LinearProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(colorSecondary),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text("The most popular movies",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: colorOnBackground,
              ),
            ),
          ),
          Divider(
            color: colorSecondary,
            thickness: 1.3,
            height: 1.3,
          ),
          Expanded(
            flex: 1,
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 4/7,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.all(8),
              children: _movies.map((item) => buildMovieCard(item)).toList()
            ),
          ),
        ]
      ),
    );
  }

  Card buildMovieCard(Movie movie) {
    return Card(
      color: colorSurface,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Image.network(IMAGE_URL + movie.posterPath,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(movie.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: colorOnSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
