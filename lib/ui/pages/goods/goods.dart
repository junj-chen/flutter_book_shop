import 'package:flutter/material.dart';
import 'package:xinhuashop/core/model/book_detail_model.dart';
import 'package:xinhuashop/core/services/json_parse.dart';
import 'package:xinhuashop/core/extension/int_extension.dart';

class XHGoodsScreen extends StatefulWidget {
  static final String routeName = "/goods";

  @override
  _XHGoodsScreenState createState() => _XHGoodsScreenState();
}

class _XHGoodsScreenState extends State<XHGoodsScreen> {
  XhBookDetailModel _goods;
  XhBookDetailModel _Recegoods;

  @override
  void initState() {
    // TODO: implement initState
    // 接收 参数， 发送请求， 获取详情数据
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _goods = ModalRoute.of(context).settings.arguments as XhBookDetailModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(_goods.commodityName),
      ),
      // 使用 FutureBuilder 来构建异步请求
      body: FutureBuilder<XhBookDetailModel>(
        future: JsonParse.getBookContentData("book_detail.json"),
        builder: (context, snapshot) {
          // 有数据返回 时的操作
          if (snapshot.hasData) {
            final result = snapshot.data;
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10.px),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[100],
              child: Column(
                children: [
                  // 1. 图片展示
                  _buildImage(result),

                  SizedBox(height: 10.px),

                  // 3. 书本题目展示
                  _buildBookName(result),

                  SizedBox(height: 6.px),

                  // // 2. 价格   --  库存展示
                  _buildPriceAndStore(result),

                  SizedBox(height: 10.px),
                  // // 4. 书籍简介
                  _buildShortContent(result),
                  // Container(
                  //   height: 10.px,
                  // ),
                ],
              ),
            );
          } else {
            return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: _buildShoppingBus(),
    );
  }

  // 1. 图片显示
  Widget _buildImage(XhBookDetailModel goods) {
    return Container(
      // width: MediaQuery.of(context).size.width - 30.px,
      // color: Colors.grey[200],
      padding: EdgeInsets.all(10.px),
      height: 200.px,
      width: MediaQuery.of(context).size.width - 50.px,
      // color: Colors.red,
      child: Image.network(
        goods.imageUrl,
        fit: BoxFit.fitHeight,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200.px,
            width: 140.px,
            // color: Colors.grey,
            child: Column(
              children: [
                Icon(
                  Icons.photo_camera,
                  color: Colors.grey[300],
                  size: 50.px,
                ),
                Text(
                  "暂无图片",
                  style: TextStyle(color: Colors.grey[300]),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  // 3. 显示书籍名字
  Widget _buildBookName(XhBookDetailModel goods) {
    return Card(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.px),
            color: Colors.white,
          ),
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(2.px),
          child: Text(
            goods.commodityName,
            style: Theme.of(context)
                .textTheme
                .display2
                .copyWith(color: Colors.grey[800]),
          )),
    );
  }

  // 2. 显示价格 与 库存
  Widget _buildPriceAndStore(XhBookDetailModel goods) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.px),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.px),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("￥ ${goods.realPrice}",
                style: Theme.of(context)
                    .textTheme
                    .display2
                    .copyWith(color: Colors.red)),

            SizedBox(width: 10.px),

            // 判断 卖价 与 售价是否相同，如果相同就显示一个价格
            goods.realPrice.toString().split(".") ==
                    goods.price.toString().split(".")
                ? (Text(
                    "￥ ${goods.price}",
                    style: TextStyle(
                        color: Colors.grey[500],
                        decoration: TextDecoration.lineThrough),
                  ))
                : Text(""),

            SizedBox(width: 20.px),

            // 显示 库存数量
            Text(
              "库存：${goods.stock}",
              style: TextStyle(
                color: Colors.grey[500],
              ),
            )
          ],
        ),
      ),
    );
  }

  // 3. 显示内容 简介
  Widget _buildShortContent(XhBookDetailModel goods) {
    return Card(
      child: Column(
        children: [
          _buildLineConmtent("作者", goods.author),
          // SizedBox(height: 10.px),
          _buildLineConmtent("出版社", goods.publisher),

          _buildLineSumary("简介", goods),
        ],
      ),
    );
  }

  // 构建出版社 与 作者的 widget
  Widget _buildLineConmtent(String name, String content) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.px),
      padding: EdgeInsets.all(8.px),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200]))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "$name：",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10.px),
          Text(content),
        ],
      ),
    );
  }

  Widget _buildLineSumary(String name, XhBookDetailModel goods) {
    // String newStr = RegExp(_regExp).stringMatch(goods.summary);
    // print("newStr: ****************************************$newStr");

    String newStr =
        "本文讲述的是主人公穆远从少年时期到成年的几段情感故事，有少年的青涩也有成年男人的欲望，通过他与生命遇 到的女生的故事为读者揭示出人生不同时期爱情的曼妙与苦涩。本文独特的男性视角让人对青春时期的情感有着不同的感悟。";

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.px),
      padding: EdgeInsets.all(8.px),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200]))),
      child: Text.rich(TextSpan(
        text: "$name: ",
        style: TextStyle(fontWeight: FontWeight.bold),
        children: [
          WidgetSpan(
              child: Text(
            newStr,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ))
        ],
      )),
    );
  }

  // 底部 购物车展示功能
  Widget _buildShoppingBus() {
    return Container(
      height: 44.px,
      // color: Colors.red,
      // width: double.infinity,
      padding: EdgeInsets.all(3.px),
      margin: EdgeInsets.symmetric(horizontal: 5.px),
      child: Row(
        children: [_buildShoppingBusIcon(), _buildShoppingBusAddShop()],
      ),
    );
  }

  // 底部 购物车图标
  Widget _buildShoppingBusIcon() {
    return InkWell(
      onTap: () {
        print("开发中...");
        // 跳转到购物车页面
      },
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        width: 50.px,
        child: Icon(
          Icons.shopping_cart,
          color: Color(0xffdd2081),
        ),
      ),
    );
  }

  // 底部购物车 加入购物车按钮
  Widget _buildShoppingBusAddShop() {
    return Expanded(
      child: InkWell(
        onTap: () {
          // 加入购物车按钮
          print("加入购物车");
        },
        child: Container(
          // width: 20.px,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(8.px)),
          alignment: Alignment.center,
          child: Text(
            "加入购物车",
            style: Theme.of(context)
                .textTheme
                .display2
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
