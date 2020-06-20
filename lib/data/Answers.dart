import 'package:The_Friendly_Habit_Journal/enums.dart';

class Answers {
  Map<String, Answer> userResponsesByDate;

  Answers() {
    userResponsesByDate = {};
  }

  void setAnswer(String date, Answer ans) {
    userResponsesByDate[date] = ans;
  }

  getAnswer(String date) {
    return this.userResponsesByDate[date];
  }

  getData() {
    return userResponsesByDate;
  }
}
