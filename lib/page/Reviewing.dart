import 'package:The_Friendly_Habit_Journal/TrackerBrain.dart';
import 'package:The_Friendly_Habit_Journal/constants.dart';
import 'package:The_Friendly_Habit_Journal/data/ReviewGame.dart';
import 'package:The_Friendly_Habit_Journal/enums.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

const kAnswerTextStyle = TextStyle(fontSize: 60);

class ReviewingGame extends StatefulWidget {
  @override
  _ReviewingGameState createState() => _ReviewingGameState();
}

class _ReviewingGameState extends State<ReviewingGame> {
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = ModalRoute.of(context).settings.arguments;
    TrackerBrain trackerBrain = map['trackerBrain'];
    DATE date = map['date'];
    ReviewGame snapshot = trackerBrain.getReviewGame(date);
    var cardIndex = snapshot.getIndex();
    var total = snapshot.getNumCards();

    lastQuestionCheck() {
      if (snapshot.isLastQuestion()) {
        Navigator.pop(context);
      }
    }

    next() {
      lastQuestionCheck();
      buttonCarouselController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.linear);
    }

    previous() {
      snapshot.previousQuestion();
      buttonCarouselController.previousPage();
    }

    return Scaffold(
        //TODO: refactor into widgets, pass in the onPress to make it easier to find and modify
        appBar: AppBar(
          title: Text(date == DATE.Today
              ? "Reviewing Your Day"
              : "Reviewing Yesterday"),
          actions: [
            //TODO: setting to show or hide progress and/or number progress count
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Center(
                  child: Text("" +
                      (cardIndex + 1).toString() +
                      "/" +
                      total.toString() +
                      "")),
            ),
            IconButton(
              icon: Icon(Icons.chevron_left),
              tooltip: 'Previous Question',
              onPressed:
                  snapshot.isFirstQuestion() ? null : () => setState(previous),
            ),
            IconButton(
              icon: Icon(Icons.chevron_right),
              tooltip: 'Next Question',
              onPressed: snapshot.isLastQuestion() ? null : next,
            ),
          ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(value: cardIndex / total),
            Expanded(
                child: CarouselSlider(
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  onPageChanged: (i, reason) {
                    setState(() {
                      if (snapshot.isNextQuestionIndex(i)) {
                        snapshot.nextQuestion();
                      } else {
                        snapshot.previousQuestion();
                      }
                    });
                  }),
              items: snapshot
                  .getCards()
                  .map((item) => Container(
                        child: Card(
                          color: Colors.black,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  child: Text("Did I " + item.title + "?",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 30)),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: FlatButton(
                                        child: Text(
                                          "YES",
                                          style: kAnswerTextStyle.copyWith(
                                            color: snapshot.doesAnswerEqual(
                                                    item, Answer.Yes)
                                                ? kSelectedColor
                                                : null,
                                          ),
                                        ),
                                        onPressed: () {
                                          snapshot.setAnswer(item, Answer.Yes);
                                          next();
                                          trackerBrain.save();
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: FlatButton(
                                        child: Text(
                                          "NO",
                                          style: kAnswerTextStyle.copyWith(
                                            color: snapshot.doesAnswerEqual(
                                                    item, Answer.No)
                                                ? kSelectedColor
                                                : null,
                                          ),
                                        ),
                                        onPressed: () {
                                          snapshot.setAnswer(item, Answer.No);
                                          next();
                                          trackerBrain.save();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            )),
          ],
        ));
  }
}
