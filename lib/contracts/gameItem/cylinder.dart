import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class Cylinder {
  int diameter;
  int depth;

  Cylinder({
    required this.diameter,
    required this.depth,
  });

  factory Cylinder.fromRawJson(String str) =>
      Cylinder.fromJson(json.decode(str));

  factory Cylinder.fromJson(Map<String, dynamic> json) => Cylinder(
        diameter: readIntSafe(json, 'Diameter'),
        depth: readIntSafe(json, 'Depth'),
      );
}
