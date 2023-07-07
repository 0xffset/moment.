import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DataBaseHelper {
  static Future<Database> database() async {
    final datapath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(datapath, 'moment.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE moments (id TEXT PRIMARY KEY, title TEXT, description TEXT, image TEXT, time TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String,Object> data) async {
    final db = await DataBaseHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db= await DataBaseHelper.database();
    return db.query(table);
  }
}
