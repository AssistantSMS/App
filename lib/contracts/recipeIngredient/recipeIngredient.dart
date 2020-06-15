// To parse this JSON data, do
//
//     final recipeIngredient = recipeIngredientFromJson(jsonString);

import 'dart:convert';

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
        id: json["Id"],
        quantity: json["Quantity"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Quantity": quantity,
      };
}
