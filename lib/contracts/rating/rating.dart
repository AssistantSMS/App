import 'dart:convert';

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

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        density: json["Density"],
        durability: json["Durability"],
        friction: json["Friction"],
        buoyancy: json["Buoyancy"],
      );

  Map<String, dynamic> toJson() => {
        "Density": density,
        "Durability": durability,
        "Friction": friction,
        "Buoyancy": buoyancy,
      };
}
