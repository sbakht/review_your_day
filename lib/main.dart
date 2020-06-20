import 'package:The_Friendly_Habit_Journal/data/TrackerDAO.dart';
import 'package:The_Friendly_Habit_Journal/examples/examples.dart';
import 'package:flutter/material.dart';

import 'Navigation.dart';
import 'TrackerBrain.dart';
import 'data/Tracker.dart';
import 'page/CreateTracker.dart';
import 'page/Reviewing.dart';
import 'page/Settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TrackerBrain trackerBrain = new TrackerBrain(<Tracker>[]);

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
      home: Navigation(storage: TrackerDAO(trackerExamples)),
//      initialRoute: '/',
      routes: {
//        '/': (context) => Home(),
        '/create': (context) => CreateTracker(),
        '/review': (context) => ReviewGame(),
        '/settings': (context) => Settings(),
      },
    );
  }
}
