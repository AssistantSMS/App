// To parse this JSON data, do
//
//     final gameItem = gameItemFromJson(jsonString);

import '../enum/customisationSourceType.dart';
import '../rating/rating.dart';
import 'box.dart';
import 'cylinder.dart';
import 'edible.dart';
import 'feature.dart';
import 'gameItemBase.dart';
import 'gameItemLang.dart';
import 'upgrade.dart';

class GameItem {
  GameItem({
    this.id,
    this.title,
    this.description,
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
  String title;
  String description;
  String icon;
  String color;
  String physicsMaterial;
  Rating rating;
  Box box;
  Cylinder cylinder;
  bool isCreative;
  bool isChallenge;
  bool flammable;
  Upgrade upgrade;
  Edible edible;
  List<Feature> features;
  CustomisationSourceType customisationSource;

  factory GameItem.fromBaseAndLang(GameItemBase baseItem, GameItemLang lang) =>
      GameItem(
        id: baseItem.id,
        title: lang.title,
        description: lang.description,
        icon: baseItem.icon,
        color: baseItem.color,
        physicsMaterial: baseItem.physicsMaterial,
        rating: baseItem.rating,
        box: baseItem.box,
        cylinder: baseItem.cylinder,
        flammable: baseItem.flammable,
        isCreative: baseItem.isCreative,
        isChallenge: baseItem.isChallenge,
        features: baseItem.features,
        upgrade: baseItem.upgrade,
        edible: baseItem.edible,
        customisationSource: baseItem.customisationSource,
      );
}
