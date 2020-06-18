class Date {
  DateTime today;
  DateTime yesterday;

  Date() {
    this.today = new DateTime.now();
    this.yesterday = new DateTime(today.year, today.month, today.day - 1);
  }

  String getTodayFormatted() {
    return format(today);
  }

  String getYesterdayFormatted() {
    return format(yesterday);
  }

  static DateTime fromFormatted(String date) {
    List split = date.split('.');
    return DateTime.utc(
        int.parse(split[2]), int.parse(split[0]), int.parse(split[1]));
  }
}

String format(DateTime date) {
  return date.month.toString() +
      '.' +
      date.day.toString() +
      '.' +
      date.year.toString();
}
