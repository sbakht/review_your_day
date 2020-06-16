import 'package:flutter/material.dart';

class CreateTracker extends StatefulWidget {
  @override
  _CreateTrackerState createState() => _CreateTrackerState();
}

class _CreateTrackerState extends State<CreateTracker> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create a Tracker'),
        ),
        body: Center(
          child: Container(
              child: Text(
                  'You are looking at the message for bottom navigation item $_index')),
        ),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (tappedItemIndex) => setState(() {
                  if (tappedItemIndex == 1) {
                    Navigator.pushNamed(context, '/review');
                  }
//                  _index = tappedItemIndex;
                }),
            currentIndex: _index,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.av_timer),
                title: Text('navBarItem1Text'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                title: Text('navBarItem2Text'),
              )
            ]));
  }
}
