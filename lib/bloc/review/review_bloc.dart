import 'dart:async';

import 'package:The_Friendly_Habit_Journal/TrackerBrain.dart';
import 'package:The_Friendly_Habit_Journal/bloc/tracker/tracker_bloc.dart';
import 'package:The_Friendly_Habit_Journal/bloc/tracker/tracker_event.dart';
import 'package:The_Friendly_Habit_Journal/bloc/tracker/tracker_state.dart';
import 'package:The_Friendly_Habit_Journal/data/ReviewGame.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  TrackerBloc trackerBloc;
  TrackerBrain trackerBrain;
  DATE date;
  @override
  ReviewState get initialState => StateReviewInit();

  ReviewBloc({this.trackerBloc}) {
    //TODO: fix this hardcoded trackerBrain grab
    TrackerState state = trackerBloc.state;
    if (state is StateTracker) {
      trackerBrain = state.trackerBrain;
    }
  }

  @override
  Stream<ReviewState> mapEventToState(
    ReviewEvent event,
  ) async* {
    if (event is EventReviewStart) {
      this.date = event.date;
    }
    if (event is EventReviewNextQuestion) {
      ReviewGame game = trackerBrain.getReviewGame(date);
      game.nextQuestion();
    }
    if (event is EventReviewPreviousQuestion) {
      ReviewGame game = trackerBrain.getReviewGame(date);
      game.previousQuestion();
    }
    if (event is EventAnswerQuestion) {
      ReviewGame game = trackerBrain.getReviewGame(date);
      game.setAnswer(event.tracker, event.answer);
      trackerBloc.add(EventSaveTracker());
    }

    ReviewGame game = trackerBrain.getReviewGame(date);
    yield StateReviewing(
      game: trackerBrain.getReviewGame(date),
      isFirstQuestion: game.isFirstQuestion(),
      isLastQuestion: game.isLastQuestion(),
      numCards: game.getNumCards(),
      cardIndex: game.getIndex(),
      cards: game.getCards(),
      answers: game.getAnswers(),
    );
  }
}
