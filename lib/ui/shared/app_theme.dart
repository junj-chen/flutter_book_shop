import 'package:flutter/material.dart';

class XHAppTheme {
  // 1. 公共属性
  static const double bodyFontSize = 14;
  static const double smallFontSize = 16;
  static const double normalFontSize = 20;
  static const double largeFontSize = 24;

  // 2. 普通模式
  static final Color norTextColors = Colors.red;

  static final ThemeData norTheme = ThemeData(
      // 该颜色包括了 导航栏、以及button的颜色
      primarySwatch: Colors.blue,
      accentColor: Colors.blueAccent,
      // 设置背景颜色
      // canvasColor: Color.fromRGBO(255, 254, 222, 1),
      textTheme: TextTheme(
        body1: TextStyle(fontSize: bodyFontSize, color: Colors.black),
        display1: TextStyle(fontSize: smallFontSize, color: Colors.black),
        display2: TextStyle(fontSize: normalFontSize, color: Colors.black),
        display3: TextStyle(fontSize: largeFontSize, color: Colors.black),
      ));

  // 3. 暗黑模式
  static final Color darkTextColors = Colors.green;

  static final ThemeData darkTheme = ThemeData(
      primarySwatch: Colors.grey,
      textTheme: TextTheme(
          body1: TextStyle(fontSize: normalFontSize, color: darkTextColors)));
}
