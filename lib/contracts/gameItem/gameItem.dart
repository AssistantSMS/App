// To parse this JSON data, do
//
//     final gameItem = gameItemFromJson(jsonString);

import '../rating/rating.dart';
import 'box.dart';
import 'cylinder.dart';
import 'feature.dart';
import 'gameItemBase.dart';
import 'gameItemLang.dart';

class GameItem {
  GameItem({
    this.id,
    this.title,
    this.icon,
    this.color,
    this.physicsMaterial,
    this.rating,
    this.box,
    this.cylinder,
    this.flammable,
    this.density,
    this.qualityLevel,
    this.features,
  });

  String id;
  String title;
  String icon;
  String color;
  String physicsMaterial;
  Rating rating;
  Box box;
  Cylinder cylinder;
  bool flammable;
  double density;
  int qualityLevel;
  List<Feature> features;

  factory GameItem.fromBaseAndLang(GameItemBase baseItem, GameItemLang lang) =>
      GameItem(
        id: baseItem.id,
        title: lang.title,
        icon: baseItem.icon,
        color: baseItem.color,
        physicsMaterial: baseItem.physicsMaterial,
        rating: baseItem.rating,
        box: baseItem.box,
        cylinder: baseItem.cylinder,
        flammable: baseItem.flammable,
        density: baseItem.density,
        qualityLevel: baseItem.qualityLevel,
        features: baseItem.features,
      );
}
