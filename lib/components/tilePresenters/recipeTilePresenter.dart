import 'package:flutter/material.dart';

import '../../contracts/recipe/recipe.dart';
import 'genericTilePresenter.dart';

Widget recipeTilePresenter(BuildContext context, Recipe recipe, int index,
    {bool showOutputQuantity = false}) {
  var outputQuantity = recipe?.output?.quantity ?? 0;
  String nameSuffix = '';
  if (showOutputQuantity && outputQuantity > 0) {
    nameSuffix = ' x$outputQuantity';
  }
  return genericListTile(
    context,
    leadingImage: recipe.icon,
    name: "${recipe.title} $nameSuffix",
  );
}

// genericListTileWithSubtitleAndImageCount(
//   context,
//   leadingImage: genericTileImage(recipe.icon, null),
//   title: recipe.title,
//   leadingImageCount: recipe?.output?.quantity ?? 0,
// );
