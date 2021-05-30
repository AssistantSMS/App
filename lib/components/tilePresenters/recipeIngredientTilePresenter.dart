import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/recipeIngredient/recipeIngredient.dart';
import '../../contracts/recipeIngredient/recipeIngredientDetail.dart';
import '../../helpers/futureHelper.dart';
import '../../pages/gameItem/gameItemDetailPage.dart';

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
      onTap: (_) async => await getNavigation().navigateAwayFromHomeAsync(
          context,
          navigateTo: (context) => GameItemDetailPage(recipeIngredient.id)),
    );

Widget recipeIngredientDetailCustomOnTapTilePresenter(BuildContext context,
        RecipeIngredientDetails recipeIngredient, int index,
        {Function(String id) onTap}) =>
    genericListTile(
      context,
      leadingImage: recipeIngredient.icon,
      name: recipeIngredient.title,
      quantity: recipeIngredient.quantity,
      onTap: () => onTap(recipeIngredient.id),
    );

Widget packingRecipeTilePresenter(BuildContext context,
    RecipeIngredientDetails output, List<RecipeIngredientDetails> inputs,
    {Function() onTap}) {
  int startIndex = 0;
  String listTileTitle = '';
  for (var rowIndex = 0; rowIndex < inputs.length; rowIndex++) {
    listTileTitle += recipeIngredientDetailsInputsToString(
        rowIndex, startIndex, inputs[rowIndex]);
  }

  var subtitle = Text(
    listTileTitle,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );
  return genericListTileWithSubtitleAndImageCount(
    context,
    title: output.title,
    leadingImage: localImage(output.icon),
    leadingImageCount: (output.quantity > 1) ? output.quantity : 0,
    subtitle: subtitle,
    onTap: onTap,
  );
}

String recipeIngredientDetailsInputsToString(
        int rowIndex, int startIndex, RecipeIngredientDetails row) =>
    (rowIndex > startIndex ? ' + ' : '') +
    row.quantity.toString() +
    'x ' +
    row.title;
