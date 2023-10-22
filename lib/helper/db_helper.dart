import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await createDatabase();
    return _database;
  }

  Future<Database> createDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'appk_data.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE wishlist (id INTEGER PRIMARY KEY, uid TEXT, itemname TEXT, price TEXT, description TEXT)");
    });
  }
}
