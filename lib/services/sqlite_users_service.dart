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
}
