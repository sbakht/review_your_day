import '../enums.dart';

class Tracker {
  String title;
  Answer bonusPointsAnswer;
  Map<String, Answer> userResponsesByDate;
  bool archived;

  Tracker({this.title, this.bonusPointsAnswer}) {
    this.userResponsesByDate = {};
    this.archived = false;
  }

  void setUserAnswerByDate(String date, Answer ans) {
    userResponsesByDate[date] = ans;
  }

  doesAnswerByDateEqual(String date, Answer ans) {
    return this.userResponsesByDate[date] == ans;
  }

  bool hasAnswer(date) {
    var answer = this.userResponsesByDate[date];
    return answer == Answer.Yes || answer == Answer.No;
  }
}
