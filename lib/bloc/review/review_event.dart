import 'package:The_Friendly_Habit_Journal/TrackerBrain.dart';
import 'package:The_Friendly_Habit_Journal/data/Tracker.dart';
import 'package:The_Friendly_Habit_Journal/enums.dart';

abstract class ReviewEvent {
  const ReviewEvent();
}

class EventReviewStart extends ReviewEvent {
  final DATE date;

  EventReviewStart({this.date});
//
//  @override
//  List<Object> get props => [date];
}

class EventReviewNextQuestion extends ReviewEvent {}

class EventReviewPreviousQuestion extends ReviewEvent {}

class EventAnswerQuestion extends ReviewEvent {
  final Tracker tracker;
  final Answer answer;

  EventAnswerQuestion({this.tracker, this.answer});
}
