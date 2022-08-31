import 'dart:convert';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    this.candidates,
  });

  List<Candidate>? candidates;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    candidates: List<Candidate>.from(
        json["candidates"].map((x) => Candidate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "candidates": List<dynamic>.from(candidates!.map((x) => x.toJson())),
  };
}

class Candidate {
  Candidate({
    this.formattedAddress,
    this.geometry,
  });

  String? formattedAddress;
  Geometry? geometry;

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
    formattedAddress: json["formatted_address"],
    geometry: Geometry.fromJson(json["geometry"]),
  );

  Map<String, dynamic> toJson() => {
    "formatted_address": formattedAddress,
    "geometry": geometry!.toJson(),
  };
}

class Geometry {
  Geometry({
    this.location,
  });

  Location? location;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    location: Location.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location!.toJson(),
  };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  double? lat;
  double? lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}