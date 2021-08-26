import 'package:sqflite/sqflite.dart';

import './DBHelper.dart';
import '../Models/User.dart';

Future<User> getUser() async {
  final Database? _db = await DB.instance.database;
  final List<Map<String, dynamic>> _maps = await _db!.rawQuery('SELECT * FROM user WHERE id = 1');
  User _user = User();

  if(_maps.isNotEmpty) {
    _user = User(
      name    : _maps[0]['name'],
      nickName: _maps[0]['nickName'],
      password: _maps[0]['password'],
      token   : _maps[0]['token'],
      key     : _maps[0]['key'],
    );
  }

  return _user;
}

void userInsert(User data) async {
  final Database? _db = await DB.instance.database;

  User _user = User(
    name    : data.name,
    nickName: data.nickName,
    password: data.password,
    token   : data.token,
    key     : data.key
  );

  await _db!.insert('user', _user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
}

void userTokenUpdate(String token) async {
  final Database? _db = await DB.instance.database;
  _db!.rawQuery("UPDATE user SET token = '$token' WHERE id = 1");
}