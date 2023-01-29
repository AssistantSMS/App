import 'dart:convert';

import 'package:assistantapps_flutter_common/helpers/jsonHelper.dart';

class Box {
  int x;
  int y;
  int z;

  Box({
    required this.x,
    required this.y,
    required this.z,
  });

  factory Box.fromRawJson(String str) => Box.fromJson(json.decode(str));

  factory Box.fromJson(Map<String, dynamic> json) => Box(
        x: readIntSafe(json, 'X'),
        y: readIntSafe(json, 'Y'),
        z: readIntSafe(json, 'Z'),
      );
}
