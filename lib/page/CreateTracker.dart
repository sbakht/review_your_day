import 'package:The_Friendly_Habit_Journal/TrackerBrain.dart';
import 'package:The_Friendly_Habit_Journal/constants.dart';
import 'package:The_Friendly_Habit_Journal/tracker_bloc.dart';
import 'package:The_Friendly_Habit_Journal/tracker_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTracker extends StatefulWidget {
  final TrackerBrain trackerBrain;

  CreateTracker({this.trackerBrain});

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
    final TrackerBloc myBloc = BlocProvider.of<TrackerBloc>(context);
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
//              keyboardType: TextInputType.multiline,
//              maxLines: null,
              maxLength: 100,
              controller: myController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Field cannot be empty';
                }
                return null;
              },
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
//                      widget.trackerBrain.add(myController.text.trim());
                      myBloc.add(
                          new TrackerAdded(title: myController.text.trim()));
                      myController.clear();
                      FocusScope.of(context).unfocus();
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Tracker Created'),
                        duration: Duration(seconds: 1),
                      ));
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
}
