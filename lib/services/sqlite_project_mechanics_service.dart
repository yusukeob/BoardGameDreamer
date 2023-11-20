import 'package:sqflite/sqflite.dart';

import 'package:board_game_dreamer/models/project_mechanic.dart';
import 'package:board_game_dreamer/services/sqlite_service.dart';

class SqliteProjectMechanicsService {
  Future<int> createProjectMechanic(ProjectMechanic projectMechanic) async {
    final Database db = await SqliteService().initializeDB();
    final id = await db.insert('project_mechanics', projectMechanic.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<ProjectMechanic>> getProjectMechanics(
      int userId, int projectId) async {
    final Database db = await SqliteService().initializeDB();
    List<Map> results = await db.query("project_mechanics",
        where: "userid = ? AND projectid = ?",
        whereArgs: [userId, projectId],
        columns: ProjectMechanic.columns,
        orderBy: "id DESC");

    List<ProjectMechanic> projectMechanics = List<ProjectMechanic>.filled(
        results.length,
        ProjectMechanic(
            id: 0,
            mechanicname: "",
            mechanicexplanation: "",
            userid: 0,
            projectid: 0,
            mechanicid: 0,
            projectapplication: ""));
    for (int i = 0; i < results.length; i++) {
      projectMechanics[i] = ProjectMechanic.fromMap(results[i]);
    }
    return projectMechanics;
  }

  Future<ProjectMechanic> getProjectMechanic(int projectMechanicId) async {
    final Database db = await SqliteService().initializeDB();
    List<Map> results = await db.query("project_mechanics",
        where: "id = ?",
        whereArgs: [projectMechanicId],
        columns: ProjectMechanic.columns);

    ProjectMechanic projectMechanic = ProjectMechanic(
        id: 0,
        mechanicname: "",
        mechanicexplanation: "",
        userid: 0,
        projectid: 0,
        mechanicid: 0,
        projectapplication: "");
    for (int i = 0; i < results.length; i++) {
      projectMechanic = ProjectMechanic.fromMap(results[i]);
    }
    return projectMechanic;
  }
}
