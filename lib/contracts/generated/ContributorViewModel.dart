// To parse this JSON data, do
//
//     final patreonViewModel = patreonViewModelFromJson(jsonString);

import 'dart:convert';

class ContributorViewModel {
  ContributorViewModel({
    this.name,
    this.link,
    this.imageUrl,
    this.description,
    this.sortRank,
  });

  String name;
  String link;
  String imageUrl;
  String description;
  int sortRank;

  factory ContributorViewModel.fromRawJson(String str) =>
      ContributorViewModel.fromJson(json.decode(str));

  factory ContributorViewModel.fromJson(Map<String, dynamic> json) =>
      ContributorViewModel(
        name: json["name"],
        link: json["link"],
        imageUrl: json["imageUrl"],
        description: json["description"],
        sortRank: json["sortRank"] as int,
      );
}
