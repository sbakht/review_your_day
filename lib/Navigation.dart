import 'package:flutter/material.dart';
import 'package:reviewyourday/TrackerBrain.dart';
import 'package:reviewyourday/page/CreateTracker.dart';
import 'package:reviewyourday/page/ReviewDashboard.dart';

class Navigation extends StatefulWidget {
  final TrackerBrain trackerBrain;

  Navigation({this.trackerBrain});

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(getTitle()),
        ),
        drawer: buildDrawer(context),
        body: buildPageView(),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (tappedItemIndex) => setState(() {
            _index = tappedItemIndex;
          }),
          currentIndex: _index,
          items: buildBottomNav(),
        ));
  }

  List<BottomNavigationBarItem> buildBottomNav() {
    return [
//      BottomNavigationBarItem(
//        icon: Icon(Icons.av_timer),
//        title: Text('Home'),
//      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.book),
        title: Text('Review Your Day'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add),
        title: Text('Track New Activity'),
      )
    ];
  }

  Widget buildPageView() {
    if (_index == 0) {
      return Review(trackerBrain: this.widget.trackerBrain);
    } else if (_index == 1) {
      return CreateTracker(trackerBrain: this.widget.trackerBrain);
    }
    return null;
  }

  String getTitle() {
    if (_index == 0) {
      return 'Review';
    } else if (_index == 1) {
      return 'Track New Activity';
    }
    return "";
  }

  Drawer buildDrawer(context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
//            ListTile(
//              leading: Icon(Icons.message),
//              title: Text('Messages'),
//            ),
//            ListTile(
//              leading: Icon(Icons.account_circle),
//              title: Text('Profile'),
//            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.popAndPushNamed(context, "/settings");
              },
            ),
          ],
        ),
      ),
    );
  }
}
