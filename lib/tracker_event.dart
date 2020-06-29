import 'package:The_Friendly_Habit_Journal/data/Tracker.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TrackerEvent extends Equatable {
  const TrackerEvent();

  @override
  List<Object> get props => [];
}

class TrackerAdded extends TrackerEvent {
  final String title;

  const TrackerAdded({@required this.title});

  @override
  String toString() => title;
}

class TrackerRemove extends TrackerEvent {
  final Tracker tracker;

  const TrackerRemove(this.tracker);
}

class TrackerInitialized extends TrackerEvent {}

//class TimerPaused extends TrackerEvent {}
//
//class TimerResumed extends TrackerEvent {}
//
//class TimerReset extends TrackerEvent {}
//
//class TimerTicked extends TrackerEvent {
//  final int duration;
//
//  const TimerTicked({@required this.duration});
//
//  @override
//  String toString() => "TimerTicked { duration: $duration }";
//}
