import 'dart:async';

import 'package:The_Friendly_Habit_Journal/TrackerBrain.dart';
import 'package:The_Friendly_Habit_Journal/bloc/tracker/tracker_bloc.dart';
import 'package:The_Friendly_Habit_Journal/bloc/tracker/tracker_event.dart';
import 'package:The_Friendly_Habit_Journal/data/ReviewGame.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  TrackerBloc trackerBloc;
  TrackerBrain trackerBrain;
  final DATE date;
  @override
  ReviewState get initialState => StateReviewLoading();

  ReviewBloc({this.trackerBrain, this.date, this.trackerBloc}) {
    //TODO: fix this hardcoded today
    add(EventReviewStart(date: date));
  }

  @override
  Stream<ReviewState> mapEventToState(
    ReviewEvent event,
  ) async* {
    if (event is EventReviewStart) {
      //TODO: this isnt being used right now, constructor is calling this
      yield StateReviewing(game: trackerBrain.getReviewGame(event.date));
    }
    if (event is EventReviewNextQuestion) {
      ReviewGame game = trackerBrain.getReviewGame(date);
      game.nextQuestion();
      yield StateReviewing(game: game);
    }
    if (event is EventReviewPreviousQuestion) {
      ReviewGame game = trackerBrain.getReviewGame(date);
      game.previousQuestion();
      yield StateReviewing(game: game);
    }
    if (event is EventAnswerQuestion) {
      ReviewGame game = trackerBrain.getReviewGame(date);
      game.setAnswer(event.tracker, event.answer);
      yield StateReviewing(game: game);
      trackerBloc.add(TrackerSave());
    }
  }
}
