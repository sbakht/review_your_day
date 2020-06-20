import 'package:The_Friendly_Habit_Journal/data/Tracker.dart';
import 'package:The_Friendly_Habit_Journal/enums.dart';
import 'package:flutter/material.dart';

const kSelectedColor = Color(0xFF03A9F4);
const kSecondaryTextColor = Colors.grey;
const kTextBefore = "Did I";
const kTextAfterToday = "today?";
const kTextAfterYesterday = "yesterday?";
//const kAnswerTextStyle = TextStyle(fontSize: 60);

List<Tracker> trackersStore = [
  Tracker(title: "surf on youtube", bonusPointsAnswer: Answer.Nothing),
  Tracker(title: "make your own activities", bonusPointsAnswer: Answer.Nothing),
  Tracker(title: "do at least 1 push-up", bonusPointsAnswer: Answer.Nothing),
  Tracker(title: "delete these activities", bonusPointsAnswer: Answer.Nothing),
];
