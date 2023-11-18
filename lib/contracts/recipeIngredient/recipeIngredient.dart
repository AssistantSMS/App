// To parse this JSON data, do
//
//     final recipeIngredient = recipeIngredientFromJson(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

List<RecipeIngredient> recipeIngredientFromJson(String str) =>
    List<RecipeIngredient>.from(
        json.decode(str).map((x) => RecipeIngredient.fromJson(x)));

String recipeIngredientToJson(List<RecipeIngredient> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecipeIngredient {
  String id;
  int quantity;

  RecipeIngredient({
    required this.id,
    this.quantity = 0,
  });

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) {
    try {
      return RecipeIngredient(
        id: readStringSafe(json, "Id"),
        quantity: readIntSafe(json, "Quantity"),
      );
    } catch (exception) {
      return RecipeIngredient(
        id: '',
        quantity: 0,
      );
    }
  }

  factory RecipeIngredient.initial() => RecipeIngredient(
        id: '',
        quantity: 0,
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Quantity": quantity,
      };
}
