import 'package:flutter/material.dart';
import 'package:reviewyourday/data/Date.dart';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    String date = (new Date()).getTodayFormatted();
    return Center(
      child: FlatButton(
        child: Text("Start Review of your Day"),
        onPressed: () {
          Navigator.pushNamed(context, "/review", arguments: date);
        },
      ),
    );
  }
}
