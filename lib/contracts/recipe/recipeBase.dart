// To parse this JSON data, do
//
//     final recipeBase = recipeBaseFromJson(jsonString);

import 'dart:convert';

import 'package:scrapmechanic_kurtlourens_com/helpers/jsonHelper.dart';

import '../recipeIngredient/recipeIngredient.dart';

List<RecipeBase> recipeBaseFromJson(String str) =>
    List<RecipeBase>.from(json.decode(str).map((x) => RecipeBase.fromJson(x)));

String recipeBaseToJson(List<RecipeBase> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecipeBase {
  RecipeBase({
    this.id,
    this.icon,
    this.craftingTime,
    this.output,
    this.inputs,
  });

  String id;
  String icon;
  int craftingTime;
  RecipeIngredient output;
  List<RecipeIngredient> inputs;

  factory RecipeBase.fromJson(Map<String, dynamic> json) => RecipeBase(
        id: readStringSafe(json, "Id"),
        icon: readStringSafe(json, "Icon"),
        craftingTime: readIntSafe(json, "CraftingTime"),
        output: RecipeIngredient.fromJson(json["Output"]),
        inputs: List<RecipeIngredient>.from(
            json["Inputs"].map((x) => RecipeIngredient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Icon": icon,
        "CraftingTime": craftingTime,
        "Output": output.toJson(),
        "Inputs": List<dynamic>.from(inputs.map((x) => x.toJson())),
      };
}
