import 'package:flutter/material.dart';
import 'package:test/DB/User.dart';

import '../Utils/ShowPage.dart';
import '../Models/User.dart';
import './SearchPage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: false,
        title: FutureBuilder<User>(
          future: getUser(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  snapshot.data!.nickName!,
                  style: TextStyle(color: Colors.black, fontSize: 35)
                )
              );
            }
            else {
              return Text('');
            }
          },
        ),
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
            icon: Icon(Icons.add, color: Colors.black, size: 30),
              onPressed: () {
                _searchPage();
              },
            ),
          ),
        ],
      ),

      body: showPage(_index),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        onTap: (int _index) {
          setState(() { this._index = _index; });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey, size: 40),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.grey, size: 40),
            label: ''
          )
        ]
      ),
    );
  }

  void _searchPage() {
   // 목록 추가한 후 데이터 업데이트
    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage())).then((_) {
      setState(() {});
    });
  }
}