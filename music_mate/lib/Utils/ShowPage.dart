import 'package:flutter/material.dart';

import '../Pages/MusicListPage.dart';
import '../Pages/SettingPage.dart';

Widget showPage(int i) {
  Widget widget;

  print(i);

  switch(i) {
    case 0:  widget = MusicListPage(); break;
    case 1:  widget = SettingPage();   break;
    default: widget = MusicListPage(); break;
  }

  return widget;
}