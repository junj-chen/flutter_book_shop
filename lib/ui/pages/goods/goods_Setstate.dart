import 'package:flutter/material.dart';
import 'package:xinhuashop/core/model/book_detail_model.dart';
import 'package:xinhuashop/core/services/json_parse.dart';
import 'package:xinhuashop/core/extension/int_extension.dart';

class XHGoodsStaScreen extends StatefulWidget {
  static final String routeName = "/goods";

  @override
  _XHGoodsStaScreenState createState() => _XHGoodsStaScreenState();
}

class _XHGoodsStaScreenState extends State<XHGoodsStaScreen> {
  XhBookDetailModel _goods;
  XhBookDetailModel _Recegoods;

  @override
  Widget build(BuildContext context) {
    // 接收 参数， 发送请求， 获取详情数据
    final bookDetail =
        ModalRoute.of(context).settings.arguments as XhBookDetailModel;

    initState() {
      setState(() {
        _Recegoods = bookDetail;
        JsonParse.getBookContentData("book_detail.json").then((value) {
          _goods = value;
          print(_goods.imageUrl);
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(bookDetail.commodityName),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.px),
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[200],
        child: Column(
          children: [
            // 1. 图片展示
            _buildImage(),

            SizedBox(height: 10.px),

            // 3. 书本题目展示
            _buildBookName(),

            SizedBox(height: 10.px),

            // 2. 价格   --  库存展示
            _buildPriceAndStore(),

            SizedBox(height: 10.px),
            // 4. 书籍简介
            _buildShortContent(),
            Container(
              height: 10.px,
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildShoppingBus(),
    );
  }

  // 1. 图片显示
  Widget _buildImage() {
    return Container(
      // width: MediaQuery.of(context).size.width - 30.px,
      // color: Colors.grey[200],
      padding: EdgeInsets.all(10.px),
      height: 200.px,
      width: MediaQuery.of(context).size.width - 50.px,
      // color: Colors.red,
      child: Image.network(
        _Recegoods.imageUrl,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  // 3. 显示书籍名字
  Widget _buildBookName() {
    return Card(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.px),
            color: Colors.white,
          ),
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(10.px),
          child: Text(
            _Recegoods.commodityName,
            style: Theme.of(context)
                .textTheme
                .display2
                .copyWith(color: Colors.grey[800]),
          )),
    );
  }

  // 2. 显示价格 与 库存
  Widget _buildPriceAndStore() {
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
            Text("￥ ${_Recegoods.realPrice}",
                style: Theme.of(context)
                    .textTheme
                    .display2
                    .copyWith(color: Colors.red)),

            SizedBox(width: 10.px),

            // 判断 卖价 与 售价是否相同，如果相同就显示一个价格
            _Recegoods.realPrice.toString().split(".") ==
                    _Recegoods.price.toString().split(".")
                ? (Text(
                    "￥ ${_Recegoods.price}",
                    style: TextStyle(
                        color: Colors.grey[500],
                        decoration: TextDecoration.lineThrough),
                  ))
                : Text(""),

            SizedBox(width: 20.px),

            // 显示 库存数量
            Text(
              "库存：${_Recegoods.stock}",
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
  Widget _buildShortContent() {
    return Expanded(
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Card(
          child: Column(
            children: [
              _buildLineConmtent(),
              _buildLineConmtent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLineConmtent() {
    return Row(
      children: [
        ListTile(
          leading: Text("作者："),
          title: Text(_goods.author),
        ),
        ListTile(
          leading: Text("出版社："),
          title: Text(_goods.publisher),
        ),
        Text("data"),
      ],
    );
  }

  // 底部 购物车展示功能
  Widget _buildShoppingBus() {
    return Container(
      height: 44.px,
      // color: Colors.red,
      width: double.infinity,
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
