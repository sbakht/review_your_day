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
    //TODO: this is bad setting date without constructor
    trackerBrain.setDate(date);
    trackerBrain.updateActiveCards();
    int remainingCardCount = trackerBrain.remainingCardCount();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            child: Text("Start Review of your Day"),
            onPressed: remainingCardCount == 0
                ? null
                : () {
                    Navigator.pushNamed(context, "/review",
                            arguments: trackerBrain)
                        .then((value) {
                      setState(() {
                        // refresh state on pop
                      });
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
      ),
    );
  }
}
