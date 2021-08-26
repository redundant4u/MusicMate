import 'package:flutter/material.dart';
import 'package:test/DB/Friend.dart';

import '../../Models/Friend.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  TextEditingController _textController = TextEditingController(text: '');
  List<Friend>? friendsList = [
    Friend(name: 'jseori', nickName: '설'),
    Friend(name: 'chaewon', nickName: '채원'),
    Friend(name: 'seungil', nickName: '승길'),
  ];

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
                hintText: '친구 아이디',
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
                  // friendsList = apiRequest();
                });
              }
            ),
          ),

          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => Divider(color: Colors.black),
              itemCount: friendsList!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(friendsList![index].name!),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      friendInsert(friendsList![index]);
                      print('insert!');
                    },
                  ),
                );
              },
            )
          )
        ]
      )
    );
  }
}