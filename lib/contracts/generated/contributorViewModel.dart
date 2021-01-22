// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);
// https://app.quicktype.io/

import 'dart:convert';

import '../../helpers/jsonHelper.dart';

class ContributorViewModel {
  String name;
  String link;
  String imageUrl;
  String description;
  int sortRank;

  ContributorViewModel({
    this.name,
    this.link,
    this.imageUrl,
    this.description,
    this.sortRank,
  });

  factory ContributorViewModel.fromRawJson(String str) =>
      ContributorViewModel.fromJson(json.decode(str));

  factory ContributorViewModel.fromJson(Map<String, dynamic> json) =>
      ContributorViewModel(
        name: readStringSafe(json, 'name'),
        link: readStringSafe(json, 'link'),
        imageUrl: readStringSafe(json, 'imageUrl'),
        description: readStringSafe(json, 'description'),
        sortRank: readIntSafe(json, 'sortRank'),
      );
}
