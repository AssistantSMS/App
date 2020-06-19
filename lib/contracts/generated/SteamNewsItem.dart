// To parse this JSON data, do
//
//     final steamNewsItem = steamNewsItemFromJson(jsonString);

import 'dart:convert';

class SteamNewsItem {
  String name;
  DateTime date;
  String link;
  String image;
  String smallImage;
  String shortDescription;

  SteamNewsItem({
    this.name,
    this.date,
    this.link,
    this.image,
    this.smallImage,
    this.shortDescription,
  });

  List<SteamNewsItem> steamNewsItemFromJson(String str) =>
      List<SteamNewsItem>.from(
          json.decode(str).map((x) => SteamNewsItem.fromJson(x)));

  factory SteamNewsItem.fromJson(Map<String, dynamic> json) => SteamNewsItem(
        name: json["name"],
        date: DateTime.parse(json["date"]),
        link: json["link"],
        image: json["image"],
        smallImage: json["smallImage"],
        shortDescription: json["shortDescription"],
      );
}
