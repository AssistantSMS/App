import 'package:flutter/material.dart';

import '../helpers/colourHelper.dart';

Widget starRating(context, int currentRating,
    {double size = 32, Function(int) onTap}) {
  if (onTap == null) onTap = (int _) => {};
  var colour = getSecondaryColour(context);
  return Wrap(
    // alignment: WrapAlignment.center,
    children: List.generate(
      5,
      (int index) => (index < currentRating)
          ? GestureDetector(
              child: Icon(Icons.star, color: colour, size: size),
              onTap: () => onTap(index + 1))
          : GestureDetector(
              child: Icon(Icons.star_border, color: colour, size: size),
              onTap: () => onTap(index + 1)),
    ),
  );
}
