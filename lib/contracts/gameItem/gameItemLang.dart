// To parse this JSON data, do
//
//     final gameItemLang = gameItemLangFromJson(jsonString);

import 'dart:convert';

import '../../helpers/jsonHelper.dart';

class GameItemLang {
  GameItemLang({
    this.id,
    this.title,
    this.description,
  });

  String id;
  String title;
  String description;

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
