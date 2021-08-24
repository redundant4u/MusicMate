import 'package:flutter/material.dart';

import './Pages/MainPage.dart';

void main() => runApp(new BRPrincess());

class BRPrincess extends StatefulWidget {
  @override
  _BRPrincessState createState() => _BRPrincessState();
}

class _BRPrincessState extends State<BRPrincess> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage()
    );
  }
}