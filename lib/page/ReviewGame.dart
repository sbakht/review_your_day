import 'package:flutter/material.dart';

import '../TestData.dart';
import '../constants.dart';
import '../enums.dart';

const kAnswerTextStyle = TextStyle(fontSize: 50);

class ReviewGame extends StatefulWidget {
  @override
  _ReviewGameState createState() => _ReviewGameState();
}

class _ReviewGameState extends State<ReviewGame> {
  TrackerBrain trackerBrain = new TrackerBrain();

  @override
  Widget build(BuildContext context) {
    String date = ModalRoute.of(context).settings.arguments;
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Text(
                  trackerBrain.getCurrentQuestionTextWithFlavoring(date),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30)),
            ),
            Row(
              children: [
                Expanded(
                  child: FlatButton(
                    child: Text(
                      "YES",
                      style: kAnswerTextStyle.copyWith(
                        color:
                            trackerBrain.doesAnswerByDateEqual(date, Answer.Yes)
                                ? kSelectedColor
                                : null,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        answerQuestion(date, Answer.Yes);
                        goToNextQuestion();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    child: Text(
                      "NO",
                      style: kAnswerTextStyle.copyWith(
                        color:
                            trackerBrain.doesAnswerByDateEqual(date, Answer.No)
                                ? kSelectedColor
                                : null,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        answerQuestion(date, Answer.No);
                        goToNextQuestion();
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  void answerQuestion(String date, Answer ans) {
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
