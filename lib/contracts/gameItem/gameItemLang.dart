// To parse this JSON data, do
//
//     final gameItemLang = gameItemLangFromJson(jsonString);

import 'dart:convert';

class GameItemLang {
  GameItemLang({
    this.id,
    this.title,
  });

  String id;
  String title;

  factory GameItemLang.fromRawJson(String str) =>
      GameItemLang.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GameItemLang.fromJson(Map<String, dynamic> json) => GameItemLang(
        id: json["Id"],
        title: json["Title"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
      };
}
