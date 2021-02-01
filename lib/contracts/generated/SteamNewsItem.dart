// To parse this JSON data, do
//
//     final steamNewsItem = steamNewsItemFromJson(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class SteamNewsItem {
  String name;
  DateTime date;
  String link;
  String image;
  String smallImage;
  String shortDescription;
  int upVotes;
  int downVotes;
  int commentCount;

  SteamNewsItem({
    this.name,
    this.date,
    this.link,
    this.image,
    this.smallImage,
    this.shortDescription,
    this.upVotes,
    this.downVotes,
    this.commentCount,
  });

  List<SteamNewsItem> steamNewsItemFromJson(String str) =>
      List<SteamNewsItem>.from(
          json.decode(str).map((x) => SteamNewsItem.fromJson(x)));

  factory SteamNewsItem.fromJson(Map<String, dynamic> json) => SteamNewsItem(
        name: readStringSafe(json, 'name'),
        date: readDateSafe(json, 'date'),
        link: readStringSafe(json, 'link'),
        image: readStringSafe(json, 'image'),
        smallImage: readStringSafe(json, 'smallImage'),
        shortDescription: readStringSafe(json, 'shortDescription'),
        upVotes: readIntSafe(json, "upVotes"),
        downVotes: readIntSafe(json, "downVotes"),
        commentCount: readIntSafe(json, "commentCount"),
      );
}
