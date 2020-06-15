// To parse this JSON data, do
//
//     final gameItem = gameItemFromJson(jsonString);

import '../rating/rating.dart';
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
    this.flammable,
    this.density,
    this.qualityLevel,
  });

  String id;
  String title;
  String icon;
  String color;
  String physicsMaterial;
  Rating rating;
  bool flammable;
  double density;
  int qualityLevel;

  factory GameItem.fromBaseAndLang(GameItemBase baseItem, GameItemLang lang) =>
      GameItem(
        id: baseItem.id,
        title: lang.title,
        icon: baseItem.icon,
        color: baseItem.color,
        physicsMaterial: baseItem.physicsMaterial,
        rating: baseItem.rating,
        flammable: baseItem.flammable,
        density: baseItem.density,
        qualityLevel: baseItem.qualityLevel,
      );
}
