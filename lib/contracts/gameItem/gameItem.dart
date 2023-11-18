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
  String id;
  String title;
  String description;
  String? icon;
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

  GameItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.physicsMaterial,
    this.rating,
    this.box,
    this.cylinder,
    required this.isCreative,
    required this.isChallenge,
    this.flammable,
    this.upgrade,
    this.edible,
    required this.features,
    required this.customisationSource,
  });

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

  factory GameItem.initial() => GameItem(
        id: '',
        title: '',
        description: '',
        icon: '',
        color: '',
        physicsMaterial: '',
        isCreative: false,
        isChallenge: false,
        features: List.empty(),
        customisationSource: CustomisationSourceType.unknown,
      );
}
