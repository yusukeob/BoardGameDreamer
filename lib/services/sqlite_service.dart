import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:board_game_dreamer/models/user.dart';

class SqliteService {
  Future<Database> initializeDB() async {
    final dbDirectory = await getApplicationSupportDirectory();

    return openDatabase(
      join(dbDirectory.path, 'bgd_database.db'),
      onCreate: (database, version) async {
        return database.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, username TEXT, password TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<int> createUser(User user) async {
    final Database db = await initializeDB();
    final id = await db.insert('users', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<User>> getAllUsers() async {
    final Database db = await initializeDB();
    List<Map> results =
        await db.query("users", columns: User.columns, orderBy: "id ASC");

    List<User> users = List<User>.filled(
        results.length, const User(id: 0, username: "", password: ""));
    for (int i = 0; i < results.length; i++) {
      users[i] = User.fromMap(results[i]);
    }
    return users;
  }
}
