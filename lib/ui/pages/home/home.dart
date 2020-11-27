import 'package:flutter/material.dart';

class XHHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("主页主页"),
        centerTitle: true,
        // leading: Icon(null),
        automaticallyImplyLeading: false, // 隐藏返回按钮
      ),
      body: Center(child: Text("主页页面")),
    );
  }
}
