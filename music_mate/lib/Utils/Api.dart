import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:encrypt/encrypt.dart';
import 'package:test/DB/Music.dart';

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
    await userTokenUpdate(_loginResponse['userToken']);
    return true;
  }
  else
    return false;
}

Future<List<Music>> searchMusic(String q) async {
  Set<Music>? _musicList = {};
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

  return _musicList.toList();
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
    bool _updateToken = await login(_user);
    if(_updateToken)
      return await searchUsers(q);
  }

  return _friendsList;
}

// method=add or mehtod=delete
void insertFriendForServer(Friend friend) async {
  final User _user = await getUser();

  final _insertFriendRequest = await http.post(
    Uri.parse(url + 'updateFriendList?method=add'),
    headers: {
      "Content-Type": "application/json"
    },
    body: json.encode({
      "userToken": _user.token,
      "friendName": friend.name
    })
  );
  Map<String, dynamic> _insertFriendResponse = jsonDecode(_insertFriendRequest.body);

  if(_insertFriendResponse['statusCode'] == 401) {
    await login(_user);
    insertFriendForServer(friend);
  }
}

Future<bool> insertMusicForServer(Music music) async {
  final User _user = await getUser();

  if(!await isduplicatedMusic(music)) {
    final _insertMusicRequest = await http.post(
    Uri.parse(url + 'updateMusicList/add'),
      headers: {
        "Content-Type": "apllication/json"
      },
      body: json.encode({
        "userToken": _user.token,
        "name": music.name,
        "artist": music.artist,
        "preview_url": music.url,
        "albumart_url": "",
        "album_name": ""
      })
    );
    Map<String, dynamic> _insertMusicResponse = jsonDecode(_insertMusicRequest.body);

    if(_insertMusicResponse['statusCode'] == 200) {
      music.musicId = _insertMusicResponse['musicId'];
      insertMusic(music);

      return true;
    }
    else if(_insertMusicResponse['statusCode'] == 401) {
      await login(_user);
      return await insertMusicForServer(music);
    }
  }

  return false;
}

Future<List<Music>> getFriendMusic(String name) async {
  final User _user = await getUser();
  List<Music> _friendMusicList = [];

  final _getFriendRequest = await http.post(
  Uri.parse(url + 'getMusicList'),
    headers: {
      "Content-Type": "apllication/json"
    },
    body: json.encode({
      "userToken": _user.token,
      "friendName": name
    })
  );
  Map<String, dynamic> _getFriendResponse = jsonDecode(_getFriendRequest.body);

  if(_getFriendResponse['statusCode'] == 200) {
    for(var i in _getFriendResponse['items']) {
      Music _music = Music(
        musicId: i['musicID'],
        name: i['musicName'],
        artist: i['artist'],
        url: i['musicPreview']
      );
      _friendMusicList.add(_music);
    }
  }

  else if(_getFriendResponse['statusCode'] == 401) {
    await login(_user);
    return await getFriendMusic(name);
  }
  
  return _friendMusicList;
}