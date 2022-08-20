// To parse this JSON data, do
//
//     final finishTripsModel = finishTripsModelFromJson(jsonString);

import 'dart:convert';

FinishTripsModel finishTripsModelFromJson(String str) => FinishTripsModel.fromJson(json.decode(str));

String finishTripsModelToJson(FinishTripsModel data) => json.encode(data.toJson());

class FinishTripsModel {
  FinishTripsModel({
    this.completedTrips,
  });

  List<CompletedTrip>? completedTrips;

  factory FinishTripsModel.fromJson(Map<String, dynamic> json) => FinishTripsModel(
    completedTrips: List<CompletedTrip>.from(json["completed_trips"].map((x) => CompletedTrip.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "completed_trips": List<dynamic>.from(completedTrips!.map((x) => x.toJson())),
  };
}

class CompletedTrip {
  CompletedTrip({
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

  factory CompletedTrip.fromJson(Map<String, dynamic> json) => CompletedTrip(
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
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
    "time": time,
  };
}
