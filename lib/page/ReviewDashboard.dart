import 'package:The_Friendly_Habit_Journal/TrackerBrain.dart';
import 'package:The_Friendly_Habit_Journal/bloc/tracker/bloc.dart';
import 'package:The_Friendly_Habit_Journal/constants.dart';
import 'package:The_Friendly_Habit_Journal/data/Tracker.dart';
import 'package:The_Friendly_Habit_Journal/widgets/ReviewButton.dart';
import 'package:The_Friendly_Habit_Journal/widgets/SearchBox.dart';
import 'package:The_Friendly_Habit_Journal/widgets/TableEntry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackerBloc, TrackerState>(
        builder: (context, trackerState) {
      final TrackerBloc trackerBloc = BlocProvider.of<TrackerBloc>(context);

      if (trackerState is StateTrackerLoading) {
        return Container();
      }

      StateTracker state;
      if (trackerState is StateTracker) {
        state = trackerState;
      }

      List<Tracker> cards = state.cards;
      int numRemainingToday = state.numRemainingToday;
      int numRemainingYesterday = state.numRemainingYesterday;

      bool isYesterdayReviewComplete() {
        return numRemainingYesterday == 0;
      }

      Widget reviewTodayButton() {
        return ReviewButton(
          text: "Start Your Daily Review",
          date: DATE.Today,
          remainingCardCount: numRemainingToday,
          bloc: trackerBloc,
        );
      }

      Widget reviewYesterdayButton() {
        return ReviewButton(
          text: "Start Yesterdays Review",
          date: DATE.Yesterday,
          remainingCardCount: numRemainingYesterday,
          bloc: trackerBloc,
        );
      }

      Widget reviewButtons() {
        return Container(
          padding: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: isYesterdayReviewComplete()
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceEvenly,
            children: [
              reviewTodayButton(),
              isYesterdayReviewComplete() ? SizedBox() : reviewYesterdayButton()
            ],
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SearchBox(),
          reviewButtons(),
          tableHeader(),
          Expanded(
            child: cards.length == 0
                ? emptyTableMsg()
                : ListView.builder(
                    padding: const EdgeInsets.all(5),
                    primary: true,
                    itemCount: cards.length,
                    itemBuilder: (BuildContext context, int index) {
                      Tracker tracker = cards[index];

                      return Container(
                        color: index % 2 == 0
                            ? kTableShadedColor
                            : kBackgroundColor,
                        child: ListTile(
                          title: Text(capitalize(tracker.title)),
                          subtitle: GestureDetector(
                            child:
                                Text("Delete", style: TextStyle(fontSize: 11)),
                            onTap: () {
                              _deleteConfirmationDialog(
                                context,
                                trackerBloc,
                                tracker,
                              );
                            },
                          ),
                          trailing: Container(
                            child: SizedBox(
                              width: 80,
                              child: tableEntry(tracker, index),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      );
    });
  }

  Future<void> _deleteConfirmationDialog(
      context, TrackerBloc trackerBloc, Tracker t) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Activity'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This activity will be permanently deleted.'),
                Text('This action cannot be undone.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              color: Colors.red,
              child: Text("Delete"),
              onPressed: () {
                trackerBloc.add(new EventTrackerRemove(t));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

String capitalize(string) {
  return "${string[0].toUpperCase()}${string.substring(1)}";
}

Widget tableHeader() {
  return Container(
    padding: EdgeInsets.only(left: 10, top: 20, right: 25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Activity Statistics',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Yes",
              style: TextStyle(color: kSecondaryTextColor),
            ),
            SizedBox(width: 25),
            Text(
              "No",
              style: TextStyle(color: kSecondaryTextColor),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget emptyTableMsg() {
  return Center(
      child: Text("No Activities Found :(",
          style: TextStyle(color: kSecondaryTextColor)));
}
