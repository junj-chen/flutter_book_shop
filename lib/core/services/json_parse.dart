// json文件解析

import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:xinhuashop/core/model/address_model.dart';
import 'package:xinhuashop/core/model/book_detail_model.dart';
import 'package:xinhuashop/core/model/book_first_category.dart';
import 'package:xinhuashop/core/model/cart_model.dart';

class JsonParse {
  // 函数1
  static Future<List<XHAddressModel>> getAddressData() async {
    // 1. 读取json 数据,设置异步加载
    final jsonString = await rootBundle.loadString("assets/json/address.json");

    // 2. 将jsonString 转化为 map/List
    final result = json.decode(jsonString);

    print(result);

    // 3. 将Map 中的 内容转化为对象
    final resultList = result;
    List<XHAddressModel> address = [];
    for (var json in resultList) {
      address.add(XHAddressModel.fromJson(json)); // 添加对象
    }

    // 4. 返回对象值
    return address;
  }

  // 函数2 返回 一级分类的类别
  static Future<List<XHBookFCategoryModel>> getBookFirstCategoryData() async {
    // 1. 异步读取数据
    final jsonString =
        await rootBundle.loadString("assets/json/book_category.json");

    // 2. 字符串转化为 map
    final result = json.decode(jsonString);
    // print(result);

    // 3. 转化为对象
    final resultList = result["result"]["categories"];
    List<XHBookFCategoryModel> categories = [];

    for (var json in resultList) {
      categories.add(XHBookFCategoryModel.fromJson(json));
    }

    return categories;
  }

  // 函数3
  static Future<List<XHBookFCategoryModel>> getBookSecondCategoryData(
      String cateName) async {
    // 1. 异步读取数据
    final jsonString = await rootBundle.loadString("assets/json/" + cateName);

    // 2. 字符串转化为 map
    final result = json.decode(jsonString);
    // print(result);

    // 3. 转化为对象
    final resultList = result["result"]["categories"];
    List<XHBookFCategoryModel> categories = [];

    for (var json in resultList) {
      categories.add(XHBookFCategoryModel.fromJson(json));
    }
    return categories;
  }

  // 函数4 解析book书籍详情页面
  static Future<List<XhBookDetailModel>> getBookDetailData(
      String cateName) async {
    // 1. 异步读取数据
    final jsonString = await rootBundle.loadString("assets/json/" + cateName);

    // 2. 字符串转化为 map
    final result = json.decode(jsonString);
    // print(result);

    // 3. 转化为对象
    final resultList = result["result"]["data"];
    List<XhBookDetailModel> categories = [];

    for (var json in resultList) {
      categories.add(XhBookDetailModel.fromJson(json));
    }
    return categories;
  }

  // 函数5 解析book书籍内容详情
  static Future<XhBookDetailModel> getBookContentData(String cateName) async {
    // 1. 异步读取数据
    final jsonString = await rootBundle.loadString("assets/json/" + cateName);

    // 2. 字符串转化为 map
    final result = json.decode(jsonString);

    // 3. 转化为对象
    final resultContent = result["result"]["data"];

    return XhBookDetailModel.fromJson(resultContent);
  }

  // 函数5 解析book书籍内容详情
  static Future<List<XHCartModel>> getCartData(String cateName) async {
    // 1. 异步读取数据
    final jsonString = await rootBundle.loadString("assets/json/" + cateName);

    // 2. 字符串转化为 map
    final result = json.decode(jsonString);
    // print("result : ${result.length}");
    // print(result.length);

    // 3. 转化为对象
    List<XHCartModel> resultList = [];
    for (var json in result) {
      resultList.add(XHCartModel.fromJson(json));
    }
    // print("resultList.length: ${resultList.length}");
    return resultList;
  }
}
