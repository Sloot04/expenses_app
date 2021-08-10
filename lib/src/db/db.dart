import 'package:sqflite/sqflite.dart';

import "package:path/path.dart";
import 'package:expenses_app/src/db/recordatorios_db.dart';

class DB {
  static Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), "recordatorios.db"),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE recordatorios (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, recordatorio TEXT, fecha INTEGER)");
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

  static Future<List<Recordatorio>> getAll() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> recordatorioList = await database.query(
      "recordatorios",
      orderBy: 'fecha',
    );

    return List.generate(
      recordatorioList.length,
      (index) => Recordatorio(
          id: recordatorioList[index]["id"],
          recordatorio: recordatorioList[index]["recordatorio"],
          fecha: recordatorioList[index]["fecha"]),
    );
  }
/* 
   static Future<List<Recordatorio>> getByDate(
      DateTime day) async {
   
    Database database = await _openDB();
    final List<Map<String, dynamic>> recordatoriosMap = await database.query(
      "recordatorios",
      where: 'fecha = ? ',
      whereArgs: [day],
      orderBy: 'fecha',
    );

    return List.generate(
      recordatoriosMap.length,
      (index) => Recordatorio(
          id: recordatoriosMap[index]["id"],
          recordatorio: recordatoriosMap[index]["recordatorio"],
          fecha: recordatoriosMap[index]["fecha"]),
    );
  } */

  static Future<List<Recordatorio>> getByDate(
      DateTime start, DateTime end) async {
    int startSec = (start.millisecondsSinceEpoch / 1000).floor();
    int endSec = (end.millisecondsSinceEpoch / 1000).floor();
    Database database = await _openDB();
    final List<Map<String, dynamic>> recordatoriosMap = await database.query(
      "recordatorios",
      where: 'fecha >= ? and fecha < ?',
      whereArgs: [startSec, endSec],
      orderBy: 'fecha',
    );

    return List.generate(
      recordatoriosMap.length,
      (index) => Recordatorio(
          id: recordatoriosMap[index]["id"],
          recordatorio: recordatoriosMap[index]["recordatorio"],
          fecha: recordatoriosMap[index]["fecha"]),
    );
  }
}
