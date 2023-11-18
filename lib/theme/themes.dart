import 'package:flutter/material.dart';

import '../constants/Fonts.dart';

ThemeData getDynamicTheme(Brightness brightness) {
  String fontFamily = defaultFontFamily;
  return brightness == Brightness.dark
      ? darkTheme(fontFamily)
      : lightTheme(fontFamily);
}

ThemeData lightTheme(String fontFamily) {
  final base = ThemeData.light();
  final primary = Colors.orange[600]!;
  final secondary = Colors.lightBlue[400]!;
  return fromBaseTheme(
    fontFamily,
    base,
    primary,
    secondary,
  ).copyWith(
    // backgroundColor: Colors.grey[200],
    cardTheme: const CardTheme(color: Color.fromRGBO(230, 230, 230, 1)),
  );
}

ThemeData darkTheme(String fontFamily) {
  final base = ThemeData.dark();
  final primary = Colors.orange[600]!;
  final secondary = Colors.lightBlue[600]!;
  return fromBaseTheme(
    fontFamily,
    base,
    primary,
    secondary,
  );
}

ThemeData fromBaseTheme(
  String fontFamily,
  ThemeData base,
  Color primary,
  Color secondary,
) {
  return base.copyWith(
    primaryColor: primary,
    // accentColor: secondary, //DEPRECATED
    colorScheme: base.colorScheme.copyWith(
      primary: primary,
      secondary: secondary,
      // secondaryVariant: secondary,
    ),
    textTheme: _buildAppTextTheme(base.textTheme, fontFamily),
    primaryTextTheme: _buildAppTextTheme(base.primaryTextTheme, fontFamily),
    // accentTextTheme: _buildAppTextTheme(base.accentTextTheme, fontFamily), //DEPRECATED
    iconTheme: IconThemeData(color: secondary),
    buttonTheme: ButtonThemeData(
      buttonColor: secondary,
      textTheme: ButtonTextTheme.primary,
    ),
    brightness: Brightness.dark,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
  );
}

TextTheme _buildAppTextTheme(TextTheme base, String fontFamily) {
  return base
      .copyWith(
        headlineSmall:
            base.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
        titleLarge: base.titleLarge?.copyWith(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
        bodySmall: base.bodySmall?.copyWith(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      )
      .apply(fontFamily: fontFamily);
}
