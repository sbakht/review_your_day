import 'package:The_Friendly_Habit_Journal/constants.dart';
import 'package:The_Friendly_Habit_Journal/enums.dart';
import 'package:flutter/material.dart';

const kAnswerTextStyle = TextStyle(fontSize: 60);

List<Widget> buildYesNoButtons({Answer answer, Function onPress}) {
  return [
    buildButton("YES", Answer.Yes, answer, onPress),
    buildButton("NO", Answer.No, answer, onPress),
  ];
}

Expanded buildButton(
    String text, Answer expectedAnswer, Answer userAnswer, onPress) {
  return Expanded(
    child: FlatButton(
      child: Text(
        text,
        style: kAnswerTextStyle.copyWith(
          color: userAnswer == expectedAnswer ? kSelectedColor : null,
        ),
      ),
      onPressed: () {
        onPress(expectedAnswer);
      },
    ),
  );
}
