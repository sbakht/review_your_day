import 'Tracker.dart';

class Percentage {
  int yes;
  int no;
  int na;
  int total;

  Percentage(Tracker t) {
    this.yes = t.getNumYes();
    this.no = t.getNumNo();
    this.na = t.getNumNA();
    this.total = yes + no + na;
  }

  String format(int n) {
    return n.toString() + "%";
  }

  int getPercentYes() {
    return toPercentageInt(yes, total);
  }

  int getPercentNo() {
    return toPercentageInt(no, total);
  }

  int getPercentNa() {
    return toPercentageInt(na, total);
  }

  int getPercentYesExclusive() {
    return toPercentageInt(yes, total - na);
  }

  int getPercentNoExclusive() {
    return toPercentageInt(no, total - na);
  }
}

int toPercentageInt(int num, int total) {
  if (total == 0) {
    return 0;
  }
  return (num / total * 100).floor();
}
