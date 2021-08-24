import 'package:flutter/material.dart';

import '../Utils/ShowPage.dart';
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
        title: Text(
          "NAME",
          style: TextStyle(color: Colors.black, fontSize: 30)
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Colors.black, size: 30),
            onPressed: () { _searchPage(); },
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage() ));
  }
}