import 'package:flutter/material.dart';
import 'package:test/DB/Friend.dart';

import '../../Utils/RegisterValidation.dart';
import '../../Utils/Api.dart';
import '../../Models/User.dart';
import '../../Models/Friend.dart';
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
      body: ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: _registerWidget()
              ),
            ),
          )
        ]   
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
                  if(i == 0)
                    Container(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                      child: TextFormField(
                        controller: _controller[i],
                        validator: (_value) {
                          if(idValidation(_value)) {
                            return "5~20자 사이의 영어, 숫자으로만 적어주세요.";
                          }
                        },
                      ),
                    ),
                  if(i == 1)
                    Container(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                      child: TextFormField(
                        controller: _controller[i],
                        validator: (_value) {
                          if(nickIDValidation(_value)) {
                            return "2~5자 사이의 영어, 숫자으로만 적어주세요.";
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
          onPressed: () async {
            if(_formKey.currentState!.validate()) {
              User _user = User(
                name: _controller[0].text,
                nickName: _controller[1].text,
                password: _controller[2].text
              );
              Friend _friend = Friend(
                name: _controller[0].text,
                nickName: _controller[1].text
              );

              if(await signUp(_user)) {
                insertFriend(_friend);

                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
              }
              else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('회원가입에 오류가 발생했어요'),
                  )
                );
              }
            }
          },
        )
      ),
    );

    return _result;
  }
}