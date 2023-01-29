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
  String id;
  String icon;
  String color;
  String physicsMaterial;
  Rating? rating;
  Box? box;
  Cylinder? cylinder;
  bool isCreative;
  bool isChallenge;
  bool? flammable;
  Upgrade? upgrade;
  Edible? edible;
  List<Feature> features;
  CustomisationSourceType customisationSource;

  GameItemBase({
    required this.id,
    required this.icon,
    required this.color,
    required this.physicsMaterial,
    required this.rating,
    required this.box,
    required this.cylinder,
    required this.flammable,
    required this.isCreative,
    required this.isChallenge,
    required this.features,
    required this.upgrade,
    required this.edible,
    required this.customisationSource,
  });

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
        features: readListSafe(json, 'Features', (x) => Feature.fromJson(x)),
        flammable: readBoolSafe(json, "Flammable"),
        isCreative: readBoolSafe(json, "IsCreative"),
        isChallenge: readBoolSafe(json, "IsChallenge"),
        customisationSource: CustomisationSourceType
            .values[readIntSafe(json, 'CustomisationSource')],
      );
}
