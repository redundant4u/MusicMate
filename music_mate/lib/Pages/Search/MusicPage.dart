import 'package:flutter/material.dart';

import '../../Utils/Api.dart';
import '../../Models/Music.dart';
import '../../DB/Music.dart';
class MusicPage extends StatefulWidget {
  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  TextEditingController _textEditingController = TextEditingController(text: '');
  List<Music>? musicList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _textEditingController,
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
                setState(() {
                  musicList = apiRequest(_textEditingController.text);
                });
              },
            ),
          ),

          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => Divider(color: Colors.black),
              itemCount: musicList!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(musicList![index].name!),
                  subtitle: Text(musicList![index].artist!),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      musicInsert(musicList![index]);
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