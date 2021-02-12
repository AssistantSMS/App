import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../helpers/genericHelper.dart';

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
    {Color iconColor, LocaleKey text, Function() onTap}) {
  var safeOnTap = () {
    if (onTap != null) onTap();
  };
  return responsiveStaggeredGridBaseTilePresenter(
    context,
    genericItemImage(context, imgPath, height: 1000, onTap: safeOnTap),
    iconColor: iconColor,
    text: text,
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
    Center(
        child: getCorrectlySizedImageFromIcon(
      context,
      icon,
      maxSize: 45,
      colour: Colors.white,
    )),
    iconColor: iconColor,
    text: text,
    onTap: safeOnTap,
  );
  // var backgroundColor = getSecondaryColour(context);
  // return Card(
  //   color: backgroundColor,
  //   child: InkWell(
  //     onTap: safeOnTap,
  //     child: Column(
  //       children: [
  //         GestureDetector(
  //           child: getCorrectlySizedImageFromIcon(
  //             context,
  //             icon,
  //             maxSize: 100,
  //             colour: Colors.white,
  //           ),
  //           onTap: safeOnTap,
  //         ),
  //         Padding(
  //           child: Text(
  //             getTranslations().fromKey(text),
  //             textAlign: TextAlign.center,
  //             maxLines: 1,
  //             style: TextStyle(
  //               color: getForegroundTextColour(backgroundColor),
  //             ),
  //           ),
  //           padding: EdgeInsets.only(left: 8, top: 4, right: 8),
  //         )
  //       ],
  //       mainAxisAlignment: MainAxisAlignment.center,
  //     ),
  //   ),
  // );
}

Widget responsiveStaggeredGridBaseTilePresenter(
    BuildContext context, Widget image,
    {Color iconColor, LocaleKey text, Function() onTap}) {
  var safeOnTap = () {
    if (onTap != null) onTap();
  };

  // var backgroundColor = backgroundColor;
  // var backgroundColor =HexColor("4B7287");
  // var backgroundColor = HexColor("21536C");
  var backgroundColor = getTheme().getSecondaryColour(context);
  List<Widget> children = List.empty(growable: true);
  // children.add(Center(child: image));
  children.add(
    Padding(
      child: image,
      padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 24),
    ),
  );
  if (text != null) {
    children.add(Positioned(
      child: Padding(
        child: Text(
          getTranslations().fromKey(text),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: getTheme().getForegroundTextColour(backgroundColor),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 2),
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
