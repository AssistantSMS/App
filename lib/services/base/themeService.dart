import 'package:flutter/material.dart';
import 'package:assistantapps_flutter_common/services/base/interface/IThemeService.dart';
import 'package:scrapmechanic_kurtlourens_com/theme/themes.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

class ThemeService implements IThemeService {
  @override
  ThemeData getTheme(BuildContext context) =>
      ((ThemeModeHandler.of(context)?.themeMode ?? ThemeMode.light) ==
              ThemeMode.light)
          ? getDynamicTheme(Brightness.light)
          : getDynamicTheme(Brightness.dark);

  @override
  Color getPrimaryColour(BuildContext context) =>
      getTheme(context)?.primaryColor ?? Colors.indigo[500];

  @override
  Color getSecondaryColour(BuildContext context) =>
      getTheme(context)?.accentColor ?? Colors.teal[200];

  @override
  Color getDarkModeSecondaryColour() => darkTheme('Roboto').accentColor;

  @override
  bool getIsDark(BuildContext context) =>
      getTheme(context)?.brightness == Brightness.dark;

  @override
  Color getBackgroundColour(BuildContext context) => getIsDark(context)
      ? darkTheme('Roboto').backgroundColor
      : lightTheme('Roboto').backgroundColor;

  @override
  Color getScaffoldBackgroundColour(BuildContext context) => getIsDark(context)
      ? darkTheme('Roboto').scaffoldBackgroundColor
      : lightTheme('Roboto').scaffoldBackgroundColor;

  @override
  Color getH1Colour(BuildContext context) {
    var textColour = getTheme(context).textTheme.headline1.color;
    if (textColour == null)
      return getIsDark(context) ? Colors.white : Colors.black;
    return textColour;
  }

  @override
  Color getTextColour(BuildContext context) =>
      getIsDark(context) ? Colors.white : Colors.black;

  @override
  void setBrightness(BuildContext context, bool isDark) {
    ThemeModeHandler.of(context)
        .saveThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
  }

  @override
  Color getAndroidColour() => Color(0);

  @override
  Color getIosColour() => Color(0);

  @override
  Color getCardTextColour(BuildContext context) =>
      getIsDark(context) ? Colors.white54 : Colors.black54;

  @override
  bool useWhiteForeground(Color backgroundColor) =>
      1.05 / (backgroundColor.computeLuminance() + 0.05) > 2.5;

  @override
  Color getForegroundTextColour(Color backgroundColor) =>
      useWhiteForeground(backgroundColor) ? Colors.white : Colors.black;

  @override
  Color fabForegroundColourSelector(BuildContext context) =>
      getPrimaryColour(context);

  @override
  Color fabColourSelector(BuildContext context) => Colors.white;
}
