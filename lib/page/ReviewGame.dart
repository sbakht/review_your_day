import 'package:flutter/material.dart';

import '../TestData.dart';
import '../enums.dart';

class ReviewGame extends StatefulWidget {
  @override
  _ReviewGameState createState() => _ReviewGameState();
}

class _ReviewGameState extends State<ReviewGame> {
  int date = 17;
  TrackerBrain trackerBrain = new TrackerBrain();

  @override
  Widget build(BuildContext context) {
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
            Text(trackerBrain.getCurrentQuestionText()),
            Row(
              children: [
                FlatButton(
                  child: Text("YES"),
                  color: trackerBrain.doesAnswerByDateEqual(date, Answer.Yes)
                      ? Colors.blueGrey
                      : null,
                  onPressed: () {
                    setState(() {
                      answerQuestion(Answer.Yes);
                      goToNextQuestion();
                    });
                  },
                ),
                FlatButton(
                  child: Text("NO"),
                  color: trackerBrain.doesAnswerByDateEqual(date, Answer.No)
                      ? Colors.blueGrey
                      : null,
                  onPressed: () {
                    setState(() {
                      answerQuestion(Answer.No);
                      goToNextQuestion();
                    });
                  },
                ),
              ],
            ),
          ],
        ));
  }

  void answerQuestion(Answer ans) {
    trackerBrain.answerCurrentQuestion(date, ans);
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
