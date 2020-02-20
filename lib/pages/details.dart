import 'dart:convert';
import 'dart:developer';

import 'package:cinephile/config/colors.dart';
import 'package:cinephile/data/api.dart';
import 'package:cinephile/data/models.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatefulWidget {
  final Movie _movie;

  DetailsPage(this._movie);

  @override
  State<StatefulWidget> createState() => _DetailsPageState(this._movie);
}

class _DetailsPageState extends State<DetailsPage> {
  final Movie _movie;
  List<Video> _videos = new List<Video>();

  _DetailsPageState(this._movie);

  @override
  void initState() {
    super.initState();
    Api.fetchVideos(this._movie.id)
    .then((response) {
      setState(() {
        Iterable items = json.decode(response.body)["results"];
        _videos = items.map((item) => Video.fromJson(item)).toList();
      });
    })
    .catchError((error) {
      log(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    final videosSection = _buildVideosSection();
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: _sliverBuilder,
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(_movie.overview),
            ),
            videosSection,
          ],
        ),
      ),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) => [
    SliverOverlapAbsorber(
      child: SliverSafeArea(
        top: false,
        sliver: SliverAppBar(
          expandedHeight: 200,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            title: Text(_movie.title),
            background: Image.network(IMAGE_URL + _movie.backdropPath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
    ),
  ];


  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // TODO
    }
  }

  Widget _buildVideoPreview(int index) {
    Video item = _videos[index];
    return RaisedButton(
      child: Text(item.name,
        style: TextStyle(
            color: colorOnSecondary
        ),
      ),
      color: colorSecondary,
      onPressed: () {
        _launchUrl(item.srcUrl);
      },
    );
  }

  Widget _buildVideosSection() {
    if (_videos.isEmpty) {
      return Container();
    } else {
      return Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Videos",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            ListView.builder(
              itemCount: _videos.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) => _buildVideoPreview(index),
            ),
          ],
        ),
      );
    }
  }
}
