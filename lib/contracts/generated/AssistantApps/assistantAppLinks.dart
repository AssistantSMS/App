// To parse this JSON data, do
//
//     final assistantAppLinks = assistantAppLinksFromJson(jsonString);

import 'dart:convert';

class AssistantAppLinks {
  AssistantAppLinks({
    this.name,
    this.iconUrl,
    this.home,
    this.ios,
    this.android,
    this.web,
  });

  final String name;
  final String iconUrl;
  final String home;
  final String ios;
  final String android;
  final String web;

  factory AssistantAppLinks.fromRawJson(String str) =>
      AssistantAppLinks.fromJson(json.decode(str));

  factory AssistantAppLinks.fromJson(Map<String, dynamic> json) =>
      AssistantAppLinks(
        name: json["name"],
        iconUrl: json["iconUrl"],
        home: json["home"],
        ios: json["ios"],
        android: json["android"],
        web: json["web"],
      );
}
