import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class Edible {
  Edible({
    this.hpGain,
    this.foodGain,
    this.waterGain,
  });

  int hpGain;
  int foodGain;
  int waterGain;

  factory Edible.fromRawJson(String str) => Edible.fromJson(json.decode(str));

  factory Edible.fromJson(Map<String, dynamic> json) => Edible(
        hpGain: readIntSafe(json, 'HpGain'),
        foodGain: readIntSafe(json, 'FoodGain'),
        waterGain: readIntSafe(json, 'WaterGain'),
      );
}
