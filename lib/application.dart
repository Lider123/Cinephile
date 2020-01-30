import 'package:cinephile/config/themes.dart';
import 'package:cinephile/pages/home.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinephile',
      home: HomePage(),
      theme: appTheme,
    );
  }
}
