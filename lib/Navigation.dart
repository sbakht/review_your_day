import 'package:The_Friendly_Habit_Journal/bloc/tracker/tracker_bloc.dart';
import 'package:The_Friendly_Habit_Journal/bloc/tracker/tracker_event.dart';
import 'package:The_Friendly_Habit_Journal/bloc/tracker/tracker_state.dart';
import 'package:The_Friendly_Habit_Journal/page/CreateTracker.dart';
import 'package:The_Friendly_Habit_Journal/page/ReviewDashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      return BlocBuilder<TrackerBloc, TrackerState>(builder: (context, state) {
        if (state is StateTrackerLoading) {
          return Container();
        }
        if (state is StateTracker) {
          // ignore: close_sinks
          final TrackerBloc trackerBloc = BlocProvider.of<TrackerBloc>(context);
          trackerBloc.add(EventTrackerInitialized());
          return ReviewDashboard(state: state);
        }
        return Container(); //TODO: this line should never run
      });
    } else if (_index == 1) {
      return CreateTracker();
    }
    return null;
  }

  String getTitle() {
    if (_index == 0) {
      return 'Daily Review';
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
