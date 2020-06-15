import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/helpers/genericHelper.dart';

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
    {Color iconColor, String text, double height, Function() onTap}) {
  var safeOnTap = () {
    if (onTap != null) onTap();
  };
  return Card(
    color: backgroundColor,
    child: InkWell(
      onTap: safeOnTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          genericItemImage(context, imgPath, height: height, onTap: safeOnTap),
          (text != null)
              ? Padding(child: Text('test'), padding: EdgeInsets.only(top: 4))
              : Container(width: 0, height: 0),
        ],
      ),
    ),
  );
}
