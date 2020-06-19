import 'package:flutter/material.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';
import 'package:theme_mode_handler/theme_mode_manager_interface.dart';

import '../contracts/results/resultWithValue.dart';
import '../state/themeState.dart';
import '../theme/themes.dart';
import 'dependencyInjection.dart';

class ThemeManager implements IThemeModeManager {
  @override
  Future<String> loadThemeMode() async {
    ResultWithValue<ThemeState> themeResult =
        await getStorageService().loadThemeState();
    var defaultThemeMode = 'ThemeMode.dark';
    if (themeResult.isSuccess)
      return themeResult?.value?.themeMode ?? defaultThemeMode;
    return defaultThemeMode;
  }

  @override
  Future<bool> saveThemeMode(String value) async {
    var result = await getStorageService().saveThemeState(ThemeState(value));
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
