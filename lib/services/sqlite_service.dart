import 'package:board_game_dreamer/services/sqlite_mechanics_service.dart';
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
        await database.execute(
            'CREATE TABLE mechanics(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, mechanicname TEXT, mechanicexplanation TEXT)');
        await database.execute(
            'CREATE TABLE project_mechanics(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, mechanicname TEXT, mechanicexplanation TEXT, userid INTEGER, projectid INTEGER, mechanicid INTEGER, projectapplication TEXT)');
        await database.rawInsert(
            'INSERT INTO "mechanics"("mechanicname", "mechanicexplanation") VALUES("Worker Placement", "Place tokens or workers on spaces to perform actions."),("Auction", "Bid a secret amount to achieve an object, such as priority for deciding turn order."), ("Deck Building", "Build your deck from a choice of cards. There are usually certain limitations but also freedom in choosing.");');
      },
      version: 1,
    );
  }
}
