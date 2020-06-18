import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/helpers/jsonHelper.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';
import 'package:theme_mode_handler/theme_mode_manager_interface.dart';

import '../constants/AppConfig.dart';
import '../theme/themes.dart';
import 'dependencyInjection.dart';

class ThemeManager implements IThemeModeManager {
  @override
  Future<String> loadThemeMode() async {
    var themeResult = await getStorageService().loadFromStorage<ThemeState>(
      AppConfig.themeKey,
      (dynamic json) => ThemeState.fromJson(json),
    );
    var defaultThemeMode = 'ThemeMode.dark';
    if (themeResult.isSuccess)
      return themeResult?.value?.themeMode ?? defaultThemeMode;
    return defaultThemeMode;
  }

  @override
  Future<bool> saveThemeMode(String value) async {
    var result = await getStorageService().saveToStorage(
      AppConfig.themeKey,
      json.encode(ThemeState(value)),
    );
    return result.isSuccess;
  }
}

class ThemeState {
  final String themeMode;

  ThemeState(this.themeMode);

  ThemeState.fromJson(Map<String, dynamic> json)
      : themeMode = readStringSafe(json, 'themeMode');

  Map<String, dynamic> toJson() => {
        'themeMode': themeMode,
      };
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
