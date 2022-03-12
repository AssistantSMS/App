// To parse this JSON data, do
//
//     final appDevDetailFile = appDevDetailFileFromMap(jsonString);

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class DevDetailFile {
  DevDetailFile({
    this.appId,
    this.details,
  });

  final String appId;
  final List<DevDetail> details;

  factory DevDetailFile.fromJson(Map<String, dynamic> json) => DevDetailFile(
        appId: readStringSafe(json, 'AppId'),
        details: readListSafe(json, 'Details', (x) => DevDetail.fromJson(x)),
      );
}

class DevDetail {
  DevDetail({
    this.name,
    this.value,
  });

  final String name;
  final String value;

  factory DevDetail.fromJson(Map<String, dynamic> json) => DevDetail(
        name: readStringSafe(json, 'Name'),
        value: readStringSafe(json, 'Value'),
      );
}
