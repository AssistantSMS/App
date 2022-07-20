// To parse this JSON data, do
//
//     final gameItemBase = gameItemBaseFromJson(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:scrapmechanic_kurtlourens_com/contracts/enum/customisationSourceType.dart';

import './cylinder.dart';
import '../rating/rating.dart';
import 'box.dart';
import 'feature.dart';
import 'upgrade.dart';
import 'edible.dart';

class GameItemBase {
  GameItemBase({
    this.id,
    this.icon,
    this.color,
    this.physicsMaterial,
    this.rating,
    this.box,
    this.cylinder,
    this.flammable,
    this.isCreative,
    this.isChallenge,
    this.features,
    this.upgrade,
    this.edible,
    this.customisationSource,
  });

  String id;
  String icon;
  String color;
  String physicsMaterial;
  Rating rating;
  Box box;
  Cylinder cylinder;
  bool flammable;
  bool isCreative;
  bool isChallenge;
  Upgrade upgrade;
  Edible edible;
  List<Feature> features;
  CustomisationSourceType customisationSource;

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
        cylinder: json["Cylinder"] == null
            ? null
            : Cylinder.fromJson(json["Cylinder"]),
        upgrade:
            json["Upgrade"] == null ? null : Upgrade.fromJson(json["Upgrade"]),
        edible: json["Edible"] == null ? null : Edible.fromJson(json["Edible"]),
        features: json["Features"] == null
            ? null
            : List<Feature>.from(
                json["Features"].map((x) => Feature.fromJson(x))),
        flammable: readBoolSafe(json, "Flammable"),
        isCreative: readBoolSafe(json, "IsCreative"),
        isChallenge: readBoolSafe(json, "IsChallenge"),
        customisationSource: CustomisationSourceType
            .values[(json["CustomisationSource"] as int ?? 0)],
      );
}
