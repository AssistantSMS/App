import 'dart:convert';

import '../../enum/platformType.dart';

class VersionSearchViewModel {
  String appGuid;
  List<PlatformType> platforms;
  String languageCode;
  int page;

  VersionSearchViewModel({
    this.appGuid,
    this.platforms,
    this.languageCode,
    this.page,
  });

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "AppGuid": appGuid,
        "Platforms": platforms,
        "LanguageCode": languageCode,
        "Page": page,
      };
}
