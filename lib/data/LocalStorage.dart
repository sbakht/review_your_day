import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalStorage {
  String filename;

  LocalStorage(this.filename);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/' + filename);
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
