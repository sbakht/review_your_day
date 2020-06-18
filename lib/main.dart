import 'package:flutter/material.dart';
import 'package:reviewyourday/data/Storage.dart';
import 'package:reviewyourday/page/CreateTracker.dart';
import 'package:reviewyourday/page/Reviewing.dart';
import 'package:reviewyourday/page/Settings.dart';

import 'Navigation.dart';
import 'TrackerBrain.dart';
import 'data/Tracker.dart';

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
      ),
      home: Navigation(storage: BrainStorage()),
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
