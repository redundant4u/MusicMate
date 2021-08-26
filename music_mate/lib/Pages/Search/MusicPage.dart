import 'package:flutter/material.dart';

import '../../Utils/Api.dart';
import '../../Models/Music.dart';
import '../../DB/Music.dart';
class MusicPage extends StatefulWidget {
  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  TextEditingController _textController = TextEditingController(text: '');
  List<Music>? _musicList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: '음악 제목',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0)
                )
              ),
              onEditingComplete: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('검색 중...'),
                    duration: const Duration(seconds: 1)
                  )
                );
                searchMusic(_textController.text).then((data) {
                    setState(() { _musicList = data; });
                  }
                );
              },
            ),
          ),

          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => Divider(color: Colors.black),
              itemCount: _musicList!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_musicList![index].name!),
                  subtitle: Text(_musicList![index].artist!),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () async {
                      if(await insertMusic(_musicList![index])) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('음악이 추가되었어요'),
                            duration: const Duration(seconds: 1),
                          )
                        );
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('이미 추가된 음악에요'),
                            duration: const Duration(seconds: 1),
                          )
                        );
                      }
                    },
                  ),
                );
              },
            )
          )
        ],
      ),
    );
  }
}