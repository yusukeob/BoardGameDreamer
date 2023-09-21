import 'package:sqflite/sqflite.dart';

import 'package:board_game_dreamer/models/project_flow_chart.dart';
import 'package:board_game_dreamer/services/sqlite_service.dart';

class SqliteProjectFlowChartsService {
  Future<int> createProjectFlowChart(ProjectFlowChart projectFlowChart) async {
    final Database db = await SqliteService().initializeDB();
    final id = await db.insert('project_flow_charts', projectFlowChart.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<ProjectFlowChart>> getUserProjectFlowCharts(
      int userId, int projectId) async {
    final Database db = await SqliteService().initializeDB();
    List<Map> results = await db.query("project_flow_charts",
        where: "userid = ? AND projectid = ?",
        whereArgs: [userId, projectId],
        columns: ProjectFlowChart.columns,
        orderBy: "id ASC");

    List<ProjectFlowChart> projectFlowCharts = List<ProjectFlowChart>.filled(
        results.length,
        const ProjectFlowChart(
            id: 0, flowchartname: "", userid: 0, projectid: 0));
    for (int i = 0; i < results.length; i++) {
      projectFlowCharts[i] = ProjectFlowChart.fromMap(results[i]);
    }
    return projectFlowCharts;
  }

  Future<ProjectFlowChart> getUserProjectFlowChart(
      int projectFlowChartId) async {
    final Database db = await SqliteService().initializeDB();
    List<Map> results = await db.query("project_flow_charts",
        where: "id = ?",
        whereArgs: [projectFlowChartId],
        columns: ProjectFlowChart.columns);

    ProjectFlowChart projectFlowChart = const ProjectFlowChart(
        id: 0, flowchartname: "", userid: 0, projectid: 0);
    for (int i = 0; i < results.length; i++) {
      projectFlowChart = ProjectFlowChart.fromMap(results[i]);
    }
    return projectFlowChart;
  }
}
