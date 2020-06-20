import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'file:///C:/Users/saad/AndroidStudioProjects/review_your_day/lib/database/TrackerDAO.dart';

import '../TrackerBrain.dart';
import '../constants.dart';
import '../enums.dart';

const kAnswerTextStyle = TextStyle(fontSize: 60);

class ReviewGame extends StatefulWidget {
  @override
  _ReviewGameState createState() => _ReviewGameState();
}

class _ReviewGameState extends State<ReviewGame> {
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = ModalRoute.of(context).settings.arguments;
    TrackerBrain trackerBrain = map['trackerBrain'];
    TrackerDAO storage = map['storage'];
    var index = trackerBrain.getCurrentCardIndex();
    var total = trackerBrain.getTotalCardCount();

    lastQuestionCheck() {
      if (trackerBrain.isLastQuestion()) {
        Navigator.pop(context);
      }
    }

    next() {
      lastQuestionCheck();
      buttonCarouselController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.linear);
    }

    previous() {
      trackerBrain.previousQuestion();
      buttonCarouselController.previousPage();
    }

    return Scaffold(
        //TODO: refactor into widgets, pass in the onPress to make it easier to find and modify
        appBar: AppBar(
          title: Text("Reviewing Your Day"),
          actions: [
            //TODO: setting to show or hide progress and/or number progress count
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Center(
                  child: Text("" +
                      (index + 1).toString() +
                      "/" +
                      total.toString() +
                      "")),
            ),
            IconButton(
              icon: Icon(Icons.chevron_left),
              tooltip: 'Previous Question',
              onPressed: trackerBrain.isFirstQuestion()
                  ? null
                  : () => setState(previous),
            ),
            IconButton(
              icon: Icon(Icons.chevron_right),
              tooltip: 'Next Question',
              onPressed: trackerBrain.isLastQuestion() ? null : next,
            ),
          ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(value: index / total),
            Expanded(
                child: CarouselSlider(
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  onPageChanged: (i, reason) {
                    setState(() {
                      if (trackerBrain.isNextQuestionIndex(i)) {
                        trackerBrain.nextQuestion();
                      } else {
                        trackerBrain.previousQuestion();
                      }
                    });
                  }),
              items: trackerBrain
                  .getActiveCards()
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
                                  child: Text("Did I " + item.title,
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
                                            color: trackerBrain
                                                    .doesAnswerByDateEqual(
                                                        item, Answer.Yes)
                                                ? kSelectedColor
                                                : null,
                                          ),
                                        ),
                                        onPressed: () {
                                          trackerBrain.answerCurrentQuestion(
                                              item, Answer.Yes);
                                          next();
                                          storage.save(trackerBrain);
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: FlatButton(
                                        child: Text(
                                          "NO",
                                          style: kAnswerTextStyle.copyWith(
                                            color: trackerBrain
                                                    .doesAnswerByDateEqual(
                                                        item, Answer.No)
                                                ? kSelectedColor
                                                : null,
                                          ),
                                        ),
                                        onPressed: () {
                                          trackerBrain.answerCurrentQuestion(
                                              item, Answer.No);
                                          next();
                                          storage.save(trackerBrain);
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
