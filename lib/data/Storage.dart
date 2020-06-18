import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:reviewyourday/constants.dart';

import '../TrackerBrain.dart';

class BrainStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/trackerbrain.txt');
  }

  Future<TrackerBrain> readBrain() async {
    try {
      final file = await _localFile;

      // Read the file
      String json = await file.readAsString();

      return TrackerBrain.fromJson(jsonDecode(json));
    } catch (e) {
      return new TrackerBrain(trackersStore);
    }
  }

  Future<File> writeBrain(TrackerBrain trackerBrain) async {
    final file = await _localFile;
    String json = jsonEncode(trackerBrain);

    // Write the file
    return file.writeAsString(json);
  }
}
