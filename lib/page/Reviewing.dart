import 'package:The_Friendly_Habit_Journal/TrackerBrain.dart';
import 'package:The_Friendly_Habit_Journal/bloc/review/bloc.dart';
import 'package:The_Friendly_Habit_Journal/constants.dart';
import 'package:The_Friendly_Habit_Journal/data/ReviewGame.dart';
import 'package:The_Friendly_Habit_Journal/data/Tracker.dart';
import 'package:The_Friendly_Habit_Journal/enums.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    lastQuestionCheck(snapshot) {
      if (snapshot.isLastQuestion()) {
        Navigator.pop(context);
      }
    }

    next(snapshot) {
      lastQuestionCheck(snapshot);
      buttonCarouselController.nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.linear);
    }

    previous() {
      buttonCarouselController.previousPage(
          duration: Duration(milliseconds: 200), curve: Curves.linear);
    }

    return BlocProvider<ReviewBloc>(
      create: (context) => ReviewBloc(trackerBrain: trackerBrain),
      child:
          BlocBuilder<ReviewBloc, ReviewState>(builder: (context, reviewState) {
        // ignore: close_sinks
        ReviewBloc reviewBloc = BlocProvider.of<ReviewBloc>(context);

        var cardIndex = 0;
        var total = 1;
        ReviewGame snapshot;
        if (reviewState is InitialReviewState) {
          return Container();
        }
        if (reviewState is ReviewingState) {
          cardIndex = reviewState.game.getIndex();
          total = reviewState.game.getNumCards();
          snapshot = reviewState.game;
        }

        return Scaffold(
            //TODO: refactor into widgets, pass in the onPress to make it easier to find and modify
            appBar: AppBar(
              title: buildTitle(date),
              //TODO: setting to show or hide progress and/or number progress count
              actions: buildPagination(
                  index: cardIndex,
                  total: total,
                  snapshot: snapshot,
                  next: next,
                  previous: previous),
            ),
            body: Column(
              children: [
                LinearProgressIndicator(value: cardIndex / total),
                Expanded(
                    child: CarouselSlider(
                  carouselController: buttonCarouselController,
                  options: buildCarouselOptions(context, snapshot, reviewBloc),
                  items: snapshot
                      .getCards()
                      .map((item) =>
                          buildCard(item, snapshot, next, trackerBrain))
                      .toList(),
                )),
              ],
            ));
      }),
    );
  }

  Container buildCard(Tracker item, ReviewGame snapshot, next(dynamic snapshot),
      TrackerBrain trackerBrain) {
    return Container(
      child: Card(
        color: Colors.black,
        margin: EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildQuestionText(item),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  buildYES(snapshot, item, next, trackerBrain),
                  buildNO(snapshot, item, next, trackerBrain),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildQuestionText(Tracker item) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Text("Did I " + item.title + "?",
            textAlign: TextAlign.left, style: TextStyle(fontSize: 30)),
      ),
    );
  }

  Expanded buildNO(ReviewGame snapshot, Tracker item, next(dynamic snapshot),
      TrackerBrain trackerBrain) {
    return Expanded(
      child: FlatButton(
        child: Text(
          "NO",
          style: kAnswerTextStyle.copyWith(
            color: snapshot.doesAnswerEqual(item, Answer.No)
                ? kSelectedColor
                : null,
          ),
        ),
        onPressed: () {
          snapshot.setAnswer(item, Answer.No);
          next(snapshot);
          trackerBrain.save();
//                                                myBloc.add(TrackerSave());
        },
      ),
    );
  }

  Expanded buildYES(ReviewGame snapshot, Tracker item, next(dynamic snapshot),
      TrackerBrain trackerBrain) {
    return Expanded(
      child: FlatButton(
        child: Text(
          "YES",
          style: kAnswerTextStyle.copyWith(
            color: snapshot.doesAnswerEqual(item, Answer.Yes)
                ? kSelectedColor
                : null,
          ),
        ),
        onPressed: () {
          snapshot.setAnswer(item, Answer.Yes);
          next(snapshot);
          trackerBrain.save();
//                                                myBloc.add(TrackerSave());
        },
      ),
    );
  }

  CarouselOptions buildCarouselOptions(
      BuildContext context, ReviewGame snapshot, ReviewBloc reviewBloc) {
    return CarouselOptions(
        height: MediaQuery.of(context).size.height,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        onPageChanged: (i, reason) {
          onCardChange(snapshot, i, reviewBloc);
        });
  }

  void onCardChange(ReviewGame snapshot, int i, ReviewBloc reviewBloc) {
    return setState(() {
      if (snapshot.isNextQuestionIndex(i)) {
        reviewBloc.add(EventReviewNextQuestion());
      } else {
        reviewBloc.add(EventReviewPreviousQuestion());
      }
    });
  }

  List<Widget> buildPagination({index, total, snapshot, next, previous}) {
    return [
      buildPaginationNumbers(index, total),
      buildPaginationLeftArrow(snapshot, previous),
      buildPaginationRightArrow(snapshot, next),
    ];
  }

  IconButton buildPaginationRightArrow(
      ReviewGame snapshot, next(dynamic snapshot)) {
    return IconButton(
      icon: Icon(Icons.chevron_right),
      tooltip: 'Next Question',
      onPressed: snapshot.isLastQuestion() ? null : () => next(snapshot),
    );
  }

  IconButton buildPaginationLeftArrow(ReviewGame snapshot, previous()) {
    return IconButton(
        icon: Icon(Icons.chevron_left),
        tooltip: 'Previous Question',
        onPressed:
            snapshot.isFirstQuestion() ? null : () => setState(previous));
  }

  Container buildPaginationNumbers(int cardIndex, int total) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Center(
          child: Text(
              "" + (cardIndex + 1).toString() + "/" + total.toString() + "")),
    );
  }

  Text buildTitle(DATE date) {
    return Text(
        date == DATE.Today ? "Reviewing Your Day" : "Reviewing Yesterday");
  }
}
