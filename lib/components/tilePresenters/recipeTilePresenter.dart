import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/constants/AppPadding.dart';

import '../../contracts/recipe/recipe.dart';
import '../../helpers/navigationHelper.dart';
import '../../pages/recipe/recipeDetailPage.dart';
import 'genericTilePresenter.dart';

Widget recipeTilePresenter(BuildContext context, Recipe recipe, int index) {
  var tile = genericListTile(
    context,
    leadingImage: recipe.icon,
    name: recipe.title,
    onTap: () async => await navigateAwayFromHomeAsync(context,
        navigateTo: (context) => RecipeDetailPage(recipe.id)),
  );

  if (index != 0) return tile;

  return Padding(
    padding: AppPadding.listTopPadding,
    child: tile,
  );
}
