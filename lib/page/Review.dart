import 'package:flutter/material.dart';
import 'package:reviewyourday/data/Tracker.dart';

import '../enums.dart';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        child: Text("Start Review of your Day"),
        onPressed: () {
          Navigator.pushNamed(context, "/review");
        },
      ),
    );
  }

  void answerQuestion(Answer ans, Tracker tracker) {
    tracker.setUserAnswer(ans);
  }
}
