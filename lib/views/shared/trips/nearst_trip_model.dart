// To parse this JSON data, do
//
//     final nearestTripModel = nearestTripModelFromJson(jsonString);

import 'dart:convert';

NearestTripModel nearestTripModelFromJson(String str) => NearestTripModel.fromJson(json.decode(str));

String nearestTripModelToJson(NearestTripModel data) => json.encode(data.toJson());

class NearestTripModel {
  NearestTripModel({
    this.trips,
  });

  List<Trip>? trips;

  factory NearestTripModel.fromJson(Map<String, dynamic> json) => NearestTripModel(
    trips: List<Trip>.from(json["trips"].map((x) => Trip.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "trips": List<dynamic>.from(trips!.map((x) => x.toJson())),
  };
}

class Trip {
  Trip({
    this.tripId,
    this.name,
    this.cost,
    this.date,
    this.time,
  });

  String? tripId;
  String? name;
  String? cost;
  DateTime? date;
  String? time;

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
    tripId: json["trip_id"],
    name: json["name"],
    cost: json["cost"],
    date: DateTime.parse(json["date"]),
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "trip_id": tripId,
    "name": name,
    "cost": cost,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "time": time,
  };
}
