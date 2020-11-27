// To parse this JSON data, do
//
//     final xhAddressModel = xhAddressModelFromJson(jsonString);

import 'dart:convert';

List<XHAddressModel> xhAddressModelFromJson(String str) =>
    List<XHAddressModel>.from(
        json.decode(str).map((x) => XHAddressModel.fromJson(x)));

String xhAddressModelToJson(List<XHAddressModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class XHAddressModel {
  XHAddressModel({
    this.clientid,
    this.aid,
    this.provinceAndCity,
    this.detailAddress,
    this.showAddress,
    this.receiver,
    this.telephone,
    this.postCode,
    this.provinceAndCityCode,
    this.discount,
  });

  int clientid;
  int aid;
  String provinceAndCity;
  String detailAddress;
  String showAddress;
  String receiver;
  String telephone;
  String postCode;
  String provinceAndCityCode;
  double discount;

  factory XHAddressModel.fromJson(Map<String, dynamic> json) => XHAddressModel(
        clientid: json["clientid"],
        aid: json["aid"],
        provinceAndCity: json["provinceAndCity"],
        detailAddress: json["detailAddress"],
        showAddress: json["provinceAndCity"] + " " + json["detailAddress"],
        receiver: json["receiver"],
        telephone: json["telephone"],
        postCode: json["postCode"],
        provinceAndCityCode: json["provinceAndCityCode"],
        discount: json["discount"],
      );

  Map<String, dynamic> toJson() => {
        "clientid": clientid,
        "aid": aid,
        "provinceAndCity": provinceAndCity,
        "detailAddress": detailAddress,
        "receiver": receiver,
        "telephone": telephone,
        "postCode": postCode,
        "provinceAndCityCode": provinceAndCityCode,
        "discount": discount,
      };
}
