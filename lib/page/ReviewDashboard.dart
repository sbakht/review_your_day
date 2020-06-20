import 'package:The_Friendly_Habit_Journal/TrackerBrain.dart';
import 'package:The_Friendly_Habit_Journal/constants.dart';
import 'package:The_Friendly_Habit_Journal/data/Date.dart';
import 'package:The_Friendly_Habit_Journal/data/Percentage.dart';
import 'package:The_Friendly_Habit_Journal/data/Tracker.dart';
import 'package:The_Friendly_Habit_Journal/enums.dart';
import 'package:flutter/material.dart';

class Review extends StatefulWidget {
  final TrackerBrain trackerBrain;

  Review({this.trackerBrain});

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  String searchTerm = "";
  final TextEditingController _filter = new TextEditingController();

  _ReviewState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          searchTerm = "";
        });
      } else {
        setState(() {
          searchTerm = _filter.text.toLowerCase();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TrackerBrain trackerBrain = widget.trackerBrain;

    //TODO: this is bad setting date without constructor
    Date date = new Date();
    trackerBrain.setDate(
      date: date.getTodayFormatted(),
      yesterdayDate: date.getYesterdayFormatted(),
    );

    trackerBrain.updateActiveCards();
    int remainingCardCount = trackerBrain.remainingCardCount();
    int remainingCardCountFromYesterday =
        trackerBrain.remainingCardCountYesterday();

    List<Tracker> sortedCards = List.from(trackerBrain
        .sorter(SortBy.DescPercentYes)
        .where((t) => t.title.toLowerCase().contains(searchTerm)));

    Widget startReview(text, dateENUM, remainingCardCount) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            child: Text(text),
            onPressed: remainingCardCount == 0
                ? null
                : () {
                    trackerBrain.setMode(dateENUM); //TODO: very bad design
                    Navigator.pushNamed(context, "/review", arguments: {
                      'trackerBrain': trackerBrain,
                    }).then((value) {
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
      );
    }

    bool shouldHideYesterdayReviewButton() {
      return remainingCardCountFromYesterday == 0;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          child: TextField(
            controller: _filter,
            decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search),
              hintText: 'Search...',
              border: InputBorder.none,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: shouldHideYesterdayReviewButton()
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceEvenly,
            children: [
              startReview(
                  "Start Your Daily Review", DATE.Today, remainingCardCount),
              shouldHideYesterdayReviewButton()
                  ? SizedBox()
                  : startReview("Start Yesterdays Review", DATE.Yesterday,
                      remainingCardCountFromYesterday),
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
          child: sortedCards.length == 0
              ? Center(
                  child: Text("No Activities Found :(",
                      style: TextStyle(color: kSecondaryTextColor)))
              : ListView.builder(
                  padding: const EdgeInsets.all(5),
                  primary: true,
                  itemCount: sortedCards.length,
                  itemBuilder: (BuildContext context, int index) {
                    Tracker t = sortedCards[index];
                    Percentage percentage = new Percentage(t);
                    int percentYesExcludeNA =
                        percentage.getPercentYesExclusive();
                    int percentNoExcludeNA = percentage.getPercentNoExclusive();
                    var tableShadedColor = Colors.grey.shade900;
                    var kBackgroundColor =
                        Colors.grey[850]; // Default dark scaffold color

                    return Container(
                      color:
                          index % 2 == 0 ? tableShadedColor : kBackgroundColor,
                      child: ListTile(
                        title: Text(t.title),
                        subtitle: GestureDetector(
                          child: Text("Delete", style: TextStyle(fontSize: 11)),
                          onTap: () {
                            _deleteConfirmationDialog(context, t);
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
                                  percentYesExcludeNA > 0 &&
                                          percentYesExcludeNA < 100
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
                                  percentNoExcludeNA > 0 &&
                                          percentNoExcludeNA < 100
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

  Future<void> _deleteConfirmationDialog(context, Tracker t) async {
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
                setState(() {
                  widget.trackerBrain.remove(t);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
