// To parse this JSON data, do
//
//     final upgrade = upgradeFromJson(jsonString);

import 'dart:convert';

class Upgrade {
  Upgrade({
    this.localeKey,
    this.targetId,
    this.cost,
  });

  String localeKey;
  String targetId;
  int cost;

  factory Upgrade.fromRawJson(String str) => Upgrade.fromJson(json.decode(str));
  factory Upgrade.fromJson(Map<String, dynamic> json) => Upgrade(
        localeKey: json["LocaleKey"],
        targetId: json["TargetId"],
        cost: json["Cost"],
      );
}
