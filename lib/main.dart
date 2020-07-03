import 'package:The_Friendly_Habit_Journal/Navigation.dart';
import 'package:The_Friendly_Habit_Journal/bloc/review/bloc.dart';
import 'package:The_Friendly_Habit_Journal/bloc/tracker/bloc.dart';
import 'package:The_Friendly_Habit_Journal/page/Reviewing.dart';
import 'package:The_Friendly_Habit_Journal/page/Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocSupervisor.delegate = TrackerBlocDelegate();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // ignore: close_sinks
  final TrackerBloc _trackerBloc = TrackerBloc();
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
      routes: {
        '/': (context) =>
            BlocProvider.value(value: _trackerBloc, child: Navigation()),
        '/review': (context) => MultiBlocProvider(
              providers: [
                BlocProvider<ReviewBloc>(
                  create: (BuildContext context) =>
                      ReviewBloc(trackerBloc: _trackerBloc),
                ),
              ],
              child: ReviewingGame(),
            ),
        '/settings': (context) => Settings(),
      },
    );
  }

  @override
  void dispose() {
    _trackerBloc.close();
    super.dispose();
  }
}
