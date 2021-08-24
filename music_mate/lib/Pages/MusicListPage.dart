import 'package:flutter/material.dart';

import '../Models/Music.dart';
import '../DB/Music.dart';

class MusicListPage extends StatefulWidget {
  @override
  _MusicListPageState createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> _peopleList = _getPeopleList();

    return Column(
      children: <Widget>[        
        Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 60.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _peopleList
              ),
            ),
          ],
        ),

        Container(
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
                    );
                  },
                );
              }

              else {
                return Center(child: CircularProgressIndicator());
              }
            }
          )
        )
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