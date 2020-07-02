import 'package:The_Friendly_Habit_Journal/data/ReviewGame.dart';
import 'package:The_Friendly_Habit_Journal/data/Tracker.dart';
import 'package:The_Friendly_Habit_Journal/enums.dart';
import 'package:equatable/equatable.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();
}

class StateReviewInit extends ReviewState {
  @override
  List<Object> get props => [];
}

class StateReviewing extends ReviewState {
  final ReviewGame game;
  final bool isFirstQuestion;
  final bool isLastQuestion;
  final int numCards;
  final int cardIndex;
  final List<Tracker> cards;

  StateReviewing({
    this.game,
    this.isFirstQuestion,
    this.isLastQuestion,
    this.numCards,
    this.cardIndex,
    this.cards,
  });

  @override
  List<Object> get props =>
      [game, isFirstQuestion, isLastQuestion, numCards, cardIndex, cards];

  doesAnswerEqual(Tracker question, Answer answer) {
    return game.doesAnswerEqual(question, answer);
  }

  bool isNextQuestionIndex(int i) {
    return game.isNextQuestionIndex(i);
  }
}

class StateReviewFinished extends ReviewState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
