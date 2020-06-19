import 'dart:convert';

class Box {
  Box({
    this.x,
    this.y,
    this.z,
  });

  int x;
  int y;
  int z;

  factory Box.fromRawJson(String str) => Box.fromJson(json.decode(str));

  factory Box.fromJson(Map<String, dynamic> json) => Box(
        x: json["X"],
        y: json["Y"],
        z: json["Z"],
      );
}
