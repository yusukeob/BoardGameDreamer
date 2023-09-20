import 'package:sqflite/sqflite.dart';

import 'package:board_game_dreamer/models/project.dart';
import 'package:board_game_dreamer/services/sqlite_service.dart';

class SqliteProjectsService {
  Future<int> createProject(Project project) async {
    final Database db = await SqliteService().initializeDB();
    final id = await db.insert('projects', project.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<Project>> getUserProjects(int userId) async {
    final Database db = await SqliteService().initializeDB();
    List<Map> results = await db.query("projects",
        where: "userid = ?",
        whereArgs: [userId],
        columns: Project.columns,
        orderBy: "id ASC");

    List<Project> projects = List<Project>.filled(
        results.length, const Project(id: 0, projectname: "", userid: 0));
    for (int i = 0; i < results.length; i++) {
      projects[i] = Project.fromMap(results[i]);
    }
    return projects;
  }
}
