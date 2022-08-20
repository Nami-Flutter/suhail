// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.mainCategories,
  });

  List<MainCategory>? mainCategories;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    mainCategories: List<MainCategory>.from(json["main_categories"].map((x) => MainCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "main_categories": List<dynamic>.from(mainCategories!.map((x) => x.toJson())),
  };
}

class MainCategory {
  MainCategory({
    this.categoryId,
    this.name,
    this.image,
  });

  String? categoryId;
  String? name;
  String? image;

  factory MainCategory.fromJson(Map<String, dynamic> json) => MainCategory(
    categoryId: json["category_id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "name": name,
    "image": image,
  };
}
