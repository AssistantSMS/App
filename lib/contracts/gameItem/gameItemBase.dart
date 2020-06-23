// To parse this JSON data, do
//
//     final gameItemBase = gameItemBaseFromJson(jsonString);

import 'dart:convert';

import '../../helpers/jsonHelper.dart';

import '../rating/rating.dart';
import 'box.dart';

class GameItemBase {
  GameItemBase({
    this.id,
    this.icon,
    this.color,
    this.physicsMaterial,
    this.rating,
    this.box,
    this.flammable,
    this.density,
    this.qualityLevel,
  });

  String id;
  String icon;
  String color;
  String physicsMaterial;
  Rating rating;
  Box box;
  bool flammable;
  double density;
  int qualityLevel;

  factory GameItemBase.fromRawJson(String str) =>
      GameItemBase.fromJson(json.decode(str));

  factory GameItemBase.fromJson(Map<String, dynamic> json) => GameItemBase(
        id: readStringSafe(json, "Id"),
        icon: readStringSafe(json, "Icon"),
        color: readStringSafe(json, "Color"),
        physicsMaterial: readStringSafe(json, "PhysicsMaterial"),
        rating:
            json["Ratings"] == null ? null : Rating.fromJson(json["Ratings"]),
        box: json["Box"] == null ? null : Box.fromJson(json["Box"]),
        flammable: readBoolSafe(json, "Flammable"),
        density: readDoubleSafe(json, "Density"),
        qualityLevel: readIntSafe(json, "QualityLevel"),
      );
}
