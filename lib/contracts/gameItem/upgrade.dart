// To parse this JSON data, do
//
//     final upgrade = upgradeFromJson(jsonString);

import 'dart:convert';

class Upgrade {
  String localeKey;
  String targetId;
  int cost;

  Upgrade({
    required this.localeKey,
    required this.targetId,
    required this.cost,
  });

  factory Upgrade.fromRawJson(String str) => Upgrade.fromJson(json.decode(str));
  factory Upgrade.fromJson(Map<String, dynamic> json) => Upgrade(
        localeKey: json["LocaleKey"],
        targetId: json["TargetId"],
        cost: json["Cost"],
      );
}
