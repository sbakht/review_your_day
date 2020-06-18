import 'package:flutter/material.dart';
import 'package:reviewyourday/data/Date.dart';
import 'package:reviewyourday/data/Percentage.dart';
import 'package:reviewyourday/data/Tracker.dart';

import '../TrackerBrain.dart';
import '../constants.dart';
import '../enums.dart';

class Review extends StatefulWidget {
  final TrackerBrain trackerBrain;

  Review({this.trackerBrain});

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
//  TrackerBrain trackerBrain = widget.trackerBrain;

  @override
  Widget build(BuildContext context) {
    TrackerBrain trackerBrain = widget.trackerBrain;

    //TODO: this is bad setting date without constructor
    String date = (new Date()).getTodayFormatted();
    trackerBrain.setDate(date);

    trackerBrain.updateActiveCards();
    int remainingCardCount = trackerBrain.remainingCardCount();

    var sortedCards = trackerBrain.sorter(SortBy.DescPercentYes);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                child: Text("Start Your Daily Review"),
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
        Container(
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
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(5),
            primary: true,
            itemCount: sortedCards.length,
            itemBuilder: (BuildContext context, int index) {
              Tracker t = sortedCards[index];
              Percentage percentage = new Percentage(t);
              int percentYesExcludeNA = percentage.getPercentYesExclusive();
              int percentNoExcludeNA = percentage.getPercentNoExclusive();
              var tableShadedColor = Colors.grey[100];

              return Container(
                color: index % 2 == 0 ? tableShadedColor : kBackgroundColor,
                child: ListTile(
                  title: Text(t.title),
                  subtitle: GestureDetector(
                    child: Text("Delete", style: TextStyle(fontSize: 11)),
                    onTap: () {
                      setState(() {
                        trackerBrain.remove(t);
                      });
                    },
                  ),
                  trailing: Container(
                    child: SizedBox(
                      width: 80,
                      child: Row(
                        children: [
//                        Text("Y: ",
//                            style: TextStyle(color: kSecondaryTextColor)),
                          Text(
                            percentYesExcludeNA == 0 ? "00" : "",
                            style: TextStyle(
                                color: index % 2 == 0
                                    ? tableShadedColor
                                    : kBackgroundColor),
                          ),
                          Text(
                            percentYesExcludeNA > 0 && percentYesExcludeNA < 100
                                ? "0"
                                : "",
                            style: TextStyle(
                                color: index % 2 == 0
                                    ? tableShadedColor
                                    : kBackgroundColor),
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
                            style: TextStyle(
                                color: index % 2 == 0
                                    ? tableShadedColor
                                    : kBackgroundColor),
                          ),
                          Text(
                            percentNoExcludeNA > 0 && percentNoExcludeNA < 100
                                ? "0"
                                : "",
                            style: TextStyle(
                                color: index % 2 == 0
                                    ? tableShadedColor
                                    : kBackgroundColor),
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
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
