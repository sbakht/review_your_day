import 'package:The_Friendly_Habit_Journal/Navigation.dart';
import 'package:The_Friendly_Habit_Journal/page/CreateTracker.dart';
import 'package:The_Friendly_Habit_Journal/page/Reviewing.dart';
import 'package:The_Friendly_Habit_Journal/page/Settings.dart';
import 'package:flutter/material.dart';

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
        brightness: Brightness.dark,
//        scaffoldBackgroundColor: Colors.black,
      ),
      home: Navigation(),
//      initialRoute: '/',
      routes: {
//        '/': (context) => Home(),
        '/create': (context) => CreateTracker(),
        '/review': (context) => ReviewingGame(),
        '/settings': (context) => Settings(),
      },
    );
  }
}
