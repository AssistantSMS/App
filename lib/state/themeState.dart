import '../helpers/jsonHelper.dart';

class ThemeState {
  final String themeMode;

  ThemeState(this.themeMode);

  ThemeState.fromJson(Map<String, dynamic> json)
      : themeMode = readStringSafe(json, 'themeMode');

  Map<String, dynamic> toJson() => {
        'themeMode': themeMode,
      };
}
