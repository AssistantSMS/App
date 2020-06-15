import 'package:flutter/material.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';
import 'package:theme_mode_handler/theme_mode_manager_interface.dart';

import '../constants/AppConfig.dart';
import '../theme/themes.dart';
import 'dependencyInjection.dart';

class ThemeManager implements IThemeModeManager {
  @override
  Future<String> loadThemeMode() async {
    var themeResult = await getStorageService()
        .loadFromStorage<String>(AppConfig.hiveBoxThemeKey);

    if (themeResult.isSuccess) return themeResult.value;
    return 'ThemeMode.dark';
  }

  @override
  Future<bool> saveThemeMode(String value) async {
    var result = await getStorageService()
        .saveToStorage(AppConfig.hiveBoxThemeKey, value);
    return result.isSuccess;
  }
}

ThemeData getTheme(BuildContext context) =>
    ((ThemeModeHandler.of(context)?.themeMode ?? ThemeMode.light) ==
            ThemeMode.light)
        ? getDynamicTheme(Brightness.light)
        : getDynamicTheme(Brightness.dark);

void setBrightness(BuildContext context, bool isDark) {
  ThemeModeHandler.of(context)
      .saveThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
}
