import 'package:The_Friendly_Habit_Journal/data/Tracker.dart';

class Trackers {
  List<Tracker> trackers;
  Trackers(this.trackers);

  List<Tracker> getUnanswered(String date) {
    //TODO get from Snapshop
    return List.from(trackers.where(notArchived).where(isUnanswered(date)));
  }

  List<Tracker> filterOutArchived() {
    return List.from(trackers.where(notArchived));
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    int i = 0;
    trackers.forEach((t) {
      map[i.toString()] = t.toJson();
      i++;
    });

    return map;
  }

  Trackers.fromJson(Map<String, dynamic> json) {
    trackers = [];
    json.forEach((key, value) {
      trackers.add(Tracker.fromJson(value));
    });
  }

  void remove(Tracker t) {
    trackers.remove(t);
  }

  void add(Tracker t) {
    trackers.add(t);
  }
}

bool notArchived(Tracker t) => !t.archived;
var isUnanswered = (date) => (Tracker t) => !t.hasAnswer(date);
