// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);
// https://app.quicktype.io/

import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import '../../enum/donationType.dart';
import '../../../helpers/jsonHelper.dart';

class DonationViewModel {
  String username;
  DonationType type;
  DateTime date;

  DonationViewModel({
    this.username,
    this.type,
    this.date,
  });

  factory DonationViewModel.fromRawJson(String str) =>
      DonationViewModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DonationViewModel.fromJson(Map<String, dynamic> json) =>
      DonationViewModel(
        username: readStringSafe(json, 'username'),
        type: EnumToString.fromString(
            DonationType.values, readStringSafe(json, 'type')),
        date: readDateSafe(json, 'date'),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "type": type,
        "date": date.toIso8601String(),
      };
}
