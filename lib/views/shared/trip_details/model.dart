// To parse this JSON data, do
//
//     final tripDetailsModel = tripDetailsModelFromJson(jsonString);

import 'dart:convert';

TripDetailsModel tripDetailsModelFromJson(String str) => TripDetailsModel.fromJson(json.decode(str));

String tripDetailsModelToJson(TripDetailsModel data) => json.encode(data.toJson());

class TripDetailsModel {
  TripDetailsModel({
    this.tripDetails,
    this.captainDetails,
  });

  TripDetails? tripDetails;
  List<CaptainDetail>? captainDetails;

  factory TripDetailsModel.fromJson(Map<String, dynamic> json) => TripDetailsModel(
    tripDetails: TripDetails.fromJson(json["trip_details"]),
    captainDetails: List<CaptainDetail>.from(json["captain_details"].map((x) => CaptainDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "trip_details": tripDetails!.toJson(),
    "captain_details": List<dynamic>.from(captainDetails!.map((x) => x.toJson())),
  };
}

class CaptainDetail {
  CaptainDetail({
    this.captainId,
    this.captainName,
    this.captainTelephone,
    this.captainRating,
    this.categoryName,
    this.vehicleModel,
    this.vehicleType,
    this.vehicleYear,
    this.vehicleNumber,
  });

  String? captainId;
  String? captainName;
  String? captainTelephone;
  int? captainRating;
  String? categoryName;
  String? vehicleModel;
  String? vehicleType;
  String? vehicleYear;
  String? vehicleNumber;

  factory CaptainDetail.fromJson(Map<String, dynamic> json) => CaptainDetail(
    captainId: json["captain_id"],
    captainName: json["captain_name"],
    captainTelephone: json["captain_telephone"],
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
    "captain_telephone": captainTelephone,
    "captain_rating": captainRating,
    "category_name": categoryName,
    "vehicle_model": vehicleModel,
    "vehicle_type": vehicleType,
    "vehicle_year": vehicleYear,
    "vehicle_number": vehicleNumber,
  };
}

class TripDetails {
  TripDetails({
    this.tripId,
    this.customerId,
    this.customerName,
    this.customerTelephone,
    this.tripCategory,
    this.tripReceiptLong,
    this.tripReceiptLat,
    this.tripReceiptAddress,
    this.tripDeliveryLong,
    this.tripDeliveryLat,
    this.tripDeliveryAddress,
    this.tripCost,
    this.tripDate,
    this.tripTime,
    this.tripDetails,
    this.tripDistance,
    this.tripImages,
    this.tripStatus,
    this.paymentFlag,
    this.paymentMethod,
  });

  String? tripId;
  String? customerId;
  String? customerName;
  String? customerTelephone;
  String? tripCategory;
  String? tripReceiptLong;
  String? tripReceiptLat;
  String? tripReceiptAddress;
  String? tripDeliveryLong;
  String? tripDeliveryLat;
  String? tripDeliveryAddress;
  String? tripCost;
  DateTime? tripDate;
  String? tripTime;
  String? tripDetails;
  int? tripDistance;
  List<dynamic>? tripImages;
  String? tripStatus;
  int? paymentFlag;
  String? paymentMethod;

  factory TripDetails.fromJson(Map<String, dynamic> json) => TripDetails(
    tripId: json["trip_id"],
    customerId: json["customer_id"],
    customerName: json["customer_name"],
    customerTelephone: json["customer_telephone"],
    tripCategory: json["trip_category"],
    tripReceiptLong: json["trip_receipt_long"],
    tripReceiptLat: json["trip_receipt_lat"],
    tripReceiptAddress: json["trip_receipt_address"],
    tripDeliveryLong: json["trip_delivery_long"],
    tripDeliveryLat: json["trip_delivery_lat"],
    tripDeliveryAddress: json["trip_delivery_address"],
    tripCost: json["trip_cost"],
    tripDate: DateTime.parse(json["trip_date"]),
    tripTime: json["trip_time"],
    tripDetails: json["trip_details"],
    tripDistance: json["trip_distance"],
    tripImages: List<dynamic>.from(json["trip_images"].map((x) => x)),
    tripStatus: json["trip_status"],
    paymentFlag: json["payment_flag"],
    paymentMethod: json["payment_method"],
  );

  Map<String, dynamic> toJson() => {
    "trip_id": tripId,
    "customer_id": customerId,
    "customer_name": customerName,
    "customer_telephone": customerTelephone,
    "trip_category": tripCategory,
    "trip_receipt_long": tripReceiptLong,
    "trip_receipt_lat": tripReceiptLat,
    "trip_receipt_address": tripReceiptAddress,
    "trip_delivery_long": tripDeliveryLong,
    "trip_delivery_lat": tripDeliveryLat,
    "trip_delivery_address": tripDeliveryAddress,
    "trip_cost": tripCost,
    "trip_date": "${tripDate!.year.toString().padLeft(4, '0')}-${tripDate!.month.toString().padLeft(2, '0')}-${tripDate!.day.toString().padLeft(2, '0')}",
    "trip_time": tripTime,
    "trip_details": tripDetails,
    "trip_distance": tripDistance,
    "trip_images": List<dynamic>.from(tripImages!.map((x) => x)),
    "trip_status": tripStatus,
    "payment_flag": paymentFlag,
    "payment_method": paymentMethod,
  };
}
