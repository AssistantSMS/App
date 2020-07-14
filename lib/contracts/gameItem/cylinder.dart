import 'dart:convert';

class Cylinder {
  Cylinder({
    this.diameter,
    this.depth,
  });

  int diameter;
  int depth;

  factory Cylinder.fromRawJson(String str) =>
      Cylinder.fromJson(json.decode(str));

  factory Cylinder.fromJson(Map<String, dynamic> json) => Cylinder(
        diameter: json["Diameter"],
        depth: json["Depth"],
      );
}
