// To parse this JSON data, do
//
//     final xhBookFCategoryModel = xhBookFCategoryModelFromJson(jsonString);

import 'dart:convert';

XHBookFCategoryModel xhBookFCategoryModelFromJson(String str) =>
    XHBookFCategoryModel.fromJson(json.decode(str));

String xhBookFCategoryModelToJson(XHBookFCategoryModel data) =>
    json.encode(data.toJson());

class XHBookFCategoryModel {
  XHBookFCategoryModel({
    this.categoryId,
    this.categoryName,
    this.amount,
  });

  String categoryId;
  String categoryName;
  int amount;

  factory XHBookFCategoryModel.fromJson(Map<String, dynamic> json) =>
      XHBookFCategoryModel(
        categoryId: json["CategoryId"],
        categoryName: json["CategoryName"],
        amount: json["Amount"],
      );

  Map<String, dynamic> toJson() => {
        "CategoryId": categoryId,
        "CategoryName": categoryName,
        "Amount": amount,
      };
}
