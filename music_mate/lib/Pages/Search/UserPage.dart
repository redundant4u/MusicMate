import 'package:flutter/material.dart';
import 'package:test/DB/Friend.dart';

import '../../Models/Friend.dart';
import '../../Utils/Api.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  TextEditingController _textController = TextEditingController(text: '');
  List<Friend>? _friendsList = [];

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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('검색 중...'),
                    duration: const Duration(seconds: 1)
                  )
                );
                searchUsers(_textController.text).then((data) {
                  setState(() { _friendsList = data; });
                });
              }
            ),
          ),

          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => Divider(color: Colors.black),
              itemCount: _friendsList!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_friendsList![index].name!),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () async {
                      if(await insertFriend(_friendsList![index])) {
                        insertFriendForServer(_friendsList![index]);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('친구가 추가되었어요'),
                            duration: const Duration(seconds: 1),
                          )
                        );
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('이미 추가한 친구에요'),
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
        ]
      )
    );
  }
}