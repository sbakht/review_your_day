import 'package:The_Friendly_Habit_Journal/bloc/tracker/bloc.dart';
import 'package:The_Friendly_Habit_Journal/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTracker extends StatefulWidget {
  @override
  _CreateTrackerState createState() => _CreateTrackerState();
}

class _CreateTrackerState extends State<CreateTracker> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final TrackerBloc trackerBloc = BlocProvider.of<TrackerBloc>(context);
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(kTextBefore,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            TextFormField(
              maxLength: 100,
              controller: myController,
              validator: validator,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(kTextAfterToday,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      addTracker(trackerBloc);
                      myController.clear();
                      showSnackBar(context);
                      FocusScope.of(context).unfocus();
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String validator(value) {
    if (value.isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  }

  void addTracker(TrackerBloc trackerBloc) {
    var title = myController.text.trim();
    trackerBloc.add(new EventTrackerAdd(title: title));
  }

  void showSnackBar(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Tracker Created'),
      duration: Duration(seconds: 1),
    ));
  }
}
