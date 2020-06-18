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
    this.output,
    this.inputs,
  });

  String id;
  String icon;
  RecipeIngredient output;
  List<RecipeIngredient> inputs;

  factory RecipeBase.fromJson(Map<String, dynamic> json) => RecipeBase(
        id: readStringSafe(json, "Id"),
        icon: readStringSafe(json, "Icon"),
        output: RecipeIngredient.fromJson(json["Output"]),
        inputs: List<RecipeIngredient>.from(
            json["Inputs"].map((x) => RecipeIngredient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Icon": icon,
        "Output": output.toJson(),
        "Inputs": List<dynamic>.from(inputs.map((x) => x.toJson())),
      };
}
