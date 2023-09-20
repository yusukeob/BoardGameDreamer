import 'package:sqflite/sqflite.dart';

import 'package:board_game_dreamer/models/user.dart';
import 'package:board_game_dreamer/services/sqlite_service.dart';

class SqliteUsersService {
  Future<int> createUser(User user) async {
    final Database db = await SqliteService().initializeDB();
    final id = await db.insert('users', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<User>> getAllUsers() async {
    final Database db = await SqliteService().initializeDB();
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
