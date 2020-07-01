import 'package:The_Friendly_Habit_Journal/data/ReviewGame.dart';
import 'package:The_Friendly_Habit_Journal/data/Tracker.dart';
import 'package:The_Friendly_Habit_Journal/enums.dart';
import 'package:equatable/equatable.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();
}

class StateReviewLoading extends ReviewState {
  @override
  List<Object> get props => [];
}

class StateReviewing extends ReviewState {
  final ReviewGame game;

  StateReviewing({this.game});

  @override
  List<Object> get props => [];

  getIndex() {
    return game.getIndex();
  }

  getNumCards() {
    return game.getNumCards();
  }

  isFirstQuestion() {
    return game.isFirstQuestion();
  }

  doesAnswerEqual(Tracker question, Answer answer) {
    return game.doesAnswerEqual(question, answer);
  }

  List<Tracker> getCards() {
    return game.getCards();
  }

  bool isNextQuestionIndex(int i) {
    return game.isNextQuestionIndex(i);
  }

  isLastQuestion() {
    return game.isLastQuestion();
  }
}

class StateReviewFinished extends ReviewState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
