import 'package:flutter/material.dart';

class XHErrorScreen extends StatelessWidget {
  static final String routeName = "/error";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("错误页面"),
      ),
      body: Center(
        child: Container(
          child: Text("错误页面"),
        ),
      ),
    );
  }
}
