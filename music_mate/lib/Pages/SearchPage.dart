import 'package:flutter/material.dart';

import './Search/MusicPage.dart';
import 'Search/UserPage.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('찾아보기', style: TextStyle(color: Colors.black))
      ),

      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Container(
            child: TabBar(
              indicatorColor: Colors.black,
              labelStyle: TextStyle(fontSize: 20),
              labelColor: Colors.black,
              unselectedLabelStyle: TextStyle(fontSize: 15),
              controller: _tabController,
              tabs: <Tab>[
                Tab(text: '음악 검색'),
                Tab(text: '친구 검색')
              ]
            )
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                _musicPage(),
                _friendsPage()
              ],
            )
          )
        ],
      )
    );
  }
}

Widget _musicPage() { return MusicPage(); }
Widget _friendsPage() { return UserPage(); }