import 'package:flutter/material.dart';

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
}
