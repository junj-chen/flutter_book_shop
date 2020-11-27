import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xinhuashop/core/router/router.dart';
import 'package:xinhuashop/core/view_model/cart_view_model.dart';
import 'package:xinhuashop/ui/shared/app_theme.dart';
import 'package:xinhuashop/ui/shared/size_fit.dart';

void main() {
  runApp(
      // 添加 provider
      ChangeNotifierProvider(
    create: (ctx) => XHCartViewModel("cart.json"),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 屏幕适配初始化
    XHSizeFit.initialize();

    return MaterialApp(
      title: 'xinhua Shop',
      // 1. 主题配置
      theme: XHAppTheme.norTheme,

      // 2. 路由配置
      initialRoute: XHRouter.initialRoute,
      routes: XHRouter.routes,
      onGenerateRoute: XHRouter.generateRoute,
      onUnknownRoute: XHRouter.unknownRoute,
    );
  }
}
