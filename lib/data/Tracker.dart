import 'dart:convert';

import '../enums.dart';
import 'Date.dart';

class Tracker {
  String title;
  Answer bonusPointsAnswer;
  Map<String, Answer> userResponsesByDate;
  bool archived;
  String dateCreated;

  Tracker({this.title, this.bonusPointsAnswer}) {
    this.userResponsesByDate = {};
    this.archived = false;
    var date = new Date();
    this.dateCreated = date.getTodayFormatted();
//    if (this.title == "eat oatmeal") {
//      this.dateCreated = "6.10.2020";
//      userResponsesByDate["6.16.2020"] = Answer.Yes;
//      userResponsesByDate["6.15.2020"] = Answer.Yes;
//      userResponsesByDate["6.11.2020"] = Answer.Yes;
//      userResponsesByDate["6.14.2020"] = Answer.No;
//    }
//    if (this.title == "think about padding") {
//      this.dateCreated = "6.10.2020";
//      userResponsesByDate["6.16.2020"] = Answer.No;
//    }
  }

  void setUserAnswerByDate(String date, Answer ans) {
    userResponsesByDate[date] = ans;
  }

  doesAnswerByDateEqual(String date, Answer ans) {
    return this.userResponsesByDate[date] == ans;
  }

  bool hasAnswer(date) {
    var answer = this.userResponsesByDate[date];
    return answer == Answer.Yes || answer == Answer.No;
  }

  //TODO: make statistics class
  int getNumYes() {
    return getKeyCount(userResponsesByDate, Answer.Yes);
  }

  int getNumNo() {
    return getKeyCount(userResponsesByDate, Answer.No);
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
    userResponsesByDate = {};
    archived = json['archived'];
    jsonDecode(json['userResponsesByDate']).forEach((key, value) {
      if (value == 1) {
        userResponsesByDate[key] = Answer.Yes;
      } else if (value == 2) {
        userResponsesByDate[key] = Answer.No;
      }
    });
  }

  Map<String, dynamic> toJson() {
    Map<String, int> map = {};
    userResponsesByDate.forEach((key, value) {
      if (value == Answer.Yes) {
        map[key] = 1;
      } else if (value == Answer.No) {
        map[key] = 2;
      } else {
        map[key] = 0;
      }
    });
    return {
      'title': title,
      'created': dateCreated,
      'archived': archived,
      'userResponsesByDate': jsonEncode(map),
    };
  }
}

int getKeyCount(Map map, Answer expected) {
  int count = 0;
  map.forEach((date, answer) {
    if (answer == expected) {
      count++;
    }
  });
  return count;
}
