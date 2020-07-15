// To parse this JSON data, do
//
//     final feature = featureFromJson(jsonString);

import 'dart:convert';

Feature featureFromJson(String str) => Feature.fromJson(json.decode(str));

class Feature {
  Feature({
    this.localeKey,
    this.value,
  });

  String localeKey;
  String value;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        localeKey: json["LocaleKey"],
        value: json["Value"],
      );
}
