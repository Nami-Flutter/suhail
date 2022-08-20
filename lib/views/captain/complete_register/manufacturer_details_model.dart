// To parse this JSON data, do
//
//     final manufacturerDetailsModel = manufacturerDetailsModelFromJson(jsonString);

import 'dart:convert';

ManufacturerDetailsModel manufacturerDetailsModelFromJson(String str) => ManufacturerDetailsModel.fromJson(json.decode(str));

String manufacturerDetailsModelToJson(ManufacturerDetailsModel data) => json.encode(data.toJson());

class ManufacturerDetailsModel {
  ManufacturerDetailsModel({
    this.manufacturerDetails,
  });

  List<ManufacturerDetail>? manufacturerDetails;

  factory ManufacturerDetailsModel.fromJson(Map<String, dynamic> json) => ManufacturerDetailsModel(
    manufacturerDetails: List<ManufacturerDetail>.from(json["manufacturer_details"].map((x) => ManufacturerDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "manufacturer_details": List<dynamic>.from(manufacturerDetails!.map((x) => x.toJson())),
  };
}

class ManufacturerDetail {
  ManufacturerDetail({
    this.id,
    this.name,
    this.yearFrom,
    this.yearTo,
  });

  String? id;
  String? name;
  String? yearFrom;
  String? yearTo;

  factory ManufacturerDetail.fromJson(Map<String, dynamic> json) => ManufacturerDetail(
    id: json["manufacturer_id"],
    name: json["manufacturer_name"],
    yearFrom: json["manufacturer_year_from"],
    yearTo: json["manufacturer_year_to"],
  );

  Map<String, dynamic> toJson() => {
    "manufacturer_id": id,
    "manufacturer_name": name,
    "manufacturer_year_from": yearFrom,
    "manufacturer_year_to": yearTo,
  };
}
