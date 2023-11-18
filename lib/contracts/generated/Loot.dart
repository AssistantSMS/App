// To parse this JSON data, do
//
//     final loot = lootFromJson(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

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
        appId: readStringSafe(json, 'appId'),
        chances: readListSafe(
          json,
          'chances',
          (x) => LootChance.fromJson(x),
        ),
      );
}
