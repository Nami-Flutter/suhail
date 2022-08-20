// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoriesModel categoryModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));

String categoryModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel {
  CategoriesModel({
    this.categories,
    this.manufacturers,
  });

  List<Category>? categories;
  List<Manufacturer>? manufacturers;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    manufacturers: List<Manufacturer>.from(json["manufacturers"].map((x) => Manufacturer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
    "manufacturers": List<dynamic>.from(manufacturers!.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.categoryId,
    this.name,
  });

  String? categoryId;
  String? name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryId: json["category_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "name": name,
  };
}

class Manufacturer {
  Manufacturer({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Manufacturer.fromJson(Map<String, dynamic> json) => Manufacturer(
    id: json["parent_manufacturer_id"],
    name: json["parent_manufacturer_name"],
  );

  Map<String, dynamic> toJson() => {
    "parent_manufacturer_id": id,
    "parent_manufacturer_name": name,
  };
}
