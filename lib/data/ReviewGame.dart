import 'dart:math';

import 'package:The_Friendly_Habit_Journal/data/Tracker.dart';
import 'package:The_Friendly_Habit_Journal/enums.dart';

import 'Trackers.dart';

class ReviewGame {
  Trackers trackers;
  int _index = 0;
  String date;
  List<Tracker> cards;

  ReviewGame(this.date, this.trackers) {
    this.cards = trackers.getUnanswered(date);
    cards.shuffle();
  }

  bool isFirstQuestion() {
    return _index == 0;
  }

  bool isLastQuestion() {
    return _index >= cards.length - 1;
  }

  void nextQuestion() {
    _index = min(cards.length - 1, ++_index);
  }

  void previousQuestion() {
    _index = max(0, --_index);
  }

  int getNumCards() {
    return cards.length;
  }

  int getIndex() {
    return _index;
  }

  List<Tracker> getCards() {
    return cards;
  }

  bool isNextQuestionIndex(int i) {
    return i > _index;
  }

  void setAnswer(Tracker question, Answer ans) {
    question.setUserAnswerByDate(date, ans);
  }

  bool doesAnswerEqual(Tracker question, Answer answer) {
    return question.doesAnswerByDateEqual(date, answer);
  }
}
