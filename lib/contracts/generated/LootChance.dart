import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

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
        min: readIntSafe(json, 'min'),
        max: readIntSafe(json, 'max'),
        chance: readIntSafe(json, 'chance'),
        type: readIntSafe(json, 'type'),
      );
}
