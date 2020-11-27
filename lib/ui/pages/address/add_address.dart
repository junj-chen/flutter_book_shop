import 'dart:io';

import 'package:city_pickers/city_pickers.dart';
import 'package:city_pickers/modal/result.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xinhuashop/core/extension/int_extension.dart';
import 'package:xinhuashop/ui/widgets/loading.dart';

class XHAddAddressScreen extends StatefulWidget {
  static final String routeName = "/addAddress";

  @override
  _XHAddAddressScreenState createState() => _XHAddAddressScreenState();
}

class _XHAddAddressScreenState extends State<XHAddAddressScreen> {
  // 变量
  String province = ''; // 省
  String city = ''; // 市
  String area = ''; // 县

  // 控制器
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  // 点击 add按钮，保存地址
  void add() async {
    // 1. 格式校验
    // if (nameController.text == '') {

    //   Fluttertoast.showToast(
    //       msg: "请输入姓名",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       // timeInSecForIosWeb: 1,
    //       textColor: Colors.black);
    //   return;
    // }

    // if (phoneController.text == '') {
    //   Fluttertoast.showToast(
    //       msg: "请输入手机号码",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       // timeInSecForIosWeb: 1,
    //       textColor: Colors.black);
    //   return;
    // }
    // if (detailController.text == '') {
    //   Fluttertoast.showToast(
    //       msg: "请输入详细地址",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       // timeInSecForIosWeb: 1,
    //       textColor: Colors.black);
    //   return;
    // }
    // if (province == '') {
    //   Fluttertoast.showToast(
    //       msg: "请选择地区",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       // timeInSecForIosWeb: 1,
    //       textColor: Colors.black);
    //   return;
    // }

    // 2. 提交框
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadingDialog(
            //调用对话框
            text: '提交中...',
          );
        });

    // 3. 提交数据
    sleep(Duration(seconds: 5));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新增收货地址"),
      ),
      body: ListView(
        children: [
          _buildcontent(context,
              leading: "收货人", textInfo: "输入姓名", controller: nameController),
          _buildcontent(context,
              leading: "手机号码", textInfo: "输入手机号码", controller: phoneController),
          _buildcontent(context,
              leading: "详细地址",
              textInfo: "街道、楼牌号等",
              controller: detailController),
          _buildPositon(context),
          SizedBox(height: 30.px),
          _buildAddButton()
        ],
      ),
    );
  }

  // 1.  构建 内容
  Widget _buildcontent(BuildContext context,
      {String leading, String textInfo, TextEditingController controller}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[100]))),
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(leading),
          ),
          Expanded(
            flex: 4,
            child: TextField(
                controller: controller,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                    hintText: textInfo, border: InputBorder.none)),
          )
        ],
      ),
    );
  }

  // 2.  构建地区
  Widget _buildPositon(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 55.0,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[100]))),
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('所在地区'),
          InkWell(
            onTap: () async {
              Result result = await CityPickers.showCityPicker(
                  context: context, height: 300.px);
              // print(result);
              this.setState(() {
                province = result.provinceName;
                city = result.cityName;
                area = result.areaName;
              });
            },
            child: Container(
              child: Text(province == ''
                  ? '选择地区'
                  : '${this.province},${this.city},${this.area}'),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.px),
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.px)),
        color: Theme.of(context).primaryColor,
        child: Text(
          "保存地址",
          style: Theme.of(context)
              .textTheme
              .display2
              .copyWith(color: Colors.white),
        ),
        onPressed: () {
          // 点击 保存地址

          add();
        },
      ),
    );
  }
}
