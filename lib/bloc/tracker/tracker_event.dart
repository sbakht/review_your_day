import 'package:The_Friendly_Habit_Journal/data/Tracker.dart';
import 'package:The_Friendly_Habit_Journal/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TrackerEvent extends Equatable {
  const TrackerEvent();

  @override
  List<Object> get props => [];
}

class EventAddTracker extends TrackerEvent {
  final String title;

  const EventAddTracker({@required this.title});

  @override
  String toString() => title;
}

class EventRemoveTracker extends TrackerEvent {
  final Tracker tracker;

  const EventRemoveTracker(this.tracker);
}

class EventTrackerInitialized extends TrackerEvent {}

class EventSaveTracker extends TrackerEvent {}

class EventSortTracker extends TrackerEvent {
  final SortBy sortMethod;

  EventSortTracker({this.sortMethod});
}
