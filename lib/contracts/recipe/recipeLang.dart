// To parse this JSON data, do
//
//     final recipeLang = recipeLangFromJson(jsonString);

import 'dart:convert';

List<RecipeLang> recipeLangFromJson(String str) =>
    List<RecipeLang>.from(json.decode(str).map((x) => RecipeLang.fromJson(x)));

String recipeLangToJson(List<RecipeLang> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecipeLang {
  RecipeLang({
    this.id,
    this.title,
    this.description,
  });

  String id;
  String title;
  String description;

  factory RecipeLang.fromJson(Map<String, dynamic> json) => RecipeLang(
        id: json["Id"],
        title: json["Title"],
        description: json["Description"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
        "Description": description,
      };
}
