import 'package:The_Friendly_Habit_Journal/data/Tracker.dart';
import 'package:The_Friendly_Habit_Journal/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TrackerEvent extends Equatable {
  const TrackerEvent();

  @override
  List<Object> get props => [];
}

class EventTrackerAdd extends TrackerEvent {
  final String title;

  const EventTrackerAdd({@required this.title});

  @override
  String toString() => title;
}

class EventTrackerRemove extends TrackerEvent {
  final Tracker tracker;

  const EventTrackerRemove(this.tracker);
}

class EventTrackerInitialized extends TrackerEvent {}

class EventTrackerSave extends TrackerEvent {}

class EventTrackerSort extends TrackerEvent {
  final SortBy sortMethod;

  EventTrackerSort({this.sortMethod});
}

class EventTrackerSearch extends TrackerEvent {
  final String searchText;

  EventTrackerSearch({this.searchText});
}
