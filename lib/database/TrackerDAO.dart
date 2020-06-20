import 'dart:convert';

import 'package:The_Friendly_Habit_Journal/TrackerBrain.dart';
import 'package:The_Friendly_Habit_Journal/data/Tracker.dart';
import 'package:The_Friendly_Habit_Journal/database/LocalStorage.dart';

class TrackerDAO {
  LocalStorage storage;
  TrackerBrain trackerBrain;
  List<Tracker> defaultExamples;

  TrackerDAO(List<Tracker> defaultExamples) {
    this.storage = new LocalStorage('trackerbrain.txt');
    this.defaultExamples = defaultExamples;
  }

  Future<TrackerBrain> fetch() async {
    try {
      String json = await storage.read();

      return TrackerBrain.fromJson(jsonDecode(json));
    } catch (e) {
      print("Failed to fetch data");
      return TrackerBrain(defaultExamples);
    }
  }

  void save(TrackerBrain trackerBrain) async {
    String json = jsonEncode(trackerBrain);
    storage.write(json);
  }
}
