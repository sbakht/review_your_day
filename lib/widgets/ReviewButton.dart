import 'package:The_Friendly_Habit_Journal/TrackerBrain.dart';
import 'package:The_Friendly_Habit_Journal/bloc/tracker/tracker_bloc.dart';
import 'package:The_Friendly_Habit_Journal/bloc/tracker/tracker_event.dart';
import 'package:The_Friendly_Habit_Journal/constants.dart';
import 'package:flutter/material.dart';

class ReviewButton extends StatelessWidget {
  final String text;
  final DATE date;
  final int remainingCardCount;
  final TrackerBloc bloc;

  ReviewButton({this.text, this.date, this.remainingCardCount, this.bloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
          child: Text(text),
          onPressed: remainingCardCount == 0
              ? null
              : () {
                  Navigator.of(context).pushNamed("/review", arguments: {
                    'date': date,
                  }).then((value) {
                    //TODO: having to update dates on load
                    // ignore: close_sinks
                    bloc.add(EventTrackerInitialized());
                  });
                },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              remainingCardCount.toString(),
              style: TextStyle(
                  color: kSecondaryTextColor, fontWeight: FontWeight.bold),
            ),
            Text(
              " remaining",
              style: TextStyle(color: kSecondaryTextColor),
            ),
          ],
        ),
      ],
    );
  }
}
