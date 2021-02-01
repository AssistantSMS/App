import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class ThemeState {
  final String themeMode;

  ThemeState(this.themeMode);

  ThemeState.fromJson(Map<String, dynamic> json)
      : themeMode = readStringSafe(json, 'themeMode');

  Map<String, dynamic> toJson() => {
        'themeMode': themeMode,
      };
}
