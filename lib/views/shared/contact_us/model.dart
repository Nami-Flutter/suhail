// To parse this JSON data, do
//
//     final contactInfoModel = contactInfoModelFromJson(jsonString);

import 'dart:convert';

ContactInfoModel contactInfoModelFromJson(String str) => ContactInfoModel.fromJson(json.decode(str));

String contactInfoModelToJson(ContactInfoModel data) => json.encode(data.toJson());

class ContactInfoModel {
  ContactInfoModel({
    this.headingTitle,
    this.address,
    this.telephone,
    this.fax,
    this.open,
  });

  String? headingTitle;
  String? address;
  String? telephone;
  String? fax;
  String? open;

  factory ContactInfoModel.fromJson(Map<String, dynamic> json) => ContactInfoModel(
    headingTitle: json["heading_title"],
    address: json["address"],
    telephone: json["telephone"],
    fax: json["fax"],
    open: json["open"],
  );

  Map<String, dynamic> toJson() => {
    "heading_title": headingTitle,
    "address": address,
    "telephone": telephone,
    "fax": fax,
    "open": open,
  };
}
