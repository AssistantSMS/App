// To parse this JSON data, do
//
//     final gameItemBase = gameItemBaseFromJson(jsonString);

import 'dart:convert';

import 'package:scrapmechanic_kurtlourens_com/helpers/jsonHelper.dart';

import '../rating/rating.dart';

class GameItemBase {
  GameItemBase({
    this.id,
    this.icon,
    this.color,
    this.physicsMaterial,
    this.rating,
    this.flammable,
    this.density,
    this.qualityLevel,
  });

  String id;
  String icon;
  String color;
  String physicsMaterial;
  Rating rating;
  bool flammable;
  double density;
  int qualityLevel;

  factory GameItemBase.fromRawJson(String str) =>
      GameItemBase.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GameItemBase.fromJson(Map<String, dynamic> json) => GameItemBase(
        id: readStringSafe(json, "Id"),
        icon: readStringSafe(json, "Icon"),
        color: readStringSafe(json, "Color"),
        physicsMaterial: readStringSafe(json, "PhysicsMaterial"),
        rating: Rating.fromJson(json["Ratings"]),
        flammable: readBoolSafe(json, "Flammable"),
        density: readDoubleSafe(json, "Density"),
        qualityLevel: readIntSafe(json, "QualityLevel"),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Icon": icon,
        "Color": color,
        "PhysicsMaterial": physicsMaterial,
        "Rating": rating.toJson(),
        "Flammable": flammable,
        "Density": density,
        "QualityLevel": qualityLevel,
      };
}
