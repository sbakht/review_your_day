import 'package:The_Friendly_Habit_Journal/TrackerBrain.dart';

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
