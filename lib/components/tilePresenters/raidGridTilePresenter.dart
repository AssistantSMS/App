import 'package:flutter/material.dart';

import '../../contracts/recipeIngredient/recipeIngredient.dart';
import '../../contracts/recipeIngredient/recipeIngredientDetail.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/colourHelper.dart';
import '../../helpers/futureHelper.dart';
import '../../helpers/snapshotHelper.dart';
import '../common/image.dart';

Widget raidGridTilePresenter(BuildContext context, String itemId,
    void Function(String itemId, int quantity) onEdit) {
  return FutureBuilder<ResultWithValue<RecipeIngredientDetails>>(
    future:
        getRecipeIngredientDetailsFuture(context, RecipeIngredient(id: itemId)),
    builder: (BuildContext context,
        AsyncSnapshot<ResultWithValue<RecipeIngredientDetails>> snapshot) {
      Widget errorWidget = asyncSnapshotHandler(context, snapshot);
      if (errorWidget != null) return errorWidget;
      return raidDetailGridTilePresenter(context, snapshot.data.value, onEdit);
    },
  );
}

Widget raidDetailGridTilePresenter(
    BuildContext context,
    RecipeIngredientDetails details,
    void Function(String itemId, int quantity) onEdit) {
  TextEditingController _controller = TextEditingController();
  return GestureDetector(
    child: Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          localImage('img/${details.icon}'),
          Padding(
            child: TextField(
              controller: _controller,
              cursorColor: getSecondaryColour(context),
              decoration: InputDecoration(hintText: details.title),
              textAlign: TextAlign.center,
              onChanged: (String text) {
                int intQuantity = int.tryParse(text);
                if (intQuantity == null) return;
                onEdit(details.id, intQuantity);
              },
            ),
            padding: EdgeInsets.all(8),
          ),
        ],
      ),
    ),
  );
}
