import 'package:flutter/material.dart';

class MusicPage extends StatefulWidget {
  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  TextEditingController _textEditingController = TextEditingController(text: '');

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
                print(_textEditingController.text);
              },
            )
          )
        ],
      ),
    );
  }
}