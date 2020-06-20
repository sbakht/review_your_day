import 'package:The_Friendly_Habit_Journal/data/Date.dart';
import 'package:The_Friendly_Habit_Journal/data/ReviewGame.dart';
import 'package:The_Friendly_Habit_Journal/data/Sort.dart';
import 'package:The_Friendly_Habit_Journal/data/Tracker.dart';
import 'package:The_Friendly_Habit_Journal/data/Trackers.dart';
import 'package:The_Friendly_Habit_Journal/database/TrackerDAO.dart';
import 'package:The_Friendly_Habit_Journal/enums.dart';

enum DATE { Today, Yesterday }

class TrackerBrain {
  Trackers trackers;
  TrackerDAO trackerDAO;
  ReviewGame todayGame;
  ReviewGame yesterdayGame;
  Sort sorter;

  TrackerBrain(List<Tracker> trackers) {
    this.trackerDAO = new TrackerDAO();
    this.trackers = new Trackers(trackers);
    this.sorter = new Sort(this.trackers);
    this.updateDates();
  }

  TrackerBrain.fromJson(Map<String, dynamic> json) {
    //TODO: stop using separate constructor to remake object on load
    this.trackerDAO = new TrackerDAO();
    this.trackers = Trackers.fromJson(json);
    this.sorter = new Sort(this.trackers);
    this.updateDates();
  }

  Map<String, dynamic> toJson() {
    return trackers.toJson();
  }

  void updateDates() {
    Date date = new Date();
    String today = date.getTodayFormatted();
    String yesterday = date.getYesterdayFormatted();
    this.todayGame = new ReviewGame(today, trackers);
    this.yesterdayGame = new ReviewGame(yesterday, trackers);
  }

  ReviewGame getReviewGame(DATE date) {
    if (date == DATE.Yesterday) {
      return yesterdayGame;
    } else {
      return todayGame;
    }
  }

  List<Tracker> sort(SortBy sortMethod) {
    return sorter.sort(sortMethod);
  }

  void add(String title) {
    Tracker t = Tracker(title: title, bonusPointsAnswer: Answer.Nothing);
    trackers.add(t);
    this.save();
  }

  void remove(Tracker t) {
    trackers.remove(t);
    this.save();
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
