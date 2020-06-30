import 'package:The_Friendly_Habit_Journal/Navigation.dart';
import 'package:The_Friendly_Habit_Journal/bloc/tracker/tracker_bloc_delegate.dart';
import 'package:The_Friendly_Habit_Journal/page/CreateTracker.dart';
import 'package:The_Friendly_Habit_Journal/page/Reviewing.dart';
import 'package:The_Friendly_Habit_Journal/page/Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'file:///C:/Users/saad/AndroidStudioProjects/review_your_day/lib/bloc/tracker/tracker_bloc.dart';

void main() {
  BlocSupervisor.delegate = TrackerBlocDelegate();
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
      home: BlocProvider<TrackerBloc>(
        create: (context) => TrackerBloc(),
        child: Navigation(),
      ),
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
