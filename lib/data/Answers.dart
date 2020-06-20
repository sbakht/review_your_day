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

  Answers.fromJson(Map<String, dynamic> json) {
    userResponsesByDate = {};
    json.forEach((key, value) {
      if (value == 1) {
        setAnswer(key, Answer.Yes);
      } else if (value == 2) {
        setAnswer(key, Answer.No);
      }
    });
  }

  Map<String, int> toJson() {
    Map<String, int> map = {};
    getData().forEach((key, value) {
      if (value == Answer.Yes) {
        map[key] = 1;
      } else if (value == Answer.No) {
        map[key] = 2;
      } else {
        map[key] = 0;
      }
    });
    return map;
  }
}
