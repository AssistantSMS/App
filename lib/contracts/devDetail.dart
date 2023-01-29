// To parse this JSON data, do
//
//     final appDevDetailFile = appDevDetailFileFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class DevDetailFile {
  final String appId;
  final List<DevDetail> details;

  DevDetailFile({
    required this.appId,
    required this.details,
  });

  factory DevDetailFile.fromRawJson(String str) =>
      DevDetailFile.fromJson(json.decode(str));

  factory DevDetailFile.fromJson(Map<String, dynamic> json) => DevDetailFile(
        appId: readStringSafe(json, 'AppId'),
        details: readListSafe(json, 'Details', (x) => DevDetail.fromJson(x)),
      );
}

class DevDetail {
  final String name;
  final String value;

  DevDetail({
    required this.name,
    required this.value,
  });

  factory DevDetail.fromJson(Map<String, dynamic> json) => DevDetail(
        name: readStringSafe(json, 'Name'),
        value: readStringSafe(json, 'Value'),
      );
}
