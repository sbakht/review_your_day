import 'dart:math';

import 'package:The_Friendly_Habit_Journal/constants.dart';
import 'package:The_Friendly_Habit_Journal/data/Percentage.dart';
import 'package:The_Friendly_Habit_Journal/data/Snapshot.dart';
import 'package:The_Friendly_Habit_Journal/data/Tracker.dart';
import 'package:The_Friendly_Habit_Journal/data/Trackers.dart';
import 'package:The_Friendly_Habit_Journal/database/TrackerDAO.dart';
import 'package:The_Friendly_Habit_Journal/enums.dart';

enum DATE { Today, Yesterday }

class TrackerBrain {
  int _index = 0;
  String date;
  String yesterdayDate;
  Trackers trackers;
  List<Tracker> activeCards;
  List<Tracker> yesterdayActiveCards;
  List<Tracker> cards;
  TrackerDAO trackerDAO;
  DATE mode;
  Snapshot todaySnapshot;
  Snapshot yesterdaySnapshot;

  TrackerBrain(List<Tracker> trackers) {
    this.trackerDAO = new TrackerDAO();
    this.trackers = new Trackers(trackers);
    updateActiveCards();
  }

  TrackerBrain.fromJson(Map<String, dynamic> json) {
    //TODO: stop using separate constructor to remake object on load
    this.trackerDAO = new TrackerDAO();
    this.trackers = Trackers.fromJson(json);
    updateActiveCards(); //TODO: this needs to rerun (acting like constructor)
  }

  Map<String, dynamic> toJson() {
    return trackers.toJson();
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
      return yesterdaySnapshot.doesAnswerEqual(question, answer);
    } else {
      return todaySnapshot.doesAnswerEqual(question, answer);
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
      yesterdaySnapshot.setAnswer(question, ans);
    } else {
      todaySnapshot.setAnswer(question, ans);
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
    return trackers.getUnanswered(date);
  }

  void setDate({String date, String yesterdayDate}) {
    this.date = date;
    this.yesterdayDate = yesterdayDate;
    this.todaySnapshot = new Snapshot(date, trackers);
    this.yesterdaySnapshot = new Snapshot(yesterdayDate, trackers);
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
    return trackers.filterOutArchived();
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
    save();
  }

  void remove(Tracker t) {
    trackers.remove(t);
    save();
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

  void save() {
    trackerDAO.save(this);
  }

  static Future<TrackerBrain> fetch() async {
    TrackerDAO trackerDAO = new TrackerDAO();
    return await trackerDAO.fetch();
  }
}

bool notArchived(Tracker t) => !t.archived;
