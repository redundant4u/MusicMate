import 'package:flutter/material.dart';

import '../../Utils/RegisterValidation.dart';
import '../../Models/User.dart';
import './MainPage.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final List<String> _registerName = [ "아이디", "닉네임", "비밀번호" ];
  final List<TextEditingController> _controller = [
    TextEditingController(), TextEditingController(), TextEditingController()
  ];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'MusicMate',
          style: TextStyle(
            color: Colors.black,
            fontSize: 35,
            fontWeight: FontWeight.bold
          )
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: _registerWidget()
          ),
        ),     
      )
    );
  }

  List<Widget> _registerWidget() {
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
                    child: Text(_registerName[i], style: TextStyle(color: Colors.black, fontSize: 20.0))
                  ),
                  if(i != 2)
                    Container(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                      child: TextFormField(
                        controller: _controller[i],
                        validator: (_value) {
                          if(idValidation(_value)) {
                            return "영어(소문자, 대문자)으로만 적어주세요.";
                          }
                        },
                      ),
                    ),
                  if(i == 2) 
                    Container(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                      child: TextFormField(
                        controller: _controller[i],
                        obscureText: true,
                        validator: (_value) {
                          if(passwordValidation(_value)) {
                            return "한 개 이상의 대문자, 소문자, 숫자를 포함한 8자 이상 필요.";
                          }
                        },
                      ),
                    ),
                ],
              ),
            )
          ]
        )
      );
    }

    _result.add(
      Container(
        child: ElevatedButton(
          child: Text('확인'),
          onPressed: () {
            if(_formKey.currentState!.validate()) {
              User _user = User(
                name: _controller[0].text,
                nickName: _controller[1].text,
                password: _controller[2].text
              );

              // userInsert(_user);
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
            }
          },
        )
      ),
    );

    return _result;
  }
}