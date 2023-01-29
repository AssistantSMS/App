import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class Rating {
  int? density;
  int? durability;
  int? friction;
  int? buoyancy;

  Rating({
    required this.density,
    required this.durability,
    required this.friction,
    required this.buoyancy,
  });

  factory Rating.fromRawJson(String str) => Rating.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rating.fromJson(Map<dynamic, dynamic> json) => Rating(
        density: readIntSafe(json, "Density"),
        durability: readIntSafe(json, "Durability"),
        friction: readIntSafe(json, "Friction"),
        buoyancy: readIntSafe(json, "Buoyancy"),
      );

  Map<String, dynamic> toJson() => {
        "Density": density,
        "Durability": durability,
        "Friction": friction,
        "Buoyancy": buoyancy,
      };
}
