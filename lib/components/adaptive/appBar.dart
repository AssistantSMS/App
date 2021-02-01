import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget adaptiveAppBar(context, Widget title, List<Widget> actions,
    {Widget leading, PreferredSizeWidget bottom}) {
  return AppBar(
    leading: leading,
    title: title,
    centerTitle: true,
    actions: actions,
    bottom: bottom,
  );
}
