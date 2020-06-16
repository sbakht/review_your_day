import 'package:flutter/material.dart';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Reviewing Your Trackers'),
        ),
        body: Center(
          child: Container(
              child: Text(
                  'You are looking at the message for bottom navigation item $_index')),
        ),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (tappedItemIndex) => setState(() {
                  _index = tappedItemIndex;
                }),
            currentIndex: _index,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.av_timer), title: Text('navBarItem1Text')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add), title: Text('navBarItem2Text'))
            ]));
  }
}
