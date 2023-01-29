// To parse this JSON data, do
//
//     final gameItemLang = gameItemLangFromJson(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class GameItemLang {
  String id;
  String title;
  String description;

  GameItemLang({
    required this.id,
    required this.title,
    required this.description,
  });

  factory GameItemLang.fromRawJson(String str) =>
      GameItemLang.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GameItemLang.fromJson(Map<String, dynamic> json) => GameItemLang(
        id: readStringSafe(json, "Id"),
        title: readStringSafe(json, "Title"),
        description: readStringSafe(json, "Description"),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
        "Description": description,
      };
}
