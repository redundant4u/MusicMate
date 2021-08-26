import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:encrypt/encrypt.dart';

import '../../Models/Music.dart';
import '../../Models/User.dart';
import '../../DB/User.dart';

String url = "https://redundant4u.com/api/";

void signUp(User user) async {
  final _idCheckRequest = await http.get(
    Uri.parse(url + 'idDuplicateCheck?id=${user.name}')
  );
  Map<String, dynamic> _idCheckResponse = jsonDecode(_idCheckRequest.body);

  if(_idCheckResponse['statusCode'] == 200 && _idCheckResponse['status'] == 'Allow') {
    final _signUpRequest = await http.post(
      Uri.parse(url + 'signUp'),
      headers: {
      "Content-Type": "application/json"
      },
      body: json.encode({
        "name": user.name,
        "nickName": user.nickName,
        "password": user.password
      })
    );
    Map<String, dynamic> _signUpResponse = jsonDecode(_signUpRequest.body);

    if(_signUpResponse['statusCode'] == 200) {    
      final key = Key.fromUtf8(_signUpResponse['key']);
      final iv = IV.fromLength(16);
      final encrypter = Encrypter(AES(key));
      final encrypted = encrypter.encrypt(user.password!, iv: iv);

      User _user = User(
        name: user.name,
        nickName: user.nickName,
        password: encrypted.base64,
        token: _signUpResponse['token'],
        key: _signUpResponse['key']
      );

      userInsert(_user);
    }
  }
}

void login(User user) {
  Map data = {
    "name": user.name,
    "password": user.password,
  };

  // final response = await http.post(
  //   Uri.parse(url + 'login'),
  //   headers: {
  //     "Content-Type": "application/json"
  //   },
  //   body: json.encode(data)
  // );


}

Future<List<Music>> searchMusic(String q) async {
  List<Music>? _musicList = [];
  final _searchMusicRequest = await http.get(
    Uri.parse(url + 'searchMusic?search=$q')
  );
  final _searchMusicResponse = jsonDecode(_searchMusicRequest.body);
  print(_searchMusicResponse);

  if(_searchMusicResponse['statusCode'] == 200) {
    print('good');
    Music _music = Music();

    for(var i in _searchMusicResponse['items']) {
      Music _music = Music(
        name: i['musicName'],
        artist: i['artist'],
        url: i['musicPreview'] ?? 'empty'
      );
      _musicList.add(_music);
    }
  }

  return _musicList;
}