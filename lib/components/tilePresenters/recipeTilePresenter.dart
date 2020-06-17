import 'package:flutter/material.dart';

import '../../constants/AppPadding.dart';
import '../../contracts/recipe/recipe.dart';
import 'genericTilePresenter.dart';

Widget recipeTilePresenter(BuildContext context, Recipe recipe, int index) {
  var tile = genericListTile(
    context,
    leadingImage: recipe.icon,
    name: recipe.title,
  );

  if (index != 0) return tile;

  return Padding(
    padding: AppPadding.listTopPadding,
    child: tile,
  );
}
