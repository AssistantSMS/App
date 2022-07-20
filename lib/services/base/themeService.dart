import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:assistantapps_flutter_common/services/base/interface/IThemeService.dart';
import 'package:scrapmechanic_kurtlourens_com/constants/Fonts.dart';
import 'package:scrapmechanic_kurtlourens_com/theme/themes.dart';

class ThemeService implements IThemeService {
  @override
  ThemeData getTheme(BuildContext context) {
    return AdaptiveTheme.of(context).theme;
  }

  @override
  Color getPrimaryColour(BuildContext context) =>
      getTheme(context)?.primaryColor ?? Colors.indigo[500];

  @override
  Color getSecondaryColour(BuildContext context) =>
      getTheme(context)?.colorScheme?.secondary ?? Colors.teal[200];

  @override
  Color getDarkModeSecondaryColour() =>
      darkTheme(defaultFontFamily).colorScheme.secondary;

  @override
  bool getIsDark(BuildContext context) =>
      getTheme(context)?.brightness == Brightness.dark;

  @override
  Color getBackgroundColour(BuildContext context) => getIsDark(context)
      ? darkTheme(defaultFontFamily).backgroundColor
      : lightTheme(defaultFontFamily).backgroundColor;

  @override
  Color getScaffoldBackgroundColour(BuildContext context) => getIsDark(context)
      ? darkTheme(defaultFontFamily).scaffoldBackgroundColor
      : lightTheme(defaultFontFamily).scaffoldBackgroundColor;

  @override
  Color getH1Colour(BuildContext context) {
    var textColour = getTheme(context).textTheme.headline1.color;
    if (textColour == null) {
      return getIsDark(context) ? Colors.white : Colors.black;
    }
    return textColour;
  }

  @override
  Color getTextColour(BuildContext context) =>
      getIsDark(context) ? Colors.white : Colors.black;

  @override
  void setBrightness(BuildContext context, bool isDark) {
    AdaptiveTheme.of(context)?.setThemeMode(
        isDark ? AdaptiveThemeMode.light : AdaptiveThemeMode.dark);
  }

  @override
  Color getAndroidColour() => const Color(0x00000000);

  @override
  Color getIosColour() => const Color(0x00000000);

  @override
  Color getCardTextColour(BuildContext context) =>
      getIsDark(context) ? Colors.white54 : Colors.black54;

  @override
  Color getCardBackgroundColour(BuildContext context) =>
      getTheme(context).cardTheme.color;

  @override
  void setFontFamily(BuildContext context, String fontFamily) {}

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

  @override
  Color buttonBackgroundColour(BuildContext context) =>
      getSecondaryColour(context);

  @override
  Color buttonForegroundColour(BuildContext context) => Colors.white;
}
