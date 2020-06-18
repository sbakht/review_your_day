import 'package:flutter/material.dart';
import 'package:reviewyourday/data/Storage.dart';

import '../TrackerBrain.dart';
import '../constants.dart';
import '../enums.dart';

const kAnswerTextStyle = TextStyle(fontSize: 50);

class ReviewGame extends StatefulWidget {
  @override
  _ReviewGameState createState() => _ReviewGameState();
}

class _ReviewGameState extends State<ReviewGame> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = ModalRoute.of(context).settings.arguments;
    TrackerBrain trackerBrain = map['trackerBrain'];
    BrainStorage storage = map['storage'];
    var index = trackerBrain.getCurrentCardIndex();
    var total = trackerBrain.getTotalCardCount();

    finishedCheck() {
      if (trackerBrain.isLastQuestion()) {
        Navigator.pop(context);
      }
    }

    next() {
      finishedCheck();
      trackerBrain.nextQuestion();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Reviewing Your Day"),
          actions: [
            //TODO: setting to show or hide progress and/or number progress count
            Center(
                child: Text(
                    "" + (index + 1).toString() + "/" + total.toString() + "")),
            IconButton(
              icon: Icon(Icons.chevron_left),
              tooltip: 'Previous Question',
              onPressed: trackerBrain.isFirstQuestion()
                  ? null
                  : () => setState(trackerBrain.previousQuestion),
            ),
            IconButton(
              icon: Icon(Icons.chevron_right),
              tooltip: 'Next Question',
              onPressed: () => setState(next),
            ),
          ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(value: index / total),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Text(
                        trackerBrain.getCurrentQuestionTextWithFlavoring(),
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
                                  trackerBrain.doesAnswerByDateEqual(Answer.Yes)
                                      ? kSelectedColor
                                      : null,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              trackerBrain.answerCurrentQuestion(Answer.Yes);
                              next();
                              storage.writeBrain(trackerBrain);
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
                                  trackerBrain.doesAnswerByDateEqual(Answer.No)
                                      ? kSelectedColor
                                      : null,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              trackerBrain.answerCurrentQuestion(Answer.No);
                              next();
                              storage.writeBrain(trackerBrain);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
