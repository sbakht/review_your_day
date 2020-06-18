import 'package:flutter/material.dart';
import 'package:reviewyourday/data/Date.dart';
import 'package:reviewyourday/data/Percentage.dart';
import 'package:reviewyourday/data/Tracker.dart';

import '../TrackerBrain.dart';
import '../constants.dart';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  //TODO: check if the remaining value updates if you leave the reviews early (or after completing)
  TrackerBrain trackerBrain = new TrackerBrain();

  @override
  Widget build(BuildContext context) {
    //TODO: this is bad setting date without constructor
    String date = (new Date()).getTodayFormatted();
    trackerBrain.setDate(date);

    trackerBrain.updateActiveCards();
    int remainingCardCount = trackerBrain.remainingCardCount();

    return Column(
      children: [
        Center(
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
                        color: kSecondaryTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " remaining",
                    style: TextStyle(color: kSecondaryTextColor),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
              child: ListView(
            padding: const EdgeInsets.all(5),
            children: trackerBrain.sorter().map<Widget>((Tracker t) {
              Percentage percentage = new Percentage(t);
              int percentYesExcludeNA = percentage.getPercentYesExclusive();
              int percentNoExcludeNA = percentage.getPercentNoExclusive();

              return ListTile(
                title: Text(t.title),
                trailing: Container(
                  child: SizedBox(
                    width: 80,
                    child: Row(
                      children: [
//                        Text("Y: ",
//                            style: TextStyle(color: kSecondaryTextColor)),
                        Text(
                          percentYesExcludeNA == 0 ? "00" : "",
                          style: TextStyle(color: kBackgroundColor),
                        ),
                        Text(
                          percentYesExcludeNA > 0 && percentYesExcludeNA < 100
                              ? "0"
                              : "",
                          style: TextStyle(color: kBackgroundColor),
                        ),
                        Text(
                          percentage.format(percentYesExcludeNA),
                          textAlign: TextAlign.right,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
//                        Text(" N: ",
//                            style: TextStyle(color: kSecondaryTextColor)),
                        Text(
                          percentNoExcludeNA == 0 ? "00" : "",
                          style: TextStyle(color: kBackgroundColor),
                        ),
                        Text(
                          percentNoExcludeNA > 0 && percentNoExcludeNA < 100
                              ? "0"
                              : "",
                          style: TextStyle(color: kBackgroundColor),
                        ),
                        Text(
                          percentage.format(percentNoExcludeNA),
                          textAlign: TextAlign.right,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          )),
        ),
      ],
    );
  }
}
