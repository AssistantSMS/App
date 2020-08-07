// To parse this JSON data, do
//
//     final patreonViewModel = patreonViewModelFromJson(jsonString);

import 'dart:convert';

class PatreonViewModel {
  PatreonViewModel({
    this.name,
    this.imageUrl,
    this.thumbnailUrl,
    this.url,
  });

  String name;
  String imageUrl;
  String thumbnailUrl;
  String url;

  factory PatreonViewModel.fromRawJson(String str) =>
      PatreonViewModel.fromJson(json.decode(str));

  factory PatreonViewModel.fromJson(Map<String, dynamic> json) =>
      PatreonViewModel(
        name: json["name"],
        imageUrl: json["imageUrl"],
        thumbnailUrl: json["thumbnailUrl"],
        url: json["url"],
      );
}
