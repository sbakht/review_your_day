import 'package:flutter/material.dart';
import 'package:reviewyourday/data/Tracker.dart';

import '../TestData.dart';
import '../enums.dart';

class ReviewGame extends StatefulWidget {
  @override
  _ReviewGameState createState() => _ReviewGameState();
}

class _ReviewGameState extends State<ReviewGame> {
  TrackerBrain trackerBrain = new TrackerBrain();

  @override
  Widget build(BuildContext context) {
    Tracker tracker = trackerBrain.currentQuestion();
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
                        goToPreviousQuestion();
                      });
                    },
            ),
            IconButton(
              icon: Icon(Icons.chevron_right),
              tooltip: 'Next Question',
              onPressed: isLastQuestion()
                  ? null
                  : () {
                      setState(() {
                        goToNextQuestion();
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
//                  color: Colors.blue,
                  color: tracker.isAlreadyAnsweredWith(17, Answer.Yes)
                      ? Colors.blueGrey
                      : null,
                  onPressed: () {
                    setState(() {
                      answerQuestion(Answer.Yes, tracker);
                      goToNextQuestion();
                    });
                  },
                ),
                FlatButton(
                  child: Text("NO"),
                  color: tracker.isAlreadyAnsweredWith(17, Answer.No)
                      ? Colors.blueGrey
                      : null,
                  onPressed: () {
                    setState(() {
                      answerQuestion(Answer.No, tracker);
                      goToNextQuestion();
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

  bool isFirstQuestion() {
    return trackerBrain.isFirstQuestion();
  }

  bool isLastQuestion() {
    return trackerBrain.isLastQuestion();
  }

  void goToNextQuestion() {
    trackerBrain.nextQuestion();
  }

  void goToPreviousQuestion() {
    trackerBrain.previousQuestion();
  }
}
