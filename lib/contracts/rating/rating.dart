import 'dart:convert';

import '../../helpers/jsonHelper.dart';

class Rating {
  Rating({
    this.density,
    this.durability,
    this.friction,
    this.buoyancy,
  });

  int density;
  int durability;
  int friction;
  int buoyancy;

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
