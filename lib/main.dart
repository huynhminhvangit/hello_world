import 'package:flutter/material.dart';

import 'MyApp.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.green,
      accentColor: Colors.pinkAccent,
    ),
    title: 'Hello World App',
    home: MyApp(),
  ));
}
