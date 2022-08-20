// To parse this JSON data, do
//
//     final locationInfoModel = locationInfoModelFromJson(jsonString);

import 'dart:convert';

LocationInfoModel locationInfoModelFromJson(String str) => LocationInfoModel.fromJson(json.decode(str));

String locationInfoModelToJson(LocationInfoModel data) => json.encode(data.toJson());

class LocationInfoModel {
  LocationInfoModel({
    this.locationInfo,
  });

  LocationInfo? locationInfo;

  factory LocationInfoModel.fromJson(Map<String, dynamic> json) => LocationInfoModel(
    locationInfo: LocationInfo.fromJson(json["location_info"]),
  );

  Map<String, dynamic> toJson() => {
    "location_info": locationInfo!.toJson(),
  };
}

class LocationInfo {
  LocationInfo({
    this.nickname,
    this.locLat,
    this.locLong,
    this.city,
    this.locActive,
    this.locTimes,
  });

  String? nickname;
  String? locLat;
  String? locLong;
  String? city;
  String? locActive;
  String? locTimes;

  factory LocationInfo.fromJson(Map<String, dynamic> json) => LocationInfo(
    nickname: json["nickname"],
    locLat: json["loc_lat"],
    locLong: json["loc_long"],
    city: json["city"],
    locActive: json["loc_active"],
    locTimes: json["loc_times"],
  );

  Map<String, dynamic> toJson() => {
    "nickname": nickname,
    "loc_lat": locLat,
    "loc_long": locLong,
    "city": city,
    "loc_active": locActive,
    "loc_times": locTimes,
  };
}
