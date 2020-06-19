import 'package:flutter/material.dart';

import '../../helpers/colourHelper.dart';
import '../../helpers/genericHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';

Widget responsiveStaggeredGridTilePresenter(
        IconData icon, Color backgroundColor,
        {Color iconColor, String text, Function() onTap}) =>
    Card(
      color: backgroundColor,
      child: InkWell(
        onTap: () {
          if (onTap != null) onTap();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor ?? Colors.white,
            ),
            (text != null)
                ? Padding(child: Text('test'), padding: EdgeInsets.only(top: 4))
                : Container(width: 0, height: 0),
          ],
        ),
      ),
    );

Widget responsiveStaggeredGridImageTilePresenter(
    BuildContext context, String imgPath, Color backgroundColor,
    {Color iconColor, LocaleKey text, double height, Function() onTap}) {
  var safeOnTap = () {
    if (onTap != null) onTap();
  };
  return responsiveStaggeredGridBaseTilePresenter(
    context,
    genericItemImage(context, imgPath, height: height, onTap: safeOnTap),
    backgroundColor,
    iconColor: iconColor,
    text: text,
    height: height,
    onTap: safeOnTap,
  );
}

Widget responsiveStaggeredGridIconTilePresenter(
    BuildContext context, IconData icon, Color backgroundColor,
    {Color iconColor, LocaleKey text, double height, Function() onTap}) {
  var safeOnTap = () {
    if (onTap != null) onTap();
  };
  return responsiveStaggeredGridBaseTilePresenter(
    context,
    GestureDetector(
      child: getCorrectlySizedImageFromIcon(
        context,
        icon,
        maxSize: height,
        colour: getForegroundTextColour(backgroundColor),
      ),
      onTap: safeOnTap,
    ),
    backgroundColor,
    iconColor: iconColor,
    text: text,
    height: height,
    onTap: safeOnTap,
  );
}

Widget responsiveStaggeredGridBaseTilePresenter(
    BuildContext context, Widget image, Color backgroundColor,
    {Color iconColor, LocaleKey text, double height, Function() onTap}) {
  var safeOnTap = () {
    if (onTap != null) onTap();
  };

  List<Widget> children = List<Widget>();
  children.add(Center(child: image));
  if (text != null) {
    children.add(Positioned(
      child: Text(
        Translations.get(context, text),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: getForegroundTextColour(backgroundColor),
        ),
      ),
      bottom: 8,
      left: 4,
      right: 4,
    ));
  }
  return Card(
    color: backgroundColor,
    child: InkWell(onTap: safeOnTap, child: Stack(children: children)),
  );
}
