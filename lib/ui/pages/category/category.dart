import 'package:flutter/material.dart';
import 'package:xinhuashop/core/model/book_first_category.dart';
import 'package:xinhuashop/core/services/json_parse.dart';
import 'package:xinhuashop/core/extension/int_extension.dart';
import 'package:xinhuashop/ui/pages/category/category_detail.dart';

class XHCategoryScreen extends StatefulWidget {
  @override
  _XHCategoryScreenState createState() => _XHCategoryScreenState();
}

class _XHCategoryScreenState extends State<XHCategoryScreen> {
  List<XHBookFCategoryModel> _bookList = [];
  List<XHBookFCategoryModel> _bookFirstCategory = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 获取左边导航栏的内容
    JsonParse.getBookFirstCategoryData().then((value) {
      setState(() {
        _bookList = value;
      });
    });

    // 获取二级类别
    JsonParse.getBookSecondCategoryData("first_ca.json").then((value) {
      setState(() {
        _bookFirstCategory = value;
      });
    });
  }

  int _selectedIndex = 0; // 选择的分类索引

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("分类页面"),
          leading: Icon(null),
          centerTitle: true,
        ),
        body: Row(
          children: [
            // 左边列表显示
            _buildLeftContent(context),
            // 右边显示的内容
            _buildRightContent(context)
          ],
        ));
  }

  // 1. 左边的内容显示
  Widget _buildLeftContent(BuildContext context) {
    return Container(
      width: 150.px,
      color: Colors.grey[100],
      child: ListView.builder(
          itemCount: _bookList.length,
          itemBuilder: (context, index) {
            bool flag = false; // 用于颜色显示
            if (_selectedIndex == index) {
              flag = true;
            }
            return InkWell(
              child: Container(
                  alignment: Alignment.center,
                  height: 40.px,
                  // 设置Container的背景色
                  color: flag ? Colors.blue[50] : Colors.blue[100],
                  child: Text(_bookList[index].categoryName,
                      style: Theme.of(context).textTheme.display1.copyWith(
                          color: flag
                              ? Theme.of(context).primaryColor
                              : Colors.black))),
              onTap: () {
                // 点击类别
                setState(() {
                  // 1. 更新 index
                  _selectedIndex = index;
                  // 2. 获取二级分类的内容
                  print(_bookList[index].categoryName);
                  // 示例获取第二种类别数据, 发送网络请求
                  JsonParse.getBookSecondCategoryData("ffir_ca.json")
                      .then((value) {
                    _bookFirstCategory = value;
                  });
                });
              },
            );
          }),
    );
  }

  // 右边内容显示
  Widget _buildRightContent(BuildContext context) {
    return Expanded(
      child: Container(
        child: GridView.builder(
            // shrinkWrap: true,
            itemCount: _bookFirstCategory.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 0.px,
              crossAxisSpacing: 0.px,

              // childAspectRatio: 1.5,
            ),
            itemBuilder: (cont, inde) {
              return InkWell(
                child: Container(
                    height: 20.px,
                    width: 20.px,
                    margin: EdgeInsets.all(5.px),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.px)),
                    child: Text(_bookFirstCategory[inde].categoryName)),
                onTap: () {
                  // 页面的跳转， 具体的数据展示，通过路由跳转，具体数据展示页面
                  print(_bookFirstCategory[inde].categoryName);
                  Navigator.of(cont).pushNamed(XHCategoryDetailScreen.routeName,
                      arguments: _bookFirstCategory[inde]);
                },
              );
            }),
      ),
    );
  }
}
