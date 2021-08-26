import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:encrypt/encrypt.dart';

import '../../Models/Music.dart';
import '../../Models/User.dart';
import '../../Models/Friend.dart';
import '../../DB/User.dart';

String url = "https://redundant4u.com/api/";

Future<bool> signUp(User user) async {
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

      return true;
    }
  }

  return false;
}

Future<bool> login(User user) async {
  final key = Key.fromUtf8(user.key!);
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  final decrypted = encrypter.decrypt(Encrypted.from64(user.password!), iv: iv);

  final _loginRequest = await http.post(
    Uri.parse(url + 'login'),
    headers: {
      "Content-Type": "application/json"
    },
    body: json.encode({
      "name": user.name,
      "password": decrypted
    })
  );
  Map<String, dynamic> _loginResponse = jsonDecode(_loginRequest.body);

  if(_loginResponse['statusCode'] == 200) {
    userTokenUpdate(_loginResponse['userToken']);
    return true;
  }
  else
    return false;
}

Future<List<Music>> searchMusic(String q) async {
  List<Music>? _musicList = [];
  final _searchMusicRequest = await http.get(
    Uri.parse(url + 'searchMusic?search=$q')
  );
  final _searchMusicResponse = jsonDecode(_searchMusicRequest.body);

  if(_searchMusicResponse['statusCode'] == 200) {
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

Future<List<Friend>> searchUsers(String q) async {
  List<Friend>? _friendsList = [];
  final User _user = await getUser();

  final _searchFriendsRequest = await http.post(
    Uri.parse(url + 'searchUser'),
    headers: {
      "Content-Type": "application/json"
    },
    body: json.encode({
      "userToken": _user.token,
      "userName": q
    })
  );
  Map<String, dynamic> _searchFriendsResponse = jsonDecode(_searchFriendsRequest.body);
  int _status = _searchFriendsResponse['statusCode'];
  print(_searchFriendsResponse);

  if(_status == 200) {
    for(var i in _searchFriendsResponse['items']) {
      Friend _friend = Friend(
        name: i['name'],
        nickName: i['nickName']
      );

      _friendsList.add(_friend);
    }
  }
  else if(_status == 401) {
    print('token expired');
    bool _updateToken = await login(_user);
    if(_updateToken)
      searchUsers(q);
  }

  return _friendsList;
}