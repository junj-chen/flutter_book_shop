import 'package:flutter/material.dart';
import 'package:xinhuashop/core/model/address_model.dart';
import 'package:xinhuashop/core/services/json_parse.dart';
import 'package:xinhuashop/core/extension/int_extension.dart';

import 'add_address.dart';
import 'edit_address.dart';

class XHAddressScreen extends StatefulWidget {
  static final String routeName = "/address";

  @override
  _XHAddressScreenState createState() => _XHAddressScreenState();
}

class _XHAddressScreenState extends State<XHAddressScreen> {
  List<XHAddressModel> _address = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 用于获取数据
    JsonParse.getAddressData().then((value) {
      setState(() {
        _address = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // 标题
            title: Text("收货地址"),
            actions: [
              // 增加 按钮功能
              _buildAddButton(context),
            ]),
        body: ListView.separated(
            itemCount: _address.length,
            itemBuilder: (context, index) {
              return _buildContent(context, _address[index]);
            },
            separatorBuilder: (ctx, index) {
              return Divider();
            }));
  }

  // 增加收货地址
  Widget _buildAddButton(BuildContext context) {
    return InkWell(
      child: Row(
        children: [Icon(Icons.add_box), Text("新增地址")],
      ),
      onTap: () {
        // 路由跳转
        Navigator.of(context).pushNamed(XHAddAddressScreen.routeName);
      },
    );
  }

  // 布局内容
  Widget _buildContent(BuildContext context, XHAddressModel address) {
    return ListTile(
      title: _buildContentTile(context, address),
      subtitle: Text(address.showAddress),
      trailing: InkWell(
        child: Icon(Icons.edit),
        onTap: () {
          // 路由跳转, 跳转到修改 地址页面
          Navigator.of(context)
              .pushNamed(XHEditAddressScreen.routeName, arguments: address);
        },
      ),
    );
  }

  // 内容的 title
  Widget _buildContentTile(BuildContext context, XHAddressModel address) {
    return Row(
      children: [
        Text(address.receiver),
        SizedBox(width: 5.px),
        Text(address.telephone),
        SizedBox(width: 5.px),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.px),
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(5.px)),
          child: Text(
            "默认",
            style: Theme.of(context)
                .textTheme
                .display1
                .copyWith(color: Colors.white),
          ),
        )
      ],
    );
  }
}
