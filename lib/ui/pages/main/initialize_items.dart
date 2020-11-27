import 'package:flutter/material.dart';
import 'package:xinhuashop/ui/pages/cart/cart.dart';
import 'package:xinhuashop/ui/pages/category/category.dart';
import 'package:xinhuashop/ui/pages/home/home.dart';
import 'package:xinhuashop/ui/pages/profile/profile.dart';

// 页面显示的内容
final List<Widget> pages = [
  XHHomeScreen(),
  XHCategoryScreen(),
  XHCartScreen(),
  XHProfileScreen()
];

// 底部的导航
final List<BottomNavigationBarItem> bottomitems = [
  // 1.
  BottomNavigationBarItem(
      icon: Icon(Icons.home), activeIcon: Icon(Icons.home_filled), label: "首页"),

  BottomNavigationBarItem(
      icon: Icon(Icons.apps),
      activeIcon: Icon(Icons.apps_outlined),
      label: "分类"),
  BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      activeIcon: Icon(Icons.shopping_cart_outlined),
      label: "购物车"),
  BottomNavigationBarItem(
      icon: Icon(Icons.person),
      activeIcon: Icon(Icons.person_pin),
      label: "我的"),
];
