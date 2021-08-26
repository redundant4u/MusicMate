import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:test/DB/Friend.dart';

import '../Models/Music.dart';
import '../Models/Friend.dart';
import '../DB/Music.dart';

class MusicListPage extends StatefulWidget {
  @override
  _MusicListPageState createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {
  AudioPlayer _player = AudioPlayer();

  bool isPlaying = false;
  int playMusicID = 0;
  int tabPageID = 0;

  @override
  void dispose() {
    super.dispose();
    _player.stop();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[        
        Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 15),
              height: 65.0,
              child: FutureBuilder<List<Friend>>(
                future: getFriendsList(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Container(
                            height: 55.0,
                            width: 55.0,
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              border: Border.all(
                                width: 1.0,
                                style: BorderStyle.solid,
                                color: Colors.black
                              )
                            ),
                            child: Center(
                              child: Text(snapshot.data![index].nickName!),
                            )
                          ),
                          onTap: () {
                            setState(() { tabPageID = index; });
                            print(index);
                          }
                        );
                      }
                    );
                  }
                  else {
                    return Text('');
                  }
                },
              ) 
            ),
          ],
        ),

        if(tabPageID == 0)
          Expanded(
            child: FutureBuilder<List<Music>>(
              future: getMusicList(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(color: Colors.black),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index].name!),
                        subtitle: Text(snapshot.data![index].artist!),
                        trailing: Wrap(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  musicDelete(snapshot.data![index].id!);
                                });
                              }
                            ),
                            IconButton(
                              icon: Icon(Icons.play_arrow),
                              onPressed: () {
                                int musicID = snapshot.data![index].id!;
                                String url = snapshot.data![index].url!;
                                String msg = "";

                                print('url: ' + url);
                          
                                if(url == 'empty')
                                  msg = "미리듣기 음악이 없습니다!";
                                else if(isPlaying && playMusicID == musicID) {
                                  _player.stop();
                                  isPlaying = false;
                                  msg = "듣기 취소";
                                }
                                else if(isPlaying && playMusicID != musicID) {
                                  _player.play(url);
                                  playMusicID = musicID;
                                  msg = "${snapshot.data![index].name} 듣는 중...";
                                }
                                else {
                                  _player.play(url);
                                  playMusicID = musicID;
                                  isPlaying = true;
                                  msg = "${snapshot.data![index].name} 듣는 중...";
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(msg),
                                    duration: const Duration(seconds: 1),
                                  )
                                );
                              }
                            ),
                          ]
                        )
                      );
                    },
                  );
                }

                else {
                  return Center(child: CircularProgressIndicator());
                }
              }
            )
          ),
        if(tabPageID != 0)
          Text('HI')
      ]
    );
  }
}