import 'package:flutter/material.dart';

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
  return responsiveStaggeredGridBaseTilePresenter(
    context,
    GestureDetector(
      child: getCorrectlySizedImageFromIcon(
        context,
        icon,
        maxSize: 50,
        colour: Colors.white,
      ),
      onTap: safeOnTap,
    ),
    iconColor: iconColor,
    text: text,
    height: height,
    onTap: safeOnTap,
  );
}

Widget responsiveStaggeredGridBaseTilePresenter(
    BuildContext context, Widget image,
    {Color iconColor, LocaleKey text, double height, Function() onTap}) {
  var safeOnTap = () {
    if (onTap != null) onTap();
  };

  List<Widget> children = List<Widget>();
  children.add(Center(child: image));
  // if (text != null) {
  //   children.add(Positioned(
  //     child: Padding(
  //       child: Text(
  //         Translations.get(context, text),
  //         textAlign: TextAlign.center,
  //         maxLines: 1,
  //         style: TextStyle(
  //           color: getForegroundTextColour(backgroundColor),
  //         ),
  //       ),
  //       padding: EdgeInsets.only(left: 8, top: 4, right: 8),
  //     ),
  //     bottom: 8,
  //     left: 4,
  //     right: 4,
  //   ));
  // }

  // var backgroundColor = backgroundColor;
  // var backgroundColor =HexColor("4B7287");
  // var backgroundColor = HexColor("21536C");
  var backgroundColor = getSecondaryColour(context);
  return Card(
    color: backgroundColor,
    child: InkWell(
      onTap: safeOnTap,
      child: Stack(
        children: children,
        // mainAxisAlignment: MainAxisAlignment.center,
      ),
    ),
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.only(
    //     topRight: Radius.circular(25),
    //     bottomLeft: Radius.circular(25),
    //   ),
    // ),
  );
}
