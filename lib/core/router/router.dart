import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xinhuashop/ui/pages/address/add_address.dart';
import 'package:xinhuashop/ui/pages/address/address.dart';
import 'package:xinhuashop/ui/pages/address/edit_address.dart';
import 'package:xinhuashop/ui/pages/cart/cart.dart';
import 'package:xinhuashop/ui/pages/category/category_detail.dart';
import 'package:xinhuashop/ui/pages/error/error.dart';
import 'package:xinhuashop/ui/pages/goods/goods.dart';
import 'package:xinhuashop/ui/pages/login/login.dart';
import 'package:xinhuashop/ui/pages/main/main.dart';
import 'package:xinhuashop/ui/pages/order/order.dart';

class XHRouter {
  // 1. 开始的路由页面
  static final String initialRoute = XHLoginScreen.routeName;

  // 2. 命名路由的映射
  static final Map<String, WidgetBuilder> routes = {
    // m命名路由映射
    XHLoginScreen.routeName: (ctx) => XHLoginScreen(),
    XHMainScreen.routeName: (ctx) => XHMainScreen(),
    XHAddressScreen.routeName: (ctx) => XHAddressScreen(),
    XHAddAddressScreen.routeName: (ctx) => XHAddAddressScreen(),
    XHEditAddressScreen.routeName: (ctx) => XHEditAddressScreen(),
    XHCategoryDetailScreen.routeName: (ctx) => XHCategoryDetailScreen(),
    XHGoodsScreen.routeName: (ctx) => XHGoodsScreen(),
    XHCartScreen.routeName: (ctx) => XHCartScreen(),
    XHOrderScreen.routeName: (ctx) => XHOrderScreen(),
  };

  // 3. 未进行路由映射表的页面
  static final RouteFactory generateRoute = (settings) {
    return null;
  };

  // 4. 错误页面的配置
  static final RouteFactory unknownRoute = (settings) {
    return MaterialPageRoute(builder: (ctx) {
      return XHErrorScreen();
    });
  };
}
