import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {
  Future<Database> initializeDB() async {
    final dbDirectory = await getApplicationSupportDirectory();

    return openDatabase(
      join(dbDirectory.path, 'board_game_dreamer_database.db'),
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, username TEXT, password TEXT)');
        await database.execute(
            'CREATE TABLE projects(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, projectname TEXT, userid INTEGER)');
        await database.execute(
            'CREATE TABLE project_flow_charts(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, flowchartname TEXT, userid INTEGER, projectid INTEGER)');
      },
      version: 1,
    );
  }
}
