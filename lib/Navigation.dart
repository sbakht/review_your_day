import 'package:flutter/material.dart';
import 'package:reviewyourday/page/CreateTracker.dart';
import 'package:reviewyourday/page/Home.dart';
import 'package:reviewyourday/page/Review.dart';

class Navigation extends StatefulWidget {
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
        drawer: buildDrawer(),
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
      BottomNavigationBarItem(
        icon: Icon(Icons.av_timer),
        title: Text('Home'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.book),
        title: Text('Review'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add),
        title: Text('Add Tracker'),
      )
    ];
  }

  Widget buildPageView() {
    if (_index == 0) {
      return Home();
    } else if (_index == 1) {
      return Review();
    } else if (_index == 2) {
      return CreateTracker();
    }
    return null;
  }

  String getTitle() {
    if (_index == 0) {
      return "Home";
    } else if (_index == 1) {
      return 'Review';
    } else if (_index == 2) {
      return 'Add Tracker';
    }
    return "";
  }
}

Drawer buildDrawer() {
  return Drawer(
    child: SafeArea(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Messages'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    ),
  );
}
