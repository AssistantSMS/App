import 'package:flutter/material.dart';

class ActionItem {
  final IconData icon;
  final Widget image;
  final String text;
  final Function onPressed;

  ActionItem(
      {@required this.icon, @required this.onPressed, this.image, this.text});
}
