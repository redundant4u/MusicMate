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
        await db.execute("CREATE TABLE music  (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, artist TEXT, url TEXT)");
        await db.execute("CREATE TABLE friend (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, nickName TEXT)");

        await db.execute("INSERT INTO music VALUES(1, '걘 아니야 pt.2', 'PENOMECO', 'https://p.scdn.co/mp3-preview/2ac71d872afdd43422743ab5bb87c863bb312db6?cid=774b29d4f13844c495f206cafdad9c86')");
        await db.execute("INSERT INTO music VALUES(2, 'ASAP', 'STAYC', 'https://p.scdn.co/mp3-preview/a81224931c8796a921098700579c8df28f1404ea?cid=774b29d4f13844c495f206cafdad9c86')");
        await db.execute("INSERT INTO music VALUES(3, 'Oxytocin', 'Bille Eilish', 'null')");
        await db.execute("INSERT INTO music VALUES(4, 'New Light', 'John Mayer', 'https://p.scdn.co/mp3-preview/20ab6b40b861a8a6cb591289aee36cdbce44dcf9?cid=774b29d4f13844c495f206cafdad9c86')");
        await db.execute("INSERT INTO music VALUES(5, '쩔어', '방탄소년단', 'https://p.scdn.co/mp3-preview/251187419b30d11c8d8f2b93725b1f4f61018d46?cid=774b29d4f13844c495f206cafdad9c86')");
      }
    );
  }
}