import 'package:flutter/material.dart';

import '../DB/User.dart';
import '../Models/User.dart';

class PrivacyInformation extends StatefulWidget {
  @override
  _PrivacyInformationState createState() => _PrivacyInformationState();
}

class _PrivacyInformationState extends State<PrivacyInformation> {
  final List<String> _infoName = [ "아이디", "닉네임", "비밀번호" ];
  final List<TextEditingController> _controller = [
    TextEditingController(), TextEditingController(), TextEditingController()
  ];

  @override
  void initState() {
    super.initState();
    _getUserFromDB();
  }

  void _getUserFromDB() async {
    User _user = await getUser();

    _controller[0].text = _user.name!;
    _controller[1].text = _user.nickName!;
    _controller[2].text = _user.password!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('개인정보', style: TextStyle(color: Colors.black))
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          children: _infoWidget()
        )
      )
    );
  }

  List<Widget> _infoWidget() {
    List<Widget> _result = [];

    for(int i = 0; i < 3; i++) {
      _result.add(
        Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(15.0),
                    child: Text(_infoName[i], style: TextStyle(color: Colors.black, fontSize: 20.0))
                  ),
                  if(i != 2)
                    Container(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                      child: TextFormField(
                        readOnly: true,
                        controller: _controller[i],
                      ),
                    ),
                  if(i == 2)
                    Container(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                      child: TextFormField(
                        readOnly: true,
                        obscureText: true,
                        controller: _controller[i],
                      ),
                    )
                ]
              )
            )
          ]
        )
      );
    }

    return _result;
  }
}