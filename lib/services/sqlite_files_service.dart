import 'package:sqflite/sqflite.dart';

import 'package:board_game_dreamer/models/file.dart';
import 'package:board_game_dreamer/services/sqlite_service.dart';

class SqliteFilesService {
  Future<int> createFile(File file) async {
    final Database db = await SqliteService().initializeDB();
    final id = await db.insert('files', file.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<File>> getProjectFiles(int userId, int projectId) async {
    final Database db = await SqliteService().initializeDB();
    List<Map> results = await db.query("files",
        where: "userid = ? AND projectid = ?",
        whereArgs: [userId, projectId],
        columns: File.columns,
        orderBy: "id ASC");

    List<File> files = List<File>.filled(
        results.length,
        File(
          id: 0,
          filename: "",
          filecontent: "",
          userid: 0,
          projectid: 0,
        ));
    for (int i = 0; i < results.length; i++) {
      files[i] = File.fromMap(results[i]);
    }
    return files;
  }

  Future<File> getProjectFile(int fileId) async {
    final Database db = await SqliteService().initializeDB();
    List<Map> results = await db.query("files",
        where: "id = ?", whereArgs: [fileId], columns: File.columns);

    File file = File(
      id: 0,
      filename: "",
      filecontent: "",
      userid: 0,
      projectid: 0,
    );
    for (int i = 0; i < results.length; i++) {
      file = File.fromMap(results[i]);
    }
    return file;
  }
}
