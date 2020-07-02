import 'package:The_Friendly_Habit_Journal/TrackerBrain.dart';
import 'package:The_Friendly_Habit_Journal/bloc/review/bloc.dart';
import 'package:The_Friendly_Habit_Journal/bloc/tracker/tracker_bloc.dart';
import 'package:The_Friendly_Habit_Journal/constants.dart';
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
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final TrackerBloc trackerBloc = BlocProvider.of<TrackerBloc>(context);
    Map<String, dynamic> map = ModalRoute.of(context).settings.arguments;
    TrackerBrain trackerBrain = map['trackerBrain'];
    DATE date = map['date'];

    return BlocProvider<ReviewBloc>(
      create: (context) => ReviewBloc(
          trackerBloc: trackerBloc, trackerBrain: trackerBrain, date: date),
      child:
          BlocBuilder<ReviewBloc, ReviewState>(builder: (context, reviewState) {
        // ignore: close_sinks
        ReviewBloc reviewBloc = BlocProvider.of<ReviewBloc>(context);
        return _InternalReview(
            reviewBloc: reviewBloc, reviewState: reviewState, date: date);
      }),
    );
  }
}

class _InternalReview extends StatefulWidget {
  final ReviewBloc reviewBloc;
  final ReviewState reviewState;
  final DATE date;

  _InternalReview({
    this.reviewBloc,
    this.reviewState,
    this.date,
  });

  @override
  _InternalReviewState createState() => _InternalReviewState();
}

class _InternalReviewState extends State<_InternalReview> {
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    ReviewState reviewState = this.widget.reviewState;
    DATE date = this.widget.date;

    if (reviewState is StateReviewLoading) {
      return Container();
    }
    var cardIndex;
    var total;
    StateReviewing state;
    if (reviewState is StateReviewing) {
      cardIndex = reviewState.getIndex();
      total = reviewState.getNumCards();
      state = reviewState;
    }

    next() {
      if (state.isLastQuestion()) {
        Navigator.pop(context);
      }
      buttonCarouselController.nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.linear);
    }

    previous() {
      buttonCarouselController.previousPage(
          duration: Duration(milliseconds: 200), curve: Curves.linear);
    }

    return Scaffold(
        //TODO: refactor into widgets, pass in the onPress to make it easier to find and modify
        appBar: AppBar(
          title: buildTitle(date),
          //TODO: setting to show or hide progress and/or number progress count
          actions: buildPagination(
              index: cardIndex,
              total: total,
              snapshot: state,
              next: next,
              previous: previous),
        ),
        body: Column(
          children: [
            LinearProgressIndicator(value: cardIndex / total),
            Expanded(
                child: CarouselSlider(
              carouselController: buttonCarouselController,
              options: buildCarouselOptions(context, state),
              items: state
                  .getCards()
                  .map((item) => buildCard(item, state, next))
                  .toList(),
            )),
          ],
        ));
  }

  Container buildCard(Tracker item, StateReviewing snapshot, next) {
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
                  buildYES(snapshot, item, next),
                  buildNO(snapshot, item, next),
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

  Expanded buildNO(StateReviewing snapshot, Tracker item, next) {
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
          widget.reviewBloc
              .add(EventAnswerQuestion(tracker: item, answer: Answer.No));
          next();
        },
      ),
    );
  }

  Expanded buildYES(StateReviewing snapshot, Tracker item, next) {
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
          widget.reviewBloc
              .add(EventAnswerQuestion(tracker: item, answer: Answer.Yes));
          next();
        },
      ),
    );
  }

  CarouselOptions buildCarouselOptions(
      BuildContext context, StateReviewing snapshot) {
    return CarouselOptions(
        height: MediaQuery.of(context).size.height,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        onPageChanged: (i, reason) {
          onCardChange(snapshot, i);
        });
  }

  void onCardChange(StateReviewing snapshot, int i) {
    return setState(() {
      if (snapshot.isNextQuestionIndex(i)) {
        widget.reviewBloc.add(EventReviewNextQuestion());
      } else {
        widget.reviewBloc.add(EventReviewPreviousQuestion());
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

  IconButton buildPaginationRightArrow(StateReviewing snapshot, next) {
    return IconButton(
      icon: Icon(Icons.chevron_right),
      tooltip: 'Next Question',
      onPressed: snapshot.isLastQuestion() ? null : () => next(),
    );
  }

  IconButton buildPaginationLeftArrow(StateReviewing state, previous()) {
    return IconButton(
        icon: Icon(Icons.chevron_left),
        tooltip: 'Previous Question',
        onPressed: state.isFirstQuestion() ? null : () => setState(previous));
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
