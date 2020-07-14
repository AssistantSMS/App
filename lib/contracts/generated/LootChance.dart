import 'dart:convert';

class LootChance {
  LootChance({
    this.min,
    this.max,
    this.chance,
    this.type,
  });

  int min;
  int max;
  int chance;
  int type;

  factory LootChance.fromRawJson(String str) =>
      LootChance.fromJson(json.decode(str));
  factory LootChance.fromJson(Map<String, dynamic> json) => LootChance(
        min: json["min"],
        max: json["max"],
        chance: json["chance"],
        type: json["type"],
      );
}
