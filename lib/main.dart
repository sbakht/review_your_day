import 'package:flutter/material.dart';
import 'package:reviewyourday/page/CreateTracker.dart';
import 'package:reviewyourday/page/Review.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => CreateTracker(),
        '/review': (context) => Review(),
      },
    );
  }
}
