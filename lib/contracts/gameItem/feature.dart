// To parse this JSON data, do
//
//     final feature = featureFromJson(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

Feature featureFromJson(String str) => Feature.fromJson(json.decode(str));

class Feature {
  String localeKey;
  String value;

  Feature({
    required this.localeKey,
    required this.value,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        localeKey: readStringSafe(json, 'LocaleKey'),
        value: readStringSafe(json, 'Value'),
      );
}
