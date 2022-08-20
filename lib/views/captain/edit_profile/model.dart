// To parse this JSON data, do
//
//     final captainInfo = captainInfoFromJson(jsonString);

import 'dart:convert';

CaptainInfoModel captainInfoFromJson(String str) => CaptainInfoModel.fromJson(json.decode(str));

String captainInfoToJson(CaptainInfoModel data) => json.encode(data.toJson());

class CaptainInfoModel {
  CaptainInfoModel({
    this.captainInfo,
  });

  List<CaptainInfoElement>? captainInfo;

  factory CaptainInfoModel.fromJson(Map<String, dynamic> json) => CaptainInfoModel(
    captainInfo: List<CaptainInfoElement>.from(json["captain_info"].map((x) => CaptainInfoElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "captain_info": List<dynamic>.from(captainInfo!.map((x) => x.toJson())),
  };
}

class CaptainInfoElement {
  CaptainInfoElement({
    this.captainId,
    this.captainName,
    this.captainRating,
    this.categoryName,
    this.vehicleModel,
    this.vehicleType,
    this.vehicleYear,
    this.vehicleNumber,
  });

  String? captainId;
  String? captainName;
  int? captainRating;
  String? categoryName;
  String? vehicleModel;
  String? vehicleType;
  String? vehicleYear;
  String? vehicleNumber;

  factory CaptainInfoElement.fromJson(Map<String, dynamic> json) => CaptainInfoElement(
    captainId: json["captain_id"],
    captainName: json["captain_name"],
    captainRating: json["captain_rating"],
    categoryName: json["category_name"],
    vehicleModel: json["vehicle_model"],
    vehicleType: json["vehicle_type"],
    vehicleYear: json["vehicle_year"],
    vehicleNumber: json["vehicle_number"],
  );

  Map<String, dynamic> toJson() => {
    "captain_id": captainId,
    "captain_name": captainName,
    "captain_rating": captainRating,
    "category_name": categoryName,
    "vehicle_model": vehicleModel,
    "vehicle_type": vehicleType,
    "vehicle_year": vehicleYear,
    "vehicle_number": vehicleNumber,
  };
}
