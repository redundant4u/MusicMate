import 'package:sqflite/sqflite.dart';

import '../DB/DBHelper.dart';
import '../Models/Music.dart';

Future<List<Music>> getMusicList() async {
  final Database? _db = await DB.instance.database;
  final List<Map<String, dynamic>> _maps = await _db!.query('music');

  return List.generate(_maps.length, (i) {
    return Music(
      id    : _maps[i]['id'],
      name  : _maps[i]['name'],
      artist: _maps[i]['artist'],
      url   : _maps[i]['url'],
    );
  });
}

Future<bool> isduplicatedMusic(Music data) async {
  final Database? _db = await DB.instance.database;
  final List<Map<String, dynamic>> _maps = await _db!.rawQuery("SELECT musicId FROM music");

  for(var i in _maps) {
    if(i['musicId'] == data.musicId)
      return true;
  }

  return false;
}

void insertMusic(Music data) async {
  final Database? _db = await DB.instance.database;

  Music _music = Music(
    name  : data.name,
    artist: data.artist,
    url   : data.url,
    musicId: data.musicId
  );
  await _db!.insert('music', _music.toMap());
}

void deleteMusic(int id) async {
  final Database? _db = await DB.instance.database;
  await _db!.delete('music', where: "id = ?", whereArgs: [id]);
}