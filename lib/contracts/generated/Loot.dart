// To parse this JSON data, do
//
//     final loot = lootFromJson(jsonString);

import 'dart:convert';

import 'LootChance.dart';

class Loot {
  String appId;
  List<LootChance> chances;

  Loot({
    required this.appId,
    required this.chances,
  });

  factory Loot.fromRawJson(String str) => Loot.fromJson(json.decode(str));
  factory Loot.fromJson(Map<String, dynamic> json) => Loot(
        appId: json["appId"],
        chances: List<LootChance>.from(
            json["chances"].map((x) => LootChance.fromJson(x))),
      );
}
