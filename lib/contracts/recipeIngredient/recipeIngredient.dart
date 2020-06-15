// To parse this JSON data, do
//
//     final recipeIngredient = recipeIngredientFromJson(jsonString);

import 'dart:convert';

import 'package:scrapmechanic_kurtlourens_com/helpers/jsonHelper.dart';

List<RecipeIngredient> recipeIngredientFromJson(String str) =>
    List<RecipeIngredient>.from(
        json.decode(str).map((x) => RecipeIngredient.fromJson(x)));

String recipeIngredientToJson(List<RecipeIngredient> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecipeIngredient {
  RecipeIngredient({
    this.id,
    this.quantity,
  });

  String id;
  int quantity;

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) =>
      RecipeIngredient(
        id: readStringSafe(json, "Id"),
        quantity: readIntSafe(json, "Quantity"),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Quantity": quantity,
      };
}
