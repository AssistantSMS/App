// To parse this JSON data, do
//
//     final gameItemBase = gameItemBaseFromJson(jsonString);

import 'dart:convert';

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
        id: json["Id"],
        icon: json["Icon"],
        color: json["Color"],
        physicsMaterial: json["PhysicsMaterial"],
        rating: Rating.fromJson(json["Ratings"]),
        flammable: json["Flammable"],
        density: json["Density"],
        qualityLevel: json["QualityLevel"],
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
