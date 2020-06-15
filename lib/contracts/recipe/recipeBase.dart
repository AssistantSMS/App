// To parse this JSON data, do
//
//     final recipeBase = recipeBaseFromJson(jsonString);

import 'dart:convert';

import '../recipeIngredient/recipeIngredient.dart';

List<RecipeBase> recipeBaseFromJson(String str) =>
    List<RecipeBase>.from(json.decode(str).map((x) => RecipeBase.fromJson(x)));

String recipeBaseToJson(List<RecipeBase> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecipeBase {
  RecipeBase({
    this.id,
    this.icon,
    this.ingredients,
  });

  String id;
  String icon;
  List<RecipeIngredient> ingredients;

  factory RecipeBase.fromJson(Map<String, dynamic> json) => RecipeBase(
        id: json["Id"],
        icon: json["Icon"],
        ingredients: List<RecipeIngredient>.from(
            json["Ingredients"].map((x) => RecipeIngredient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Icon": icon,
        "Ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
      };
}
