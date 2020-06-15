import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helpers/deviceHelper.dart';

Widget listWithScrollbar(
    {int itemCount,
    Key key,
    Widget Function(BuildContext, int) itemBuilder,
    EdgeInsetsGeometry padding,
    bool shrinkWrap = false}) {
  var listView = ListView.builder(
    physics: isiOS ? BouncingScrollPhysics() : ClampingScrollPhysics(),
    key: key,
    padding: padding,
    shrinkWrap: shrinkWrap,
    itemCount: itemCount,
    itemBuilder: itemBuilder,
  );
  return isiOS
      ? appleListWithScrollbar(itemCount: itemCount, listView: listView)
      : androidListWithScrollbar(itemCount: itemCount, listView: listView);
}

Widget androidListWithScrollbar({int itemCount, Widget listView}) => Scrollbar(
      child: listView,
    );

Widget appleListWithScrollbar({int itemCount, Widget listView}) =>
    CupertinoScrollbar(
      child: listView,
    );
