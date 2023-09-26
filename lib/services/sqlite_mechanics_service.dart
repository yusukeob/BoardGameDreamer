import "package:sqflite/sqflite.dart";

import "package:board_game_dreamer/models/mechanic.dart";
import "package:board_game_dreamer/services/sqlite_service.dart";

class SqliteMechanicsService {
  Future<int> createMechanic(Mechanic mechanic) async {
    final Database db = await SqliteService().initializeDB();
    final id = await db.insert("mechanics", mechanic.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<Mechanic>> getMechanics() async {
    final Database db = await SqliteService().initializeDB();
    List<Map> results = await db.query("mechanics",
        columns: Mechanic.columns, orderBy: "id ASC");

    List<Mechanic> mechanics = List<Mechanic>.filled(results.length,
        const Mechanic(id: 0, mechanicname: "", mechanicexplanation: ""));
    for (int i = 0; i < results.length; i++) {
      mechanics[i] = Mechanic.fromMap(results[i]);
    }
    return mechanics;
  }

  Future<Mechanic> getMechanic(int mechanicId) async {
    final Database db = await SqliteService().initializeDB();
    List<Map> results = await db.query("mechanics",
        where: "id = ?", whereArgs: [mechanicId], columns: Mechanic.columns);

    Mechanic mechanic = const Mechanic(
      id: 0,
      mechanicname: "",
      mechanicexplanation: "",
    );
    for (int i = 0; i < results.length; i++) {
      mechanic = Mechanic.fromMap(results[i]);
    }
    return mechanic;
  }
}
