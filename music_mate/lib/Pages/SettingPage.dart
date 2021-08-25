import 'package:flutter/material.dart';

import './PrivacyInformation.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final List<String> _titles = [ '개인정보' ];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(color: Colors.black),
      itemCount: _titles.length,
      itemBuilder: (BuildContext context, int i) {
        return ListTile(
          title: Text(_titles[i]),
          onTap: () {
            switch(i) {
              case 0:
                Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyInformation()));
                break;
            }
          }
        );
      },
    );
  }
}