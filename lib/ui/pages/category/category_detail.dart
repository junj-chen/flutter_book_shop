import 'package:flutter/material.dart';
import 'package:xinhuashop/core/model/book_detail_model.dart';
import 'package:xinhuashop/core/model/book_first_category.dart';
import 'package:xinhuashop/core/services/json_parse.dart';

import 'package:xinhuashop/core/extension/int_extension.dart';
import 'package:xinhuashop/ui/pages/goods/goods.dart';

class XHCategoryDetailScreen extends StatefulWidget {
  static final String routeName = "/categoryDetail";

  @override
  _XHCategoryDetailScreenState createState() => _XHCategoryDetailScreenState();
}

class _XHCategoryDetailScreenState extends State<XHCategoryDetailScreen> {
  List<XhBookDetailModel> _bookDetailList = [];

  // 搜索框的 controller
  final TextEditingController controller = TextEditingController();
  // 搜索框后面的删除按钮是否显示
  bool showClear = false;

  int default_index = 1;

  bool row_up = true;

  // 搜索函数
  void _onSearch(String text) {
    print("text : $text");
  }

  // 设置是否删除
  _onChange(String text) {
    print("change--");
    if (text.length > 0) {
      showClear = true;
    } else {
      showClear = false;
    }
  }

  // 根据类型进行筛选 数据
  void _selectByType(int type) {
    print("Type: $type");

    print("row_up: $row_up");

    print("text_content: ${controller.text}");

    // setState(() {
    //   _bookDetailList = [];
    // });
  }

  String _name = "second_ca.json";

  @override
  void initState() {
    JsonParse.getBookDetailData(_name).then((value) {
      setState(() {
        _bookDetailList = value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // 清除控制器
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. 接收路由传递的参数，发送网络请求
    final _bookFirCatory =
        ModalRoute.of(context).settings.arguments as XHBookFCategoryModel;

    // JsonParse.getBookDetailData("second_ca.json").then((value) {
    //   setState(() {
    //     _bookDetailList = value;
    //   });
    // });

    // setState(() {
    //   _name = "second_ca.json";
    // });

    return Scaffold(
      appBar: AppBar(
          title: Text(
            _bookFirCatory.categoryName,
            style: Theme.of(context).textTheme.display3,
          ),
          backgroundColor: Colors.grey[50],
          iconTheme: IconThemeData(color: Colors.black),
          // flexibleSpace: SafeArea(
          //   child: Text("重要Neolithic"),
          // ),
          bottom: PreferredSize(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    // 1. 第一部分为搜索框
                    _buildAppBarSearch(),
                    // 2. 第二部分为 筛选 选项
                    _buildSearchBarClassify()
                  ],
                ),
              ),

              // 大小
              // preferredSize: Size(MediaQuery.of(context).size.width, 40)
              preferredSize: Size.fromHeight(80.px)
              //
              )),
      body: Container(
        color: Colors.grey[100],
        margin: EdgeInsets.symmetric(horizontal: 10.px),
        child: GridView.builder(
            itemCount: _bookDetailList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.px,
                crossAxisSpacing: 5.px,
                childAspectRatio: 1.2),
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  // margin: EdgeInsets.all(2.px),
                  // padding: EdgeInsets.all(5.px),R

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.px)

                      // border: Border.all(color: Colors.grey[300])
                      ),
                  child: Column(
                    children: [
                      // 1. 图片部分
                      _buildImage(context, _bookDetailList[index]),

                      // 2. 标题
                      _buildBookName(context, _bookDetailList[index]),

                      // 3. 价格
                      _buildBookPrice(context, _bookDetailList[index])
                    ],
                  ),
                ),
                onTap: () {
                  // 2. 点击页面 将传输到具体的展示页面信息，路由的跳转
                  print(_bookDetailList[index].commodityName);
                  print(_bookDetailList[index].imageUrl);

                  // 跳转到商品的详细页面
                  Navigator.of(context).pushNamed(XHGoodsScreen.routeName,
                      arguments: _bookDetailList[index]);
                },
              );
            }),
      ),
    );
  }

  /*
  ** 顶部搜索框部分的 widget
  */

  // 1. 头部搜索框的实现
  Widget _buildAppBarSearch() {
    Color inputBoxBackgroundColor;
    inputBoxBackgroundColor = Colors.grey[100];

    return Container(
      margin:
          EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.px, right: 10.px),
      // alignment: Alignment(-1, 0),
      // padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: inputBoxBackgroundColor,
        borderRadius: BorderRadius.circular(20.px),
      ),
      // height: 20.px,
      child: Stack(
        alignment: Alignment.centerLeft,
        // 布局
        children: [
          Row(
            children: [
              // 1. 显示的搜索框
              Container(width: 30.px, child: Icon(Icons.search)),

              // 2. 输入框
              _buildSearchBarInput(),

              // 3.后面的删除按钮
              showClear ? _buildSearchBarDele() : Container()
            ],
          )
        ],
      ),
    );
  }

  // 1.1 搜索框中的输入框的 widget
  Widget _buildSearchBarInput() {
    return Expanded(
      flex: 1,
      child: Container(
        // width: 20.px,
        width: MediaQuery.of(context).size.width - 50.px,
        child: TextField(
          controller: controller,
          onChanged: (text) => _onChange(text),
          onSubmitted: (text) => _onSearch(text),
          autofocus: false,
          style: TextStyle(
              fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              border: InputBorder.none,
              // contentPadding: EdgeInsets.only(bottom: 12),
              hintText: "搜索书籍",
              hintStyle: TextStyle(
                fontSize: 15.0,
                color: Color(0xff999999),
              )),
        ),
      ),
    );
  }

  // 1.2 搜索框的删除图标显示
  Widget _buildSearchBarDele() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.px),
      child: InkWell(
        child: Icon(
          IconData(0xe689, fontFamily: 'AntdIcons'),
          // size: 24.0,
          color: Color(0xffacacac),
        ),
        onTap: () {
          controller.clear();
          _onChange(""); // 设置为 空
          setState(() {});
        },
      ),
    );
  }

  // 2 筛选栏的实现
  Widget _buildSearchBarClassify() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSearBarClassifyByNumber("默认", 1),
          _buildSearBarClassifyByNumber("销量", 2),
          _buildSearBarClassifyByPrice("价格", 3),
          _buildSearBarClassifyByNumber("库存", 4),
        ],
      ),
    );
  }

  // 2.1 默认 销量 库存的实现
  Widget _buildSearBarClassifyByNumber(String typyName, int index) {
    return Container(
      padding: EdgeInsets.all(5.px),
      child: InkWell(
        child: Text(
          typyName,
          style: TextStyle(
              color: default_index == index ? Colors.red : Colors.black),
        ),
        onTap: () {
          setState(() {
            default_index = index;
          });
          // 发送函数进行类型筛选
          _selectByType(index);
        },
      ),
    );
  }

  // 2.2 价格的实现
  Widget _buildSearBarClassifyByPrice(String typyName, int index) {
    return Container(
      width: 80.px,
      height: 30.px,
      padding: EdgeInsets.all(5.px),
      child: InkWell(
        child: Row(
          children: [
            Text(
              typyName,
              style: TextStyle(
                  color: default_index == index ? Colors.red : Colors.black),
            ),
            // 按钮显示, 未选中的情况下，显示的按钮 与 选中的情况下 显示的按钮
            default_index == index
                ? (row_up
                    ? Icon(Icons.arrow_drop_up,
                        color:
                            default_index == index ? Colors.red : Colors.black)
                    : Icon(Icons.arrow_drop_down,
                        color:
                            default_index == index ? Colors.red : Colors.black))
                : Icon(
                    IconData(0xe67c, fontFamily: 'arr'),
                    color: Colors.grey[400],
                    size: 15.px,
                  )
            // : Icon(Icons.unfold_more)
            // : Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: <Widget>[
            //       Container(
            //           child: Icon(
            //         Icons.arrow_drop_up,
            //         size: 21,
            //       )),
            //       Container(
            //           child: Icon(
            //         Icons.arrow_drop_down,
            //         size: 21,
            //       )),
            //     ],
            //   )
          ],
        ),
        onTap: () {
          setState(() {
            default_index = index;
            row_up = !row_up;
          });
          // 发送函数进行类型筛选
          _selectByType(index);
        },
      ),
    );
  }

  /*
  ** 3. 内容部分的 widget
  ** 
  */
  // 3.1 图片的显示
  Widget _buildImage(BuildContext context, XhBookDetailModel bookDetail) {
    // 设置为 可扩展的页面
    return Expanded(
      child: Container(
        // color: Colors.red,
        padding: EdgeInsets.symmetric(vertical: 2.px),
        child: Image.network(bookDetail.imageUrl,
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
        }),
      ),
    );
  }

  // 3.2 书名显示
  Widget _buildBookName(BuildContext context, XhBookDetailModel bookDetail) {
    return Container(
        // color: Colors.green,
        child: Text(
      bookDetail.commodityName,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    ));
  }

  // 3.3 价格显示
  Widget _buildBookPrice(BuildContext context, XhBookDetailModel bookDetail) {
    return Container(
        // color: Colors.orange,
        child: Row(
      mainAxisAlignment: bookDetail.realPrice.toString().split(".")[0] ==
              bookDetail.price.toString().split(".")[0]
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceAround,
      children: [
        Text("￥ ${bookDetail.realPrice}"),
        bookDetail.realPrice.toString().split(".")[0] ==
                bookDetail.price.toString().split(".")[0]
            ? Text("")
            : Text(
                "￥ ${bookDetail.price}",
                style: TextStyle(
                    color: Colors.grey[500],
                    decoration: TextDecoration.lineThrough),
              )
      ],
    ));
  }
}
