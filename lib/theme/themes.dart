import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData getDynamicTheme(Brightness brightness) {
  // String fontFamily = useNMSFont ? 'nms' : 'Roboto';
  String fontFamily = 'Roboto';
  return brightness == Brightness.dark
      ? darkTheme(fontFamily)
      : lightTheme(fontFamily);
}

ThemeData lightTheme(String fontFamily) {
  final base = ThemeData.light();
  final primary = Colors.orange[600];
  final secondary = Colors.lightBlue[400];
  return base.copyWith(
      primaryColor: primary,
      accentColor: secondary,
      backgroundColor: Colors.grey[200],
      textTheme: _buildAppTextTheme(base.textTheme, fontFamily),
      primaryTextTheme: _buildAppTextTheme(base.primaryTextTheme, fontFamily),
      accentTextTheme: _buildAppTextTheme(base.accentTextTheme, fontFamily),
      cardTheme: CardTheme(color: Color.fromRGBO(230, 230, 230, 1)),
      iconTheme: IconThemeData(color: secondary),
      buttonTheme: ButtonThemeData(
        buttonColor: secondary,
        textTheme: ButtonTextTheme.primary,
      ),
      brightness: Brightness.light,
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }));
}

ThemeData darkTheme(String fontFamily) {
  final base = ThemeData.dark();
  final primary = Colors.orange[600];
  final secondary = Colors.lightBlue[400];
  return base.copyWith(
      primaryColor: primary,
      accentColor: secondary,
      textTheme: _buildAppTextTheme(base.textTheme, fontFamily),
      primaryTextTheme: _buildAppTextTheme(base.primaryTextTheme, fontFamily),
      accentTextTheme: _buildAppTextTheme(base.accentTextTheme, fontFamily),
      iconTheme: IconThemeData(color: secondary),
      buttonTheme: ButtonThemeData(
        buttonColor: secondary,
        textTheme: ButtonTextTheme.primary,
      ),
      brightness: Brightness.dark,
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }));
}

TextTheme _buildAppTextTheme(TextTheme base, String fontFamily) {
  return base
      .copyWith(
        headline5: base.headline5.copyWith(fontWeight: FontWeight.w900),
        headline6: base.headline6.copyWith(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
        caption: base.caption.copyWith(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      )
      .apply(fontFamily: fontFamily);
}
