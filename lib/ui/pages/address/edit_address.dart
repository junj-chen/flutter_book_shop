import 'package:city_pickers/city_pickers.dart';
import 'package:city_pickers/modal/result.dart';
import 'package:flutter/material.dart';
import 'package:xinhuashop/core/model/address_model.dart';

import 'package:xinhuashop/core/extension/int_extension.dart';

class XHEditAddressScreen extends StatefulWidget {
  static final String routeName = "/editAddress";

  @override
  _XHEditAddressScreenState createState() => _XHEditAddressScreenState();
}

class _XHEditAddressScreenState extends State<XHEditAddressScreen> {
  // 变量
  String province; // 省
  String city; // 市
  String area; // 县

  @override
  void initState() {
    super.initState();
    province = '';
    city = '';
    area = '1';
  }

  // 控制器
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  // 添加数据的按钮
  void addAddress() {
    print("addAddress");
    print("province: $province -- $city ----$area");

    print("phoneController: ${phoneController.text}");
  }

  // 2. 删除地址的方法
  void deleteAddress() {
    print("deleteAddress");
  }

  @override
  Widget build(BuildContext context) {
    // 1. 获取传递的参数
    final _address =
        ModalRoute.of(context).settings.arguments as XHAddressModel;

    nameController.text = _address.receiver;
    phoneController.text = _address.telephone;
    detailController.text = _address.detailAddress;

    // 切分字符串
    List<String> provinceAndCity = _address.provinceAndCity.split(" ");
    // print(provinceAndCity);

    // province = provinceAndCity[0];
    // city = provinceAndCity[1];
    // area = provinceAndCity[2];

    // print(province);

    return Scaffold(
      appBar: AppBar(
          // 标题
          title: Text("修改地址"),
          actions: [
            // 增加 按钮功能
            _builddeleteButton(context),
          ]),
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
          // buildPosition(province, city, area),
          SizedBox(height: 30.px),
          _buildAddButton()
        ],
      ),
    );
  }

  // 1. 删除地址的按钮
  Widget _builddeleteButton(BuildContext context) {
    return InkWell(
      child: Row(
        children: [Icon(Icons.delete), Text("删除地址")],
      ),
      onTap: () {
        // 发送网络请求删除地址
        deleteAddress();
      },
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
          addAddress();
        },
      ),
    );
  }
}

// 2.  构建地区
// 构建为 一个 stateful wedget
class buildPosition extends StatefulWidget {
  final String province;
  final String city;
  final String area;

  buildPosition(this.province, this.city, this.area);

  @override
  _buildPositionState createState() => _buildPositionState();
}

class _buildPositionState extends State<buildPosition> {
  String provinces;
  String citys;
  String areas;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provinces = widget.province;
    citys = widget.city;
    areas = widget.area;
  }

  @override
  Widget build(BuildContext context) {
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
            onTap: () {
              CityPickers.showCityPicker(context: context, height: 300.px)
                  .then((result) {
                setState(() {
                  this.provinces = result.provinceName;
                  this.citys = result.cityName;
                  this.areas = result.areaName;
                });
              });
            },
            child: Container(
              child: Text(provinces == ''
                  ? '选择地区'
                  : '${this.provinces},${this.citys},${this.areas}'),
            ),
          )
        ],
      ),
    );
  }
}
