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

  bool doesAnswerByDateEqual(int date, Answer answer) {
    return currentQuestion().doesAnswerByDateEqual(date, answer);
  }

  String getCurrentQuestionText() {
    return currentQuestion().title;
  }

  void answerCurrentQuestion(int date, Answer ans) {
    currentQuestion().setUserAnswerByDate(date, ans);
  }
}
