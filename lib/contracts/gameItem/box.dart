import 'dart:convert';

import 'package:assistantapps_flutter_common/helpers/jsonHelper.dart';

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
        x: readIntSafe(json, 'X'),
        y: readIntSafe(json, 'Y'),
        z: readIntSafe(json, 'Z'),
      );
}
