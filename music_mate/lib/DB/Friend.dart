import 'package:sqflite/sqflite.dart';

import '../DB/DBHelper.dart';
import '../Models/Friend.dart';

void friendInsert(Friend data) async {
  final Database? _db = await DB.instance.database;

  Friend _friend = Friend(
    name    : data.name,
    nickName: data.nickName
  );

  await _db!.insert('friend', _friend.toMap());
}

Future<List<Friend>> getFriendsList() async {
  final Database? _db = await DB.instance.database;
  final List<Map<String, dynamic>> _maps = await _db!.query('friend');

  return List.generate(_maps.length, (i) {
    return Friend(
      name    : _maps[i]['name'],
      nickName: _maps[i]['nickName']
    );
  });
}