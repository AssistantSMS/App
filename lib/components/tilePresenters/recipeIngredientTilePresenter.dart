import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/recipeIngredient/recipeIngredient.dart';
import '../../contracts/recipeIngredient/recipeIngredientDetail.dart';
import '../../helpers/futureHelper.dart';
import '../../pages/gameItem/gameItemDetailPage.dart';
import 'genericTilePresenter.dart';

Widget recipeIngredientTilePresenter(
    BuildContext context, RecipeIngredient recipeIngredient, int index) {
  return FutureBuilder<ResultWithValue<RecipeIngredientDetails>>(
    future: getRecipeIngredientDetailsFuture(context, recipeIngredient),
    builder: (BuildContext context,
        AsyncSnapshot<ResultWithValue<RecipeIngredientDetails>> snapshot) {
      Widget errorWidget = asyncSnapshotHandler(context, snapshot);
      if (errorWidget != null) return errorWidget;
      return recipeIngredientDetailTilePresenter(
          context, snapshot.data.value, index);
    },
  );
}

Widget recipeIngredientDetailTilePresenter(BuildContext context,
        RecipeIngredientDetails recipeIngredient, int index) =>
    recipeIngredientDetailCustomOnTapTilePresenter(
      context,
      recipeIngredient,
      index,
      onTap: () async => await getNavigation().navigateAwayFromHomeAsync(
          context,
          navigateTo: (context) => GameItemDetailPage(recipeIngredient.id)),
    );

Widget recipeIngredientDetailCustomOnTapTilePresenter(BuildContext context,
        RecipeIngredientDetails recipeIngredient, int index,
        {Function() onTap}) =>
    genericListTile(
      context,
      leadingImage: recipeIngredient.icon,
      name: recipeIngredient.title,
      quantity: recipeIngredient.quantity,
      onTap: onTap,
    );
