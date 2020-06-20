import 'dart:convert';

import 'package:The_Friendly_Habit_Journal/data/Answers.dart';
import 'package:The_Friendly_Habit_Journal/data/Date.dart';
import 'package:The_Friendly_Habit_Journal/enums.dart';

class Tracker {
  String title;
  Answer bonusPointsAnswer;
  Answers answers;
  bool archived;
  String dateCreated;

  Tracker({this.title, this.bonusPointsAnswer}) {
    this.answers = new Answers();
    this.archived = false;
    var date = new Date();
    this.dateCreated = date.getTodayFormatted();
  }

  void setUserAnswerByDate(String date, Answer ans) {
    answers.setAnswer(date, ans);
  }

  doesAnswerByDateEqual(String date, Answer ans) {
    return answers.getAnswer(date) == ans;
  }

  bool hasAnswer(date) {
    var answer = answers.getAnswer(date);
    return answer == Answer.Yes || answer == Answer.No;
  }

  //TODO: make statistics class
  int getNumYes() {
    return getKeyCount(answers, Answer.Yes);
  }

  int getNumNo() {
    return getKeyCount(answers, Answer.No);
  }

  int _daysSinceCreated() {
    DateTime start = Date.fromFormatted(dateCreated);
    DateTime today = Date().today;
    return today.difference(start).inDays + 1;
  }

  int getNumNA() {
    return _daysSinceCreated() - getNumNo() - getNumYes();
  }

  Tracker.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    dateCreated = json['created'];
    archived = json['archived'];
    answers = Answers.fromJson(jsonDecode(json['userResponsesByDate']));
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'created': dateCreated,
      'archived': archived,
      'userResponsesByDate': jsonEncode(answers.toJson()),
    };
  }
}

int getKeyCount(Answers map, Answer expected) {
  int count = 0;
  map.getData().forEach((date, answer) {
    if (answer == expected) {
      count++;
    }
  });
  return count;
}
