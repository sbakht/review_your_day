import 'package:flutter/material.dart';
import 'package:reviewyourday/data/Tracker.dart';

import '../TestData.dart';
import '../enums.dart';

class ReviewGame extends StatefulWidget {
  @override
  _ReviewGameState createState() => _ReviewGameState();
}

class _ReviewGameState extends State<ReviewGame> {
  int _questionIndex = 0;

  @override
  Widget build(BuildContext context) {
    Tracker tracker = trackers[_questionIndex];
    return Scaffold(
        appBar: AppBar(
          title: Text("Review Game"),
          actions: [
            IconButton(
              icon: Icon(Icons.chevron_left),
              tooltip: 'Previous Question',
              onPressed: isFirstQuestion()
                  ? null
                  : () {
                      setState(() {
                        _questionIndex--;
                      });
                    },
            ),
            FlatButton(
              child: Text("Skip"),
              onPressed: isLastQuestion()
                  ? null
                  : () {
                      setState(() {
                        _questionIndex++;
                      });
                    },
            ),
          ],
        ),
        body: Column(
          children: [
            Text(tracker.title),
            Row(
              children: [
                FlatButton(
                  child: Text("YES"),
                  onPressed: () {
                    setState(() {
                      answerQuestion(Answer.Yes, tracker);
                      _questionIndex++;
                    });
                  },
                ),
                FlatButton(
                  child: Text("NO"),
                  onPressed: () {
                    setState(() {
                      answerQuestion(Answer.No, tracker);
                      _questionIndex++;
                    });
                  },
                ),
              ],
            ),
          ],
        ));
  }

  void answerQuestion(Answer ans, Tracker tracker) {
    tracker.setUserAnswer(ans);
  }

  isFirstQuestion() {
    return _questionIndex == 0;
  }

  isLastQuestion() {
    //TODO: move to brain file
    return _questionIndex >= trackers.length - 1;
  }
}
