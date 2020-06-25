import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/localization/translations.dart';

import '../../helpers/colourHelper.dart';
import '../../helpers/genericHelper.dart';
import '../../localization/localeKey.dart';

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
    BuildContext context, String imgPath,
    {Color iconColor, LocaleKey text, double height, Function() onTap}) {
  var safeOnTap = () {
    if (onTap != null) onTap();
  };
  return responsiveStaggeredGridBaseTilePresenter(
    context,
    genericItemImage(context, imgPath, height: height, onTap: safeOnTap),
    iconColor: iconColor,
    text: text,
    height: height,
    onTap: safeOnTap,
  );
}

Widget responsiveStaggeredGridIconTilePresenter(
    BuildContext context, IconData icon,
    {Color iconColor, LocaleKey text, double height, Function() onTap}) {
  var safeOnTap = () {
    if (onTap != null) onTap();
  };
  var backgroundColor = getSecondaryColour(context);
  return Card(
    color: backgroundColor,
    child: InkWell(
      onTap: safeOnTap,
      child: Column(
        children: [
          GestureDetector(
            child: getCorrectlySizedImageFromIcon(
              context,
              icon,
              maxSize: 45,
              colour: Colors.white,
            ),
            onTap: safeOnTap,
          ),
          Padding(
            child: Text(
              Translations.get(context, text),
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                color: getForegroundTextColour(backgroundColor),
              ),
            ),
            padding: EdgeInsets.only(left: 8, top: 4, right: 8),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    ),
  );
}

Widget responsiveStaggeredGridBaseTilePresenter(
    BuildContext context, Widget image,
    {Color iconColor, LocaleKey text, double height, Function() onTap}) {
  var safeOnTap = () {
    if (onTap != null) onTap();
  };

  // var backgroundColor = backgroundColor;
  // var backgroundColor =HexColor("4B7287");
  // var backgroundColor = HexColor("21536C");
  var backgroundColor = getSecondaryColour(context);
  List<Widget> children = List<Widget>();
  // children.add(Center(child: image));
  children.add(Positioned(
    child: image,
    top: 4,
    left: 4,
    right: 4,
  ));
  if (text != null) {
    children.add(Positioned(
      child: Padding(
        child: Text(
          Translations.get(context, text),
          textAlign: TextAlign.center,
          maxLines: 1,
          style: TextStyle(
            color: getForegroundTextColour(backgroundColor),
          ),
        ),
        padding: EdgeInsets.only(left: 8, top: 4, right: 8),
      ),
      bottom: 4,
      left: 4,
      right: 4,
    ));
  }

  var child = children.length == 1
      ? children[0]
      : Stack(
          children: children,
          // mainAxisAlignment: MainAxisAlignment.center,
        );

  return Card(
    color: backgroundColor,
    child: InkWell(onTap: safeOnTap, child: child),
  );
}
