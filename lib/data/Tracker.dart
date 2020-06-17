import '../enums.dart';

class Tracker {
  String title;
  Answer bonusPointsAnswer;
  Map<String, Answer> userResponsesByDate;

  Tracker({this.title, this.bonusPointsAnswer}) {
    this.userResponsesByDate = {};
  }

  void setUserAnswerByDate(String date, Answer ans) {
    userResponsesByDate[date] = ans;
  }

  doesAnswerByDateEqual(String date, Answer ans) {
    return this.userResponsesByDate[date] == ans;
  }
}
