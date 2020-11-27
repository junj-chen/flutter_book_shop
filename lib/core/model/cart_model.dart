// To parse this JSON data, do
//
//     final xhCartModel = xhCartModelFromJson(jsonString);

import 'dart:convert';

XHCartModel xhCartModelFromJson(String str) =>
    XHCartModel.fromJson(json.decode(str));

String xhCartModelToJson(XHCartModel data) => json.encode(data.toJson());

class XHCartModel {
  XHCartModel({
    this.clientid,
    this.productId,
    this.imageUrl,
    this.opid,
    this.qty,
    this.addDate,
    this.check,
    this.src,
    this.bookDetail,
    this.unitPrice,
    this.count,
    this.partMoney,
    this.activityId,
    this.qtyTotal,
    this.price,
  });

  int clientid;
  String productId;
  String imageUrl;
  int opid;
  int qty;
  DateTime addDate;
  bool check;
  String src;
  String bookDetail;
  String unitPrice;
  int count;
  String partMoney;
  int activityId;
  int qtyTotal;
  String price;

  factory XHCartModel.fromJson(Map<String, dynamic> json) => XHCartModel(
        clientid: json["clientid"],
        productId: json["productId"],
        imageUrl: "http://image.yuetaowang.cn/images/Thumbnail/" +
            json["productId"] +
            "-150.jpg",
        opid: json["opid"],
        qty: json["qty"],
        addDate: DateTime.parse(json["add_date"]),
        check: json["check"],
        src: json["src"],
        bookDetail: json["bookDetail"],
        unitPrice: json["unitPrice"],
        count: json["count"],
        partMoney: json["partMoney"],
        activityId: json["activityId"],
        qtyTotal: json["qtyTotal"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "clientid": clientid,
        "productId": productId,
        "opid": opid,
        "qty": qty,
        "add_date": addDate.toIso8601String(),
        "check": check,
        "src": src,
        "bookDetail": bookDetail,
        "unitPrice": unitPrice,
        "count": count,
        "partMoney": partMoney,
        "activityId": activityId,
        "qtyTotal": qtyTotal,
        "price": price,
      };
}
