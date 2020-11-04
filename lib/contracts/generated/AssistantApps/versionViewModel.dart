import 'dart:convert';

import '../../../helpers/jsonHelper.dart';
import '../../enum/platformType.dart';

class VersionViewModel {
  String guid;
  String appGuid;
  String markdown;
  String buildName;
  int buildNumber;
  List<PlatformType> platforms;
  DateTime activeDate;

  VersionViewModel({
    this.guid,
    this.appGuid,
    this.markdown,
    this.buildName,
    this.buildNumber,
    this.platforms,
    this.activeDate,
  });

  factory VersionViewModel.fromRawJson(String str) =>
      VersionViewModel.fromJson(json.decode(str));

  factory VersionViewModel.fromJson(Map<String, dynamic> json) =>
      VersionViewModel(
        guid: readStringSafe(json, 'guid'),
        appGuid: readStringSafe(json, 'appGuid'),
        markdown: readStringSafe(json, 'markdown'),
        buildName: readStringSafe(json, 'buildName'),
        buildNumber: readIntSafe(json, 'buildNumber'),
        platforms: readListSafe(json, 'platforms',
            (dynamic innerJson) => platformTypeValues.map[innerJson]),
        activeDate: readDateSafe(json, 'activeDate'),
      );
}
