import 'dart:math';

import 'data/Tracker.dart';
import 'enums.dart';

class TrackerBrain {
  int _index = 0;
  List<Tracker> trackers = [
    Tracker(title: "eat oatmeal", bonusPointsAnswer: Answer.Nothing),
    Tracker(title: "work on your sprouts", bonusPointsAnswer: Answer.Nothing),
    Tracker(title: "think about padding", bonusPointsAnswer: Answer.Nothing),
    Tracker(title: "go on Tumblr", bonusPointsAnswer: Answer.Nothing),
    Tracker(title: "do at least 1 pull-up", bonusPointsAnswer: Answer.Nothing),
  ];

  Tracker currentQuestion() {
    return trackers[_index];
  }

  bool isFirstQuestion() {
    return _index == 0;
  }

  bool isLastQuestion() {
    return _index >= trackers.length - 1;
  }

  void nextQuestion() {
    _index = min(trackers.length - 1, ++_index);
  }

  void previousQuestion() {
    _index = max(0, --_index);
  }

  bool doesAnswerByDateEqual(String date, Answer answer) {
    return currentQuestion().doesAnswerByDateEqual(date, answer);
  }

  String getCurrentQuestionText() {
    return currentQuestion().title;
  }

  String getCurrentQuestionTextWithFlavoring(String date) {
    return "Did you " + currentQuestion().title + " today?";
  }

  void answerCurrentQuestion(String date, Answer ans) {
    currentQuestion().setUserAnswerByDate(date, ans);
  }

  int remainingCardCount(String date) {
    //TODO: update to check for date and filter the remaining unanswered
    return trackers.length;
  }

  int getIndex() {
    return _index;
  }

  int getTotal() {
    return trackers.length; //TODO: check on this value if its working good
  }
}