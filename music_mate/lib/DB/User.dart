import 'package:sqflite/sqflite.dart';
import 'package:encrypt/encrypt.dart';

import './DBHelper.dart';
import '../Models/User.dart';

void insert(User data) async {
  final Database? _db = await DB.instance.database;

  User _user = User(
    name     : data.name,
    nick_name: data.nick_name,
  );

  await _db!.insert('user', _user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
}