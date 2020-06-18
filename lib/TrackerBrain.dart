import 'dart:math';

import 'data/Tracker.dart';
import 'enums.dart';

List<Tracker> trackers = [
  Tracker(title: "eat oatmeal", bonusPointsAnswer: Answer.Nothing),
  Tracker(title: "work on your sprouts", bonusPointsAnswer: Answer.Nothing),
  Tracker(title: "think about padding", bonusPointsAnswer: Answer.Nothing),
  Tracker(title: "go on Tumblr", bonusPointsAnswer: Answer.Nothing),
  Tracker(title: "do at least 1 pull-up", bonusPointsAnswer: Answer.Nothing),
];

class TrackerBrain {
  int _index = 0;
  String date;
  List<Tracker> activeCards;
  List<Tracker> cards;

  TrackerBrain() {
    updateActiveCards();
    this.cards = trackers;
  }

  Tracker currentQuestion() {
    return this.activeCards[_index];
  }

  bool isFirstQuestion() {
    return _index == 0;
  }

  bool isLastQuestion() {
    return _index >= activeCards.length - 1;
  }

  void nextQuestion() {
    _index = min(activeCards.length - 1, ++_index);
  }

  void previousQuestion() {
    _index = max(0, --_index);
  }

  bool doesAnswerByDateEqual(Answer answer) {
    return currentQuestion().doesAnswerByDateEqual(date, answer);
  }

  String getCurrentQuestionText() {
    return currentQuestion().title;
  }

  String getCurrentQuestionTextWithFlavoring() {
    return "Did you " + currentQuestion().title + " today?";
  }

  void answerCurrentQuestion(Answer ans) {
    currentQuestion().setUserAnswerByDate(date, ans);
  }

  int remainingCardCount() {
    return activeCards.length;
  }

  int getCurrentCardIndex() {
    return _index;
  }

  int getTotalCardCount() {
    return activeCards.length;
  }

  List<Tracker> _filterToActiveCards() {
    return List.from(
        trackers.where(notArchived).where(isUnanswered(this.date)));
  }

  void setDate(String date) {
    this.date = date;
  }

  void updateActiveCards() {
    _index = 0;
    this.activeCards = _filterToActiveCards();
    this.activeCards.shuffle();
    //TODO: add setting to sort by random/accsending/added/most yes/most no/ unanswered
  }
}

bool notArchived(Tracker t) => !t.archived;
var isUnanswered = (date) => (Tracker t) => !t.hasAnswer(date);
