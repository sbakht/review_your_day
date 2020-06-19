import 'dart:math';

import 'constants.dart';
import 'data/Percentage.dart';
import 'data/Tracker.dart';
import 'enums.dart';

enum DATE { Today, Yesterday }

class TrackerBrain {
  int _index = 0;
  String date;
  String yesterdayDate;
  List<Tracker> trackers;
  List<Tracker> activeCards;
  List<Tracker> yesterdayActiveCards;
  List<Tracker> cards;
  DATE mode;

  TrackerBrain(trackersStore) {
    this.trackers = trackersStore;
    updateActiveCards();
  }

  Tracker currentQuestion() {
    return this.getActiveCards()[_index];
  }

  bool isFirstQuestion() {
    return _index == 0;
  }

  bool isLastQuestion() {
    return _index >= getActiveCards().length - 1;
  }

  void nextQuestion() {
    _index = min(getActiveCards().length - 1, ++_index);
  }

  void previousQuestion() {
    _index = max(0, --_index);
  }

  bool doesAnswerByDateEqual(Tracker question, Answer answer) {
    if (mode == DATE.Yesterday) {
      return question.doesAnswerByDateEqual(yesterdayDate, answer);
    } else {
      return question.doesAnswerByDateEqual(date, answer);
    }
  }

  String getCurrentQuestionText() {
    return currentQuestion().title;
  }

  String getCurrentQuestionTextWithFlavoring() {
    return "$kTextBefore ${currentQuestion().title}?";
  }

  void answerCurrentQuestion(Tracker question, Answer ans) {
    if (mode == DATE.Yesterday) {
      question.setUserAnswerByDate(yesterdayDate, ans);
    } else {
      question.setUserAnswerByDate(date, ans);
    }
  }

  int remainingCardCount() {
    return activeCards.length;
  }

  int getCurrentCardIndex() {
    return _index;
  }

  int getTotalCardCount() {
    return getActiveCards().length;
  }

  List<Tracker> _filterToActiveCards(String date) {
    return List.from(trackers.where(notArchived).where(isUnanswered(date)));
  }

  void setDate({String date, String yesterdayDate}) {
    this.date = date;
    this.yesterdayDate = yesterdayDate;
  }

  void updateActiveCards() {
    _index = 0;
    this.activeCards = _filterToActiveCards(this.date);
    this.yesterdayActiveCards = _filterToActiveCards(this.yesterdayDate);
    this.activeCards.shuffle();
    this.yesterdayActiveCards.shuffle();
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

  TrackerBrain.fromJson(Map<String, dynamic> json) {
    this.trackers = [];
    json.forEach((key, value) {
      this.trackers.add(Tracker.fromJson(value));
    });
    updateActiveCards(); //TODO: this needs to rerun (acting like constructor)
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    int i = 0;
    this.trackers.forEach((t) {
      map[i.toString()] = t.toJson();
      i++;
    });

    return map;
  }

  //TODO: refactor this to a better implementation
  int remainingCardCountYesterday() {
    return yesterdayActiveCards.length;
  }

  void setMode(DATE d) {
    this.mode = d;
  }

  List<Tracker> getActiveCards() {
    if (mode == DATE.Yesterday) {
      return yesterdayActiveCards;
    } else {
      return activeCards;
    }
  }

  bool isNextQuestionIndex(int i) {
    return i > _index;
  }
}

bool notArchived(Tracker t) => !t.archived;
var isUnanswered = (date) => (Tracker t) => !t.hasAnswer(date);
