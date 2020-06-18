import 'dart:math';

import 'package:reviewyourday/constants.dart';
import 'package:reviewyourday/data/Percentage.dart';

import 'data/Tracker.dart';
import 'enums.dart';

List<Tracker> trackers = [
  Tracker(
      title: "do at least 1 minute of meditation",
      bonusPointsAnswer: Answer.Nothing),
  Tracker(title: "waste time on reddit", bonusPointsAnswer: Answer.Nothing),
  Tracker(title: "make your own activities", bonusPointsAnswer: Answer.Nothing),
  Tracker(
      title: "brush your teeth in the morning",
      bonusPointsAnswer: Answer.Nothing),
  Tracker(title: "do at least 1 push-up", bonusPointsAnswer: Answer.Nothing),
  Tracker(title: "delete this activity", bonusPointsAnswer: Answer.Nothing),
];

class TrackerBrain {
  int _index = 0;
  String date;
  List<Tracker> activeCards;
  List<Tracker> cards;

  TrackerBrain() {
    updateActiveCards();
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
    return "$kTextBefore ${currentQuestion().title} $kTextAfterToday";
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

  List<Tracker> filterOutArchived() {
    return List.from(trackers.where(notArchived));
  }

  List<Tracker> sorter(SortBy sortMethod) {
    //TODO: move to its own sorter class
    List<Tracker> result = filterOutArchived();
    result.sort((Tracker a, Tracker b) {
      Percentage pa = new Percentage(a);
      Percentage pb = new Percentage(b);
      if (sortMethod == SortBy.DescPercentYes) {
        return pb
            .getPercentYesExclusive()
            .compareTo(pa.getPercentYesExclusive());
      } else if (sortMethod == SortBy.DescPercentNo) {
        return pb.getPercentNoExclusive().compareTo(pa.getPercentNoExclusive());
      } else if (sortMethod == SortBy.DescCountYes) {
        return b.getNumYes().compareTo(a.getNumYes());
      } else if (sortMethod == SortBy.DescCountNo) {
        return b.getNumNo().compareTo(a.getNumNo());
      }
      return pb.getPercentYesExclusive().compareTo(pa.getPercentNoExclusive());
    });
    return result;
  }

  void add(String title) {
    Tracker t = Tracker(title: title, bonusPointsAnswer: Answer.Nothing);
    trackers.add(t);
  }

  void remove(Tracker t) {
    trackers.remove(t);
  }
}

bool notArchived(Tracker t) => !t.archived;
var isUnanswered = (date) => (Tracker t) => !t.hasAnswer(date);
