import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteDatabase {
  Database? _database;

  Future<Database> openData() async {
    if (_database != null) return _database!;
    final databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'rick_and_morty.db');
    _database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return _database!;
  }

  Future<void> _onCreate(Database database, int version) async {
    await database.execute('''
            CREATE TABLE IF NOT EXISTS character (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            status TEXT NOT NULL,
            species TEXT NOT NULL,
            gender TEXT NOT NULL,
            location_name TEXT NOT NULL,
            origin_name TEXT NOT NULL,
            image TEXT NOT NULL,
            like_status INTEGER NOT NULL DEFAULT 0  
            )
           ''');
  }
}
