import 'package:The_Friendly_Habit_Journal/TrackerBrain.dart';
import 'package:The_Friendly_Habit_Journal/data/Tracker.dart';
import 'package:equatable/equatable.dart';

abstract class TrackerState extends Equatable {}

class StateTrackerLoading extends TrackerState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class StateTracker extends TrackerState {
  final TrackerBrain trackerBrain;
  final List<Tracker> cards;
  final int numRemainingToday;
  final int numRemainingYesterday;

  StateTracker({
    this.trackerBrain,
    this.cards,
    this.numRemainingToday,
    this.numRemainingYesterday,
  });

  @override
  // TODO: implement props
  List<Object> get props =>
      [trackerBrain, cards, numRemainingToday, numRemainingYesterday];
}
