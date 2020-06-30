import 'dart:async';

import 'package:The_Friendly_Habit_Journal/TrackerBrain.dart';
import 'package:The_Friendly_Habit_Journal/data/ReviewGame.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  TrackerBrain trackerBrain;
  final DATE date = DATE.Today;
  @override
  ReviewState get initialState => InitialReviewState();

  ReviewBloc({this.trackerBrain}) {
    //TODO: fix this hardcoded today
    add(EventReviewStart(date: DATE.Today));
  }

  @override
  Stream<ReviewState> mapEventToState(
    ReviewEvent event,
  ) async* {
    if (event is EventReviewStart) {
      //TODO: this isnt being used right now, constructor is calling this
      yield ReviewingState(game: trackerBrain.getReviewGame(event.date));
    }
    if (event is EventReviewNextQuestion) {
      ReviewGame game = trackerBrain.getReviewGame(date);
      game.nextQuestion();
      yield ReviewingState(game: game);
    }
    if (event is EventReviewPreviousQuestion) {
      ReviewGame game = trackerBrain.getReviewGame(date);
      game.previousQuestion();
      yield ReviewingState(game: game);
    }
  }
}
