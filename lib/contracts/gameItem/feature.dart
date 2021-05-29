// To parse this JSON data, do
//
//     final feature = featureFromJson(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

Feature featureFromJson(String str) => Feature.fromJson(json.decode(str));

class Feature {
  Feature({
    this.localeKey,
    this.value,
  });

  String localeKey;
  String value;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        localeKey: readStringSafe(json, 'LocaleKey'),
        value: readStringSafe(json, 'Value'),
      );
}
