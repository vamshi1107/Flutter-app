import 'package:Sample/Home.dart';
import 'package:Sample/Search.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      "/home": (context) => Home(),
      "/search": (context) => Search(),
    },
    theme: ThemeData(accentColor: Colors.red),
    home: Home(),
  ));
}
