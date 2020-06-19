import 'package:flutter/material.dart';

import '../integration/themeManager.dart';
import '../theme/themes.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    if (hexColor == null) return 0;
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

Color getPrimaryColour(BuildContext context) =>
    getTheme(context)?.primaryColor ?? Colors.indigo[500];

Color getSecondaryColour(BuildContext context) =>
    getTheme(context)?.accentColor ?? Colors.teal[200];

Color getDarkModeSecondaryColour() => darkTheme('Roboto').accentColor;

bool getIsDark(BuildContext context) =>
    getTheme(context)?.brightness == Brightness.dark;

Color getBackgroundColour(BuildContext context) =>
    getTheme(context).backgroundColor;

Color getH1Colour(BuildContext context) {
  var textColour = getTheme(context).textTheme.headline1.color;
  if (textColour == null)
    return getIsDark(context) ? Colors.white : Colors.black;
  return textColour;
}

Color getTextColour(BuildContext context) =>
    getIsDark(context) ? Colors.white : Colors.black;

Color getCardTextColour(BuildContext context) =>
    getIsDark(context) ? Colors.white54 : Colors.black54;

bool useWhiteForeground(Color backgroundColor) =>
    1.05 / (backgroundColor.computeLuminance() + 0.05) > 2.5;

Color getForegroundTextColour(Color backgroundColor) =>
    useWhiteForeground(backgroundColor) ? Colors.white : Colors.black;
