import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/recipe/recipe.dart';
import '../../contracts/recipeIngredient/recipeIngredientDetail.dart';
import '../../helpers/futureHelper.dart';
import '../loading.dart';

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

Widget recipeTileWithIngDetailsPresenter(
    BuildContext context, Recipe recipe, int index,
    {bool showOutputQuantity = false}) {
  var outputQuantity = recipe?.output?.quantity ?? 0;
  String nameSuffix = '';
  if (showOutputQuantity && outputQuantity > 0) {
    nameSuffix = ' x$outputQuantity';
  }

  return FutureBuilder<ResultWithValue<List<RecipeIngredientDetails>>>(
      future: recipeIngredientDetailsFuture(context, recipe.inputs),
      builder: (BuildContext context,
          AsyncSnapshot<ResultWithValue<List<RecipeIngredientDetails>>>
              snapshot) {
        var subtitle = smallLoadingIndicator();
        if (snapshot.connectionState == ConnectionState.none ||
            (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasError) ||
            (snapshot.hasData && snapshot.data.hasFailed)) {
          subtitle = Text('Error');
        }
        if (snapshot.hasData) {
          String listTileTitle = '';
          if (recipe.inputs.length > 0) {
            var rows = snapshot.data.value;
            rows.sort((RecipeIngredientDetails a, RecipeIngredientDetails b) =>
                (b.id == recipe.output.id) ? 1 : -1);
            int startIndex = 0;
            for (var rowIndex = 0; rowIndex < rows.length; rowIndex++) {
              listTileTitle +=
                  recipeInputsToString(rowIndex, startIndex, rows[rowIndex]);
            }
          }

          subtitle = Text(
            listTileTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        }

        return genericListTileWithSubtitle(
          context,
          leadingImage: recipe.icon,
          name: "${recipe.title} $nameSuffix",
          subtitle: subtitle,
        );
      });
}

// genericListTileWithSubtitleAndImageCount(
//   context,
//   leadingImage: genericTileImage(recipe.icon, null),
//   title: recipe.title,
//   leadingImageCount: recipe?.output?.quantity ?? 0,
// );

String recipeInputsToString(
        int rowIndex, int startIndex, RecipeIngredientDetails row) =>
    (rowIndex > startIndex ? ' + ' : '') +
    row.quantity.toString() +
    'x ' +
    row.title;
