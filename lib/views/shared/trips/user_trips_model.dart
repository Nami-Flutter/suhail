// To parse this JSON data, do
//
//     final allUserTripsModel = allUserTripsModelFromJson(jsonString);

import 'dart:convert';

AllUserTripsModel allUserTripsModelFromJson(String str) => AllUserTripsModel.fromJson(json.decode(str));

String allUserTripsModelToJson(AllUserTripsModel data) => json.encode(data.toJson());

class AllUserTripsModel {
  AllUserTripsModel({
    this.currentTrips,
    this.completedTrips,
  });

  List<Trip>? currentTrips;
  List<Trip>? completedTrips;

  factory AllUserTripsModel.fromJson(Map<String, dynamic> json) => AllUserTripsModel(
    currentTrips: List<Trip>.from(json["current_trips"].map((x) => Trip.fromJson(x))),
    completedTrips: List<Trip>.from(json["completed_trips"].map((x) => Trip.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "current_trips": List<dynamic>.from(currentTrips!.map((x) => x.toJson())),
    "completed_trips": List<dynamic>.from(completedTrips!.map((x) => x.toJson())),
  };
}

class Trip {
  Trip({
    this.tripId,
    this.name,
    this.cost,
    this.date,
    this.time,
    this.status,
  });

  String? tripId;
  String? name;
  String? cost;
  DateTime? date;
  String? time;
  String? status;

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
    tripId: json["trip_id"],
    name: json["name"],
    cost: json["cost"],
    date: DateTime.parse(json["date"]),
    time: json["time"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "trip_id": tripId,
    "name": name,
    "cost": cost,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "time": time,
    "status": status,
  };
}
