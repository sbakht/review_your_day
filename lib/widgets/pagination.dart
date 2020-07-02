import 'package:The_Friendly_Habit_Journal/bloc/review/bloc.dart';
import 'package:flutter/material.dart';

List<Widget> buildPagination({index, total, snapshot, next, previous}) {
  return [
    buildPaginationNumbers(index, total),
    buildPaginationLeftArrow(snapshot, previous),
    buildPaginationRightArrow(snapshot, next),
  ];
}

Container buildPaginationNumbers(int cardIndex, int total) {
  return Container(
    margin: EdgeInsets.only(right: 10),
    child: Center(
        child: Text(
            "" + (cardIndex + 1).toString() + "/" + total.toString() + "")),
  );
}

IconButton buildPaginationLeftArrow(StateReviewing state, previous()) {
  return IconButton(
    icon: Icon(Icons.chevron_left),
    tooltip: 'Previous Question',
    onPressed: state.isFirstQuestion ? null : previous,
  );
}

IconButton buildPaginationRightArrow(StateReviewing state, next) {
  return IconButton(
    icon: Icon(Icons.chevron_right),
    tooltip: 'Next Question',
    onPressed: state.isLastQuestion ? null : next,
  );
}
