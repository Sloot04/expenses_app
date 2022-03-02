import 'dart:io';

import 'package:sqflite/sqflite.dart';

import "package:path/path.dart";
import 'package:expenses_app/src/db/recordatorios_db.dart';

class DB {
  static Future<Database> _openDB() async {
    String databasePath = await getDatabasesPath();

    String path = join(databasePath, 'expenses_db.db');

    // Make sure the directory exists
    try {
      //all non-existing path components are created. If the directory already exists nothing is done.
      await Directory(databasePath).create(recursive: true);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }

    // Una Base de datos para toda la app con varias tablas
    return openDatabase(
      path,
      onConfigure: ((db) => db.execute("PRAGMA foreign_keys = ON")),

      // When creating the db, create the table
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE recordatorios (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, recordatorio TEXT, fecha TEXT)");
      },

      version: 1,
    );
  }

//CRUD
//inserting data into a table. It returns the internal ID of the record (an integer).
  static Future<int> insert(Recordatorio recordatorio) async {
    Database database = await _openDB();
    return database.insert("recordatorios", recordatorio.toMap());
  }

//deleting content in a table. It returns the number of rows deleted.
  static Future<int> delete(Recordatorio recordatorio) async {
    Database database = await _openDB();
    return database
        .delete("recordatorios", where: 'id = ?', whereArgs: [recordatorio.id]);
  }

//updating content in a table. It returns the number of rows updated.
  static Future<int> update(Recordatorio recordatorio) async {
    Database database = await _openDB();
    return database.update("recordatorios", recordatorio.toMap(),
        where: 'id=?', whereArgs: [recordatorio.id]);
  }

//Reading a table content. It returns a list of map.
  static Future<List<Recordatorio>> getAll() async {
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
