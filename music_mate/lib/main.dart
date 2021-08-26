import 'package:flutter/material.dart';

import './Pages/MainPage.dart';
import './Pages/SignUpPage.dart';
import './DB/User.dart';
import './Models/User.dart';

void main() => runApp(new BRPrincess());

class BRPrincess extends StatefulWidget {
  @override
  _BRPrincessState createState() => _BRPrincessState();
}

class _BRPrincessState extends State<BRPrincess> {
  Widget? _widget;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<User>(
        future: getUser(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            print(snapshot.data);
            if(snapshot.data!.name != null)
              _widget = MainPage();
            else
              _widget = SignUpPage();

            return _widget!;
          }
          else {
            return Scaffold(
              body: Center(
                child: Text('로딩 중...'),
              )
            );
          }
        },
      )
    );
  }
}