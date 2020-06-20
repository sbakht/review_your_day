import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/trackerbrain.txt');
  }

  Future<String> read() async {
    try {
      final file = await _localFile;
      String json = await file.readAsString();
      return json;
    } catch (e) {
      return "";
    }
  }

  Future<File> write(String json) async {
    final file = await _localFile;
    return file.writeAsString(json);
  }
}
