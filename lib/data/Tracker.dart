import '../enums.dart';

class Tracker {
  String title;
  Answer bonusPointsAnswer;
  Map<int, Answer> userResponses;

  Tracker({this.title, this.bonusPointsAnswer}) {
    this.userResponses = {};
  }

  void setUserAnswer(Answer ans) {
    userResponses[17] = ans;
  }
}
