import 'dart:convert';

import 'package:The_Friendly_Habit_Journal/data/Date.dart';
import 'package:The_Friendly_Habit_Journal/enums.dart';

class TrackerBean {
  String title;
  Answer bonusPointsAnswer;
  Map<String, Answer> userResponsesByDate;
  bool archived;
  String dateCreated;

  TrackerBean({this.title, this.bonusPointsAnswer}) {
    this.userResponsesByDate = {};
    this.archived = false;
    var date = new Date();
    this.dateCreated = date.getTodayFormatted();
  }

  TrackerBean.fromJson(Map<String, dynamic> json) {
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
