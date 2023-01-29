import 'dart:convert';

class LootChance {
  int min;
  int max;
  int chance;
  int type;

  LootChance({
    required this.min,
    required this.max,
    required this.chance,
    required this.type,
  });

  factory LootChance.fromRawJson(String str) =>
      LootChance.fromJson(json.decode(str));
  factory LootChance.fromJson(Map<String, dynamic> json) => LootChance(
        min: json["min"],
        max: json["max"],
        chance: json["chance"],
        type: json["type"],
      );
}
