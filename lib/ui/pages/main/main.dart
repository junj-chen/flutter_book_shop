import 'package:flutter/material.dart';
import 'package:xinhuashop/ui/pages/main/initialize_items.dart';

class XHMainScreen extends StatefulWidget {
  static final String routeName = "/main";

  @override
  _XHMainScreenState createState() => _XHMainScreenState();
}

class _XHMainScreenState extends State<XHMainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 设置 页面
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),

      // 底部导航
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: bottomitems,
        // 固定文字的大小
        selectedFontSize: 14,
        unselectedFontSize: 14,

        // 显示问题时，需要配置
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          // 进行页面的刷新
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
