import '../enums.dart';

class Tracker {
  String title;
  Answer bonusPointsAnswer;
  Map<int, Answer> userResponsesByDate;

  Tracker({this.title, this.bonusPointsAnswer}) {
    this.userResponsesByDate = {};
  }

  void setUserAnswer(Answer ans) {
    userResponsesByDate[17] = ans;
  }

  isAlreadyAnsweredWith(int date, Answer ans) {
    return this.userResponsesByDate[date] == ans;
  }
}
