import 'package:flutter/material.dart';

import 'YesNoButtons.dart';

Container buildCard({questionText, answer, onAnswer}) {
  return Container(
    child: Card(
      color: Colors.black,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildQuestionText(questionText),
          Expanded(
            flex: 2,
            child: Row(
              children: buildYesNoButtons(answer: answer, onPress: onAnswer),
            ),
          ),
        ],
      ),
    ),
  );
}

Expanded buildQuestionText(String question) {
  return Expanded(
    flex: 1,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Text("Did I " + question + "?",
          textAlign: TextAlign.left, style: TextStyle(fontSize: 30)),
    ),
  );
}
