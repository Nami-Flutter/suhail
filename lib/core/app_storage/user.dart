// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.firstname,
    this.lastname,
    this.telephone,
    this.customerId,
    this.customerGroup
  });

  String? firstname;
  String? lastname;
  String? telephone;
  int? customerId;
  int? customerGroup;


  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    firstname: json["firstname"],
    lastname: json["lastname"],
    telephone: json["telephone"],
    customerId: json['customer_id'],
    customerGroup: json['customer_group'],
  );

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "telephone": telephone,
    "customer_id": customerId,
    "customer_group": customerGroup,
  };
}
