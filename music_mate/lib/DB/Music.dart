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

void insert(Music data) async {
  final Database? _db = await DB.instance.database;

  Music _music = Music(
    name  : data.name,
    artist: data.artist,
    url   : data.url
  );

  await _db!.insert('music', _music.toMap());
}