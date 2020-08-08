// To parse this JSON data, do
//
//     final steamNewsItem = steamNewsItemFromJson(jsonString);

import 'dart:convert';

import 'package:scrapmechanic_kurtlourens_com/helpers/jsonHelper.dart';

class SteamNewsItem {
  String name;
  DateTime date;
  String link;
  String image;
  String smallImage;
  String shortDescription;
  int upVotes;
  int downVotes;

  SteamNewsItem({
    this.name,
    this.date,
    this.link,
    this.image,
    this.smallImage,
    this.shortDescription,
    this.upVotes,
    this.downVotes,
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
        upVotes: readIntSafe(json, "upVotes"),
        downVotes: readIntSafe(json, "downVotes"),
      );
}
