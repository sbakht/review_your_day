import 'package:The_Friendly_Habit_Journal/TrackerBrain.dart';
import 'package:The_Friendly_Habit_Journal/bloc/review/bloc.dart';
import 'package:The_Friendly_Habit_Journal/widgets/Card.dart';
import 'package:The_Friendly_Habit_Journal/widgets/pagination.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewingGame extends StatefulWidget {
  @override
  _ReviewingGameState createState() => _ReviewingGameState();
}

class _ReviewingGameState extends State<ReviewingGame> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = ModalRoute.of(context).settings.arguments;
    DATE date = map['date'];

    // ignore: close_sinks
    final ReviewBloc reviewBloc = BlocProvider.of<ReviewBloc>(context);
    reviewBloc.add(EventReviewStart(date: date));

    return BlocBuilder<ReviewBloc, ReviewState>(
        builder: (context, reviewState) {
      return _InternalReview(
          reviewBloc: reviewBloc, reviewState: reviewState, date: date);
    });
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

    if (reviewState is StateReviewInit) {
      return Container();
    }
    if (reviewState is StateReviewingFinished) {
      return Container();
    }

    var cardIndex;
    var total;
    StateReviewing state;
    if (reviewState is StateReviewing) {
      cardIndex = reviewState.cardIndex;
      total = reviewState.cards.length;
      state = reviewState;
    }

    next() {
      if (state.isLastQuestion) {
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
              options: buildCarouselOptions(context, state.cardIndex),
              items: buildItems(state, next),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildItems(StateReviewing state, Function next) {
    var i = 0;
    return state.cards
        .map(
          (item) => buildCard(
            questionText: item.title,
            answer: state.answers[i++],
            onAnswer: (ans) {
              widget.reviewBloc
                  .add(EventAnswerQuestion(tracker: item, answer: ans));
              next();
            },
          ),
        )
        .toList();
  }

  CarouselOptions buildCarouselOptions(BuildContext context, int cardIndex) {
    return CarouselOptions(
      height: MediaQuery.of(context).size.height,
      enlargeCenterPage: true,
      enableInfiniteScroll: false,
      onPageChanged: (i, reason) {
        onCardChange(cardIndex, i);
      },
    );
  }

  void onCardChange(int cardIndex, int i) {
    if (i > cardIndex) {
      widget.reviewBloc.add(EventReviewNextQuestion());
    } else {
      widget.reviewBloc.add(EventReviewPreviousQuestion());
    }
  }
}

Text buildTitle(DATE date) {
  return Text(
      date == DATE.Today ? "Reviewing Your Day" : "Reviewing Yesterday");
}
