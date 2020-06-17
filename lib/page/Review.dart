import 'package:flutter/material.dart';
import 'package:reviewyourday/constants.dart';
import 'package:reviewyourday/data/Date.dart';

import '../TrackerBrain.dart';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  //TODO: check if the remaining value updates if you leave the reviews early (or after completing)
  TrackerBrain trackerBrain = new TrackerBrain();

  @override
  Widget build(BuildContext context) {
    String date = (new Date()).getTodayFormatted();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            child: Text("Start Review of your Day"),
            onPressed: () {
              Navigator.pushNamed(context, "/review", arguments: date);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                trackerBrain.remainingCardCount(date).toString(),
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
      ),
    );
  }
}
