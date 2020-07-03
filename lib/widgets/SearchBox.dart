import 'package:The_Friendly_Habit_Journal/bloc/tracker/tracker_bloc.dart';
import 'package:The_Friendly_Habit_Journal/bloc/tracker/tracker_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBox extends StatefulWidget {
  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _filter = new TextEditingController();

  _SearchBoxState() {
    _filter.addListener(() {
      String searchTerm =
          _filter.text.isEmpty ? "" : _filter.text.toLowerCase();
      BlocProvider.of<TrackerBloc>(context)
          .add(EventTrackerSearch(searchText: searchTerm));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: _filter,
        decoration: new InputDecoration(
          prefixIcon: new Icon(Icons.search),
          hintText: 'Search...',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
