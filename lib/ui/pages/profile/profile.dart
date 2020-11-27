import 'package:flutter/material.dart';
import 'package:xinhuashop/core/extension/int_extension.dart';
import 'package:xinhuashop/ui/pages/address/address.dart';
import 'package:xinhuashop/ui/pages/order/order.dart';

class XHProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("个人主页"),
        // elevation: 0,
        centerTitle: true,
        leading: Icon(null),
      ),
      body: ListView(
        children: <Widget>[
          _topHeader(context),
          _buildListContent(context,
              leading: Icon(Icons.list),
              text: "我的订单",
              routeName: XHOrderScreen.routeName),
          // 订单类型
          _orderType(context),
          //
          _buildListContent(context,
              leading: Icon(Icons.remove_circle_outline),
              text: "收货地址管理",
              routeName: XHAddressScreen.routeName),
          Divider(),
          //
          _buildListContent(context,
              leading: Icon(Icons.lock), text: "密码管理", routeName: "密码管理"),
          Divider(),
          SizedBox(
            height: 15.px,
          ),
          loginout()
        ],
      ),
    );
  }

  //头像区域
  Widget _topHeader(BuildContext context) {
    return Container(
      height: 180.px,
      decoration: BoxDecoration(
        color: Colors.blue[200],
      ),
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 15.px, bottom: 5.px),
          height: 120.px,
          width: 120.px,
          // color: Colors.green,
          child: CircleAvatar(
            child: Image.network(
              "https://cdn.jsdelivr.net/gh/flutterchina/website@1.0/images/flutter-mark-square-100.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
        Text(
          "今天天气好",
          style: Theme.of(context).textTheme.display3,
        )
      ]),
    );
  }

  //我的订单顶部
  Widget _buildListContent(BuildContext context,
      {Icon leading, String text, String routeName}) {
    return Container(
        margin: EdgeInsets.only(top: 10.px),
        child: ListTile(
          leading: leading,
          title: Text(
            text,
            style: Theme.of(context).textTheme.display2,
          ),
          trailing: Icon(Icons.arrow_right),
          onTap: () {
            // 页面跳转
            print(routeName);
            Navigator.of(context).pushNamed(routeName);
          },
        ));
  }

  Widget _orderType(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.px),
      // margin: EdgeInsets.all(3.px),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[100])
          // boxShadow: [
          // BoxShadow(
          //   color: Colors.grey[100],
          //   blurRadius: 2.0,
          // ),
          // ]
          ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildOrderContent(context,
              icon: Icon(Icons.money), text: "待付款", currentValue: 0),
          buildOrderContent(context,
              icon: Icon(Icons.schedule), text: "待发货", currentValue: 1),
          buildOrderContent(context,
              icon: Icon(Icons.directions_car), text: "待收货", currentValue: 2),
          buildOrderContent(context,
              icon: Icon(Icons.restore), text: "待退款", currentValue: 3)
        ],
      ),
    );
  }

  Widget buildOrderContent(BuildContext context,
      {Widget icon, String text, int currentValue}) {
    return InkWell(
      child: Container(
          height: 50.px,
          child: Column(
            children: [
              icon,
              Text(text, style: Theme.of(context).textTheme.display1)
            ],
          )),
      onTap: () {
        // 路由的跳转
        // Navigator.of(context).pushNamed(
        //   routeName,
        // );
        // 使用 构建页面的方式 进行参数的传递
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => XHOrderScreen(
                      currentIndex: currentValue,
                    )));
      },
    );
  }

  Widget loginout() {
    return Container(
      margin: EdgeInsets.only(left: 30.px, right: 30.px),
      child: RaisedButton(
        color: Colors.blue,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Text(
          "退出登录",
          style: TextStyle(fontSize: 20.px, color: Colors.white),
        ),
        onPressed: () {},
      ),
    );
  }
}
