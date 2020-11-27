import 'package:flutter/material.dart';
import 'package:xinhuashop/core/extension/int_extension.dart';
import 'package:xinhuashop/ui/pages/main/main.dart';

class XHLoginScreen extends StatefulWidget {
  static final String routeName = "/login";

  @override
  _XHLoginScreenState createState() => _XHLoginScreenState();
}

class _XHLoginScreenState extends State<XHLoginScreen> {
  final loginFormKey = GlobalKey<FormState>();

  String _userName, _password;

  void login() {
    loginFormKey.currentState.save();
    loginFormKey.currentState.validate();

    print("账号： $_userName --- 密码： $_password");

    // 验证成功  -- 可以将该账号的权限等信息 放入provider中 ，然后进行跳转
    Navigator.of(context).pushNamed(XHMainScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录页面"),
      ),
      body: Form(
        key: loginFormKey,
        child: ListView(
          children: <Widget>[
            // 放置 图片
            SizedBox(height: 80.px),
            buildInput(Icon(Icons.people), "账号"),
            buildInput(Icon(Icons.lock), "密码"),
            SizedBox(height: 16.px),
            buildBottom(),
            SizedBox(height: 16.px),
            Divider(),
            buildForgetOrregister(context)
          ],
        ),
      ),
    );
  }

  // 3. 忘记密码 与 注册

  Widget buildForgetOrregister(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.px, right: 20.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlatButton(
            child: Text(
              "忘记密码？",
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            onPressed: () {
              // 忘记密码执行的操作
            },
          ),
          FlatButton(
            child: Text(
              "快速注册",
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            onPressed: () {
              // 跳转到注册页面
            },
          )
        ],
      ),
    );
  }

  // 2. 登录按钮
  Widget buildBottom() {
    return Container(
      margin: EdgeInsets.only(left: 30.px, right: 30.px),
      child: RaisedButton(
        color: Colors.blue,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Text(
          "登录",
          style: Theme.of(context)
              .textTheme
              .display2
              .copyWith(color: Colors.white),
        ),
        onPressed: () {
          print("点击了登录按钮");
          login();
        },
      ),
    );
  }

// 1. 输入框
  Widget buildInput(Icon icon, String labelText) {
    return Container(
      margin: EdgeInsets.only(left: 20.px, right: 20.px),
      child: TextFormField(
        decoration:
            InputDecoration(icon: Icon(Icons.people), labelText: labelText),
        onSaved: (newValue) {
          _userName = newValue;
        },
        validator: (value) {
          if (value.isEmpty) {
            return "输入不能为空";
          }
          return null;
        },
      ),
    );
  }
}
