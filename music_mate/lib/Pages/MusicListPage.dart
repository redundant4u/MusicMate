import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../Models/Music.dart';
import '../DB/Music.dart';

class MusicListPage extends StatefulWidget {
  @override
  _MusicListPageState createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {
  AudioPlayer _player = AudioPlayer();

  bool isPlaying = false;
  int playMusicID = 0;

  @override
  void dispose() {
    super.dispose();
    _player.stop();
  }
  
  @override
  Widget build(BuildContext context) {
    List<Widget> _peopleList = _getPeopleList();

    return Column(
      children: <Widget>[        
        Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 15),
              height: 60.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _peopleList
              ),
            ),
          ],
        ),

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
                      trailing: IconButton(
                        icon: Icon(Icons.play_arrow),
                        onPressed: () {
                          int musicID = snapshot.data![index].id!;
                          String url = snapshot.data![index].url!;
                          
                          if(url == 'null') {
                            print('no music');
                          }
                          else if(isPlaying && playMusicID == musicID) {
                            _player.stop();
                            isPlaying = false;
                            print('stop');
                          }
                          else if(isPlaying && playMusicID != musicID) {
                            _player.play(url);
                           playMusicID = musicID;
                            print('another music');
                          }
                          else {
                            _player.play(url);
                            playMusicID = musicID;
                            isPlaying = true;
                            print('play');
                          }
                        }
                      ),
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
      ]
    );
  }
}

List<Widget> _getPeopleList() {
  List<Widget> _result = [];
  for(int i = 0; i < 10; i++) {
      _result.add(
        GestureDetector(
          child: Container(
            height: 50.0,
            width: 50.0,
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
              child: Text("hello"),
            )
          ),
          onTap: () {
            print(i);
          }
        ),
      );
    }
  
  return _result;
}