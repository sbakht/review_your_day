import 'package:flutter/material.dart';

import 'TrackerBrain.dart';
import 'data/BrainStorage.dart';
import 'data/Tracker.dart';
import 'page/CreateTracker.dart';
import 'page/ReviewDashboard.dart';

class Navigation extends StatefulWidget {
  final BrainStorage storage;

  Navigation({this.storage});

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _index = 0;
  TrackerBrain trackerBrain = new TrackerBrain(<Tracker>[]);

  @override
  void initState() {
    super.initState();
    widget.storage.readBrain().then((TrackerBrain brain) {
      setState(() {
        trackerBrain = brain;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(getTitle()),
//          actions: [
//            Center(
//              child: Container(
//                width: 200,
//                margin: EdgeInsets.only(top: 5),
//                child: TextField(
////              controller: _filter,
//                  style: TextStyle(color: Colors.white),
//                  decoration: new InputDecoration(
//                    prefixIcon: Container(
//                      padding: EdgeInsets.only(bottom: 2),
//                      child: Icon(
//                        Icons.search,
//                        color: kSecondaryTextColor,
//                      ),
//                    ),
//                    hintText: 'Search...',
//                    border: InputBorder.none,
//                  ),
//                ),
//              ),
//            )
//          ],
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
      return Review(storage: widget.storage, trackerBrain: trackerBrain);
    } else if (_index == 1) {
      return CreateTracker(storage: widget.storage, trackerBrain: trackerBrain);
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
