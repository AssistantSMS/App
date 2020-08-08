import 'package:flutter/material.dart';

Widget iconWithValueRow(IconData icon, int value) {
  return Row(
    children: [
      Icon(icon),
      Padding(
        padding: EdgeInsets.only(left: 4),
        child: Text(value.toString()),
      )
    ],
  );
}
