// To parse this JSON data, do
//
//     final xhBookDetailModel = xhBookDetailModelFromJson(jsonString);

import 'dart:convert';

import 'dart:ffi';

XhBookDetailModel xhBookDetailModelFromJson(String str) =>
    XhBookDetailModel.fromJson(json.decode(str));

String xhBookDetailModelToJson(XhBookDetailModel data) =>
    json.encode(data.toJson());

class XhBookDetailModel {
  XhBookDetailModel({
    this.commodityId,
    this.isbn,
    this.commodityName,
    this.categoryId,
    this.price,
    this.publishDate,
    this.author,
    this.publisher,
    this.cover,
    this.imageUrl,
    this.summary,
    this.recommend,
    this.directory,
    this.authorBriefIntroduction,
    this.comment,
    this.wonderfulPage,
    this.shelf,
    this.stock,
    this.realPrice,
    this.minDiscount,
    this.discountActivated,
    this.clscode,
    this.yTurl,
  });

  String commodityId;
  String isbn;
  String commodityName;
  String categoryId;
  dynamic price;
  DateTime publishDate;
  String author;
  String publisher;
  String cover;
  // 构造请求图片的连接
  String imageUrl;
  dynamic summary;
  dynamic recommend;
  dynamic directory;
  dynamic authorBriefIntroduction;
  dynamic comment;
  dynamic wonderfulPage;
  int shelf;
  int stock;
  String realPrice;
  dynamic minDiscount;
  int discountActivated;
  dynamic clscode;
  dynamic yTurl;

  factory XhBookDetailModel.fromJson(Map<String, dynamic> json) =>
      XhBookDetailModel(
        commodityId: json["CommodityId"],
        isbn: json["Isbn"],
        commodityName: json["CommodityName"],
        categoryId: json["CategoryId"],
        price: json["Price"],
        publishDate: DateTime.parse(json["PublishDate"]),
        author: json["Author"],
        publisher: json["Publisher"],
        cover: json["Cover"],
        // 构造请求图片的地址
        imageUrl: "http://image.yuetaowang.cn/images/Thumbnail/" +
            json["Cover"] +
            "-150.jpg",
        summary: json["Summary"],
        recommend: json["Recommend"],
        directory: json["Directory"],
        authorBriefIntroduction: json["AuthorBriefIntroduction"],
        comment: json["Comment"],
        wonderfulPage: json["WonderfulPage"],
        shelf: json["Shelf"],
        stock: json["Stock"],
        realPrice: json["RealPrice"],
        minDiscount: json["min_discount"],
        discountActivated: json["discount_activated"],
        clscode: json["Clscode"],
        yTurl: json["YTurl"],
      );

  Map<String, dynamic> toJson() => {
        "CommodityId": commodityId,
        "Isbn": isbn,
        "CommodityName": commodityName,
        "CategoryId": categoryId,
        "Price": price,
        "PublishDate":
            "${publishDate.year.toString().padLeft(4, '0')}-${publishDate.month.toString().padLeft(2, '0')}-${publishDate.day.toString().padLeft(2, '0')}",
        "Author": author,
        "Publisher": publisher,
        "Cover": cover,
        "Summary": summary,
        "Recommend": recommend,
        "Directory": directory,
        "AuthorBriefIntroduction": authorBriefIntroduction,
        "Comment": comment,
        "WonderfulPage": wonderfulPage,
        "Shelf": shelf,
        "Stock": stock,
        "RealPrice": realPrice,
        "min_discount": minDiscount,
        "discount_activated": discountActivated,
        "Clscode": clscode,
        "YTurl": yTurl,
      };
}
