import 'package:flutter/material.dart';

class IconWithValueRow extends StatelessWidget {
  final IconData icon;
  final int value;

  const IconWithValueRow(
    this.icon,
    this.value, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(value.toString()),
        )
      ],
    );
  }
}
