import 'package:The_Friendly_Habit_Journal/constants.dart';
import 'package:The_Friendly_Habit_Journal/data/Percentage.dart';
import 'package:The_Friendly_Habit_Journal/data/Tracker.dart';
import 'package:flutter/material.dart';

Widget tableEntry(Tracker t, int index) {
  Percentage percentage = new Percentage(t);
  int percentYesExcludeNA = percentage.getPercentYesExclusive();
  int percentNoExcludeNA = percentage.getPercentNoExclusive();

  return Row(
    children: [
      Text(
        percentYesExcludeNA == 0 ? "00" : "",
        style: TextStyle(
            color: index % 2 == 0 ? kTableShadedColor : kBackgroundColor),
      ),
      Text(
        percentYesExcludeNA > 0 && percentYesExcludeNA < 100 ? "0" : "",
        style: TextStyle(
            color: index % 2 == 0 ? kTableShadedColor : kBackgroundColor),
      ),
      Text(
        percentage.format(percentYesExcludeNA),
        textAlign: TextAlign.right,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(width: 10),
      Text(
        percentNoExcludeNA == 0 ? "00" : "",
        style: TextStyle(
            color: index % 2 == 0 ? kTableShadedColor : kBackgroundColor),
      ),
      Text(
        percentNoExcludeNA > 0 && percentNoExcludeNA < 100 ? "0" : "",
        style: TextStyle(
            color: index % 2 == 0 ? kTableShadedColor : kBackgroundColor),
      ),
      Text(
        percentage.format(percentNoExcludeNA),
        textAlign: TextAlign.right,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
  );
}
