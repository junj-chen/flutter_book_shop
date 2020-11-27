import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xinhuashop/core/model/cart_model.dart';
import 'package:xinhuashop/core/services/json_parse.dart';

import 'package:xinhuashop/core/extension/int_extension.dart';
import 'package:xinhuashop/core/view_model/cart_view_model.dart';

class XHCartScreen extends StatefulWidget {
  static final String routeName = "/carts";
  @override
  _XHCartScreenState createState() => _XHCartScreenState();
}

class _XHCartScreenState extends State<XHCartScreen> {
  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text("购物车页面")),
  //     body: FutureBuilder(
  //       // 发送网络请求
  //       future: JsonParse.getCartData("cart.json"),
  //       builder: (context, snapshot) {
  //         // 如果存在数据
  //         if (snapshot.hasData) {
  //           //
  //           print("snapshot.data.length: ${snapshot.data.length}");
  //           // print(snapshot.data.runtimeType);
  //           // 没有数据
  //           if (snapshot.data.length == 0) {
  //             return Center(
  //               child: Text("购物车空空如也..."),
  //             );
  //           } else {
  //             // 绘制 购物车界面
  //             return _buildCartContent(snapshot.data);
  //           }
  //         } else {
  //           // 数据加载
  //           return Container(
  //             alignment: Alignment.center,
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }

  // 使用 provider 保存购物车的数据
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("购物车页面"),
          centerTitle: true,
          // leading: Icon(null),
          automaticallyImplyLeading: false,
        ),
        body: Consumer<XHCartViewModel>(
          builder: (context, xhCartVm, child) {
            // 获取数据
            List<XHCartModel> cart = xhCartVm.cartList;

            if (cart.length == 0) {
              return Center(
                child: Text("购物车空空如也..."),
              );
            } else {
              return _buildCartContent(cart, xhCartVm);
            }
          },
        ));
  }

  // 购物车界面内容
  Widget _buildCartContent(List<XHCartModel> cart, XHCartViewModel xhCartVm) {
    // 计算总的价格
    double sum = 0.0;
    cart.forEach((element) {
      if (element.check) {
        print("sum ---- ");
        sum += double.parse(element.partMoney);
      }
    });
    // print("sum: $sum");
    return Stack(
      children: [
        Positioned(
          child: Container(
            padding: EdgeInsets.only(bottom: 50),
            child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  // 记录每一个 数量值
                  int num = cart[index].qty;
                  // bool checked = true;
                  return Container(
                    height: 100.px,
                    padding: EdgeInsets.only(
                        left: 5.px, right: 10.px, top: 10.px, bottom: 5.px),
                    child: Row(
                      children: [
                        // 1. 构建 checkBox
                        Checkbox(
                            value: cart[index].check,
                            activeColor: Colors.pinkAccent,
                            onChanged: (bool val) {
                              // 修改状态
                              xhCartVm.changeCheckedBoxStatus(index, val);
                            }),
                        // 2. 构建图片
                        _buildImage(cart[index].imageUrl),

                        // 3. 中间内容显示
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10.px),
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 构建中间书籍名称
                                _buildMiddleContentName(cart[index].bookDetail),
                                // 构建中间 的 + - 框 内容
                                _buildMiddleContentAddorDel(
                                    index, xhCartVm, num)
                              ],
                            ),
                          ),
                        ),

                        // 4. 删除及价格显示
                        _buildShowPriAndDelicon(
                            cart[index].partMoney, index, xhCartVm)
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Color(0xffe8e7e8)))),
                  );
                }),
          ),
        ),
        _buildBottomContent(sum, xhCartVm)
      ],
    );
  }

  // 1.  购物车 页面的图片板块
  Widget _buildImage(String url) {
    return Expanded(
      child: Container(
        // color: Colors.red,
        padding: EdgeInsets.symmetric(vertical: 2.px),
        child: Image.network(url, errorBuilder: (context, error, stackTrace) {
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
        }),
      ),
    );
  }

  // 2.1 构建 中间内容名字
  Widget _buildMiddleContentName(String bookName) {
    return Container(
      child: Text(
        bookName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // 2.2 构建中间内容的 + - 框
  Widget _buildMiddleContentAddorDel(
      int index, XHCartViewModel xhCartVm, int num) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 25.px,
      width: 100.px,
      child: Row(
        children: [
          // 1.  - 号部分内容
          InkWell(
            onTap: () {
              if (num == 1) {
                print("该宝贝不能减少了哟");
                // Toast.show("该宝贝不能减少了哟", context,
                //     backgroundRadius: 5);
              } else {
                // 减少数量
                print("发送请求减少数量");
                xhCartVm.deleteCartItemCount(index);
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: 20.px,
              child: Text(
                "-",
                style: TextStyle(fontSize: 15),
              ),
              decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Color(0xffe8e7e8)))),
            ),
          ),
          // 2. 显示数量的内容
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Text("$num"),
            decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Color(0xffeeedee)))),
          )),
          // 3. + 加号部分的内容
          InkWell(
            onTap: () {
              // 增加 数量
              print("增加数量");
              xhCartVm.addCartItemCount(index);
            },
            child: Container(
              alignment: Alignment.center,
              width: 20.px,
              child: Text(
                "+",
                style: TextStyle(fontSize: 15),
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(border: Border.all(color: Color(0xffeeedee))),
    );
  }

  // 3. 中间 删除及 价格显示部分
  Widget _buildShowPriAndDelicon(
      String partMoney, int index, XHCartViewModel xhCartVm) {
    return Container(
      height: 100,
      padding: EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(
              Icons.delete,
              size: 17,
              color: Colors.grey,
            ),
            onPressed: () {
              print("删除该商品");
              xhCartVm.removeCartItem(index);
            },
          ),
          Container(
            margin: EdgeInsets.only(right: 10, top: 5),
            child: Text(
              "￥${partMoney}",
              style: TextStyle(color: Color(0xffdf1581)),
            ),
          ),
        ],
      ),
    );
  }

  // 底部结算内容界面
  Widget _buildBottomContent(double sum, XHCartViewModel xhCartVm) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 5, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: xhCartVm.selectAllcheck,
              onChanged: (val) {
                print("全选点击: $val");
                // 全选的按钮 控制, 全部选择或者全部取消
                xhCartVm.selectedAll(val);
              },
              activeColor: Color(0xffdf1581),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  "合计:    ￥${sum.toStringAsFixed(2)}",
                  style: TextStyle(color: Color(0xffdf1581)),
                ),
                Text(
                  "免运费",
                  style: TextStyle(fontSize: 16.px, color: Colors.grey),
                )
              ],
            )),
            InkWell(
              onTap: () {
                print("结算按钮-------");
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.only(left: 15, right: 15),
                alignment: Alignment.center,
                height: 30.px,
                child: Text(
                  "结算",
                  style: TextStyle(color: Colors.white, fontSize: 16.px),
                ),
                decoration: BoxDecoration(
                  color: Color(0xffdf1581),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            )
          ],
        ),
        height: 50.px,
      ),
    );
  }
}
