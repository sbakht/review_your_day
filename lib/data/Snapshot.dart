import 'package:The_Friendly_Habit_Journal/data/Tracker.dart';
import 'package:The_Friendly_Habit_Journal/data/Trackers.dart';
import 'package:The_Friendly_Habit_Journal/enums.dart';

class Snapshot {
  String date;
  Trackers trackers;

  Snapshot(this.date, this.trackers);

  bool doesAnswerEqual(Tracker question, Answer answer) {
    return question.doesAnswerByDateEqual(date, answer);
  }

  void setAnswer(Tracker question, Answer ans) {
    question.setUserAnswerByDate(date, ans);
  }

  getDate() {
    return date;
  }
}
