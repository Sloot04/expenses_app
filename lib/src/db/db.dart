import 'package:sqflite/sqflite.dart';

import "package:path/path.dart";
import 'package:expenses_app/src/db/recordatorios_db.dart';

class DB {
  static Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), "recordatorios.db"),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE recordatorios (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, recordatorio TEXT, fecha TEXT)");
      },
      version: 1,
    );
  }

//CRUD

  static Future<dynamic> insert(Recordatorio recordatorio) async {
    Database database = await _openDB();
    return database.insert("recordatorios", recordatorio.toMap());
  }

  static Future<dynamic> delete(Recordatorio recordatorio) async {
    Database database = await _openDB();
    return database
        .delete("recordatorios", where: 'id= ?', whereArgs: [recordatorio.id]);
  }

  static Future<dynamic> update(Recordatorio recordatorio) async {
    Database database = await _openDB();
    return database.update("recordatorios", recordatorio.toMap(),
        where: 'id=?', whereArgs: [recordatorio.id]);
  }

  static Future<dynamic> getAll() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> recordatoriosMap =
        await database.query("recordatorios");

    return List.generate(
      recordatoriosMap.length,
      (index) => Recordatorio(
          id: recordatoriosMap[index]["id"],
          recordatorio: recordatoriosMap[index]["recordatorio"],
          fecha: recordatoriosMap[index]["fecha"]),
    );
  }

  static Future<dynamic> getByDate(Recordatorio recordatorio) async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> recordatoriosMap = await database.query(
        "recordatorios",
        where: 'fecha = ?',
        whereArgs: [recordatorio.fecha]);

    return List.generate(
      recordatoriosMap.length,
      (index) => Recordatorio(
          id: recordatoriosMap[index]["id"],
          recordatorio: recordatoriosMap[index]["recordatorio"],
          fecha: recordatoriosMap[index]["fecha"]),
    );
  }
}
