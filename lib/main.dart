import 'package:flutter/material.dart';
import 'package:reviewyourday/page/CreateTracker.dart';
import 'package:reviewyourday/page/Review.dart';
import 'package:reviewyourday/page/Settings.dart';

import 'Navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Navigation(),
//      initialRoute: '/',
      routes: {
//        '/': (context) => Home(),
        '/create': (context) => CreateTracker(),
        '/review': (context) => Review(),
        '/settings': (context) => Settings(),
      },
    );
  }
}
