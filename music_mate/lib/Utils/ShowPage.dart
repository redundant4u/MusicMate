import 'package:flutter/material.dart';

import '../Pages/MusicListPage.dart';
import '../Pages/SettingPage.dart';

Widget showPage(int i) {
  Widget widget;

  switch(i) {
    case 0:  widget = MusicListPage(0); break;
    case 1:  widget = SettingPage();   break;
    default: widget = MusicListPage(0); break;
  }

  return widget;
}