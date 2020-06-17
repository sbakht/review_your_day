import '../enums.dart';

class Tracker {
  String title;
  Answer bonusPointsAnswer;
  Map<int, Answer> userResponsesByDate;

  Tracker({this.title, this.bonusPointsAnswer}) {
    this.userResponsesByDate = {};
  }

  void setUserAnswerByDate(int date, Answer ans) {
    userResponsesByDate[date] = ans;
  }

  doesAnswerByDateEqual(int date, Answer ans) {
    return this.userResponsesByDate[date] == ans;
  }
}
