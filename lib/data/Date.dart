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
}

String format(DateTime date) {
  return date.month.toString() +
      '.' +
      date.day.toString() +
      '.' +
      date.year.toString();
}
