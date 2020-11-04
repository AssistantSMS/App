import '../enum/enumBase.dart';

enum PlatformType {
  Android,
  iOS,
  Web,
  API,
}

final platformTypeValues = EnumValues({
  "0": PlatformType.Android,
  "1": PlatformType.iOS,
  "2": PlatformType.Web,
  "3": PlatformType.API,
});
