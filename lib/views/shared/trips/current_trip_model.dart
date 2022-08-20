// To parse this JSON data, do
//
//     final currentTripsModel = currentTripsModelFromJson(jsonString);

import 'dart:convert';

CurrentTripsModel currentTripsModelFromJson(String str) => CurrentTripsModel.fromJson(json.decode(str));

String currentTripsModelToJson(CurrentTripsModel data) => json.encode(data.toJson());

class CurrentTripsModel {
  CurrentTripsModel({
    this.currentTrips,
  });

  List<CurrentTrip>? currentTrips;

  factory CurrentTripsModel.fromJson(Map<String, dynamic> json) => CurrentTripsModel(
    currentTrips: List<CurrentTrip>.from(json["current_trips"].map((x) => CurrentTrip.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "current_trips": List<dynamic>.from(currentTrips!.map((x) => x.toJson())),
  };
}

class CurrentTrip {
  CurrentTrip({
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

  factory CurrentTrip.fromJson(Map<String, dynamic> json) => CurrentTrip(
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
