import 'package:flutter/material.dart';

import 'data/Tracker.dart';
import 'enums.dart';

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
