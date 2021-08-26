import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static const databaseName = "1.db";
  static Database? _database;

  DB._privateConstructor();
  static final DB instance = DB._privateConstructor();

  Future<Database?> get database async {
    if(_database == null) return await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), databaseName),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE user   (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, nickName TEXT, password TEXT, token TEXT, key TEXT)");
        await db.execute("CREATE TABLE music  (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, artist TEXT, url TEXT, musicId INTEGER)");
        await db.execute("CREATE TABLE friend (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, nickName TEXT)");
      }
    );
  }
}