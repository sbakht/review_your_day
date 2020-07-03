import 'package:The_Friendly_Habit_Journal/TrackerBrain.dart';
import 'package:The_Friendly_Habit_Journal/bloc/tracker/tracker_bloc.dart';
import 'package:The_Friendly_Habit_Journal/bloc/tracker/tracker_event.dart';
import 'package:The_Friendly_Habit_Journal/bloc/tracker/tracker_state.dart';
import 'package:The_Friendly_Habit_Journal/constants.dart';
import 'package:The_Friendly_Habit_Journal/data/Percentage.dart';
import 'package:The_Friendly_Habit_Journal/data/Tracker.dart';
import 'package:The_Friendly_Habit_Journal/widgets/ReviewButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewDashboard extends StatefulWidget {
  final StateTracker state;

  ReviewDashboard({this.state});

  @override
  _ReviewDashboardState createState() => _ReviewDashboardState();
}

class _ReviewDashboardState extends State<ReviewDashboard> {
  String searchTerm = "";
  final TextEditingController _filter = new TextEditingController();

  _ReviewDashboardState() {
    _filter.addListener(() {
      searchTerm = _filter.text.isEmpty ? "" : _filter.text.toLowerCase();
      BlocProvider.of<TrackerBloc>(context)
          .add(EventTrackerSearch(searchText: searchTerm));
    });
  }

  @override
  Widget build(BuildContext context) {
    final TrackerBloc trackerBloc = BlocProvider.of<TrackerBloc>(context);
    StateTracker state = widget.state;

    List<Tracker> cards = state.cards;
    int numRemainingToday = state.numRemainingToday;
    int numRemainingYesterday = state.numRemainingYesterday;

    bool shouldHideYesterdayReviewButton() {
      return numRemainingYesterday == 0;
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
              ReviewButton(
                text: "Start Your Daily Review",
                date: DATE.Today,
                remainingCardCount: numRemainingToday,
                bloc: trackerBloc,
              ),
              shouldHideYesterdayReviewButton()
                  ? SizedBox()
                  : ReviewButton(
                      text: "Start Yesterdays Review",
                      date: DATE.Yesterday,
                      remainingCardCount: numRemainingYesterday,
                      bloc: trackerBloc,
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
          child: cards.length == 0
              ? Center(
                  child: Text("No Activities Found :(",
                      style: TextStyle(color: kSecondaryTextColor)))
              : ListView.builder(
                  padding: const EdgeInsets.all(5),
                  primary: true,
                  itemCount: cards.length,
                  itemBuilder: (BuildContext context, int index) {
                    Tracker t = cards[index];
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
                        title: Text(capitalize(t.title)),
                        subtitle: GestureDetector(
                          child: Text("Delete", style: TextStyle(fontSize: 11)),
                          onTap: () {
                            _deleteConfirmationDialog(context, trackerBloc, t);
                          },
                        ),
                        trailing: Container(
                          child: SizedBox(
                            width: 80,
                            child: Row(
                              children: [
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
