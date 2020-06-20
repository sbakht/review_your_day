import 'dart:convert';

import 'package:The_Friendly_Habit_Journal/TrackerBrain.dart';
import 'package:The_Friendly_Habit_Journal/database/LocalStorage.dart';
import 'package:The_Friendly_Habit_Journal/examples/examples.dart';

class TrackerDAO {
  LocalStorage storage;
  TrackerBrain trackerBrain;

  TrackerDAO() {
    this.storage = new LocalStorage('trackerbrain.txt');
  }

  Future<TrackerBrain> fetch() async {
    try {
      String json = await storage.read();

      return TrackerBrain.fromJson(jsonDecode(json));
    } catch (e) {
      print("Failed to fetch data");
      return TrackerBrain(trackerExamples);
    }
  }

  void save(TrackerBrain trackerBrain) async {
    String json = jsonEncode(trackerBrain);
    storage.write(json);
  }
}
