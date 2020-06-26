import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrapmechanic_kurtlourens_com/constants/AppImage.dart';
import 'package:scrapmechanic_kurtlourens_com/contracts/raid/raidSpawn.dart';

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
      child: Column(
        children: [
          localImage('img/${details.icon}'),
          Padding(
            child: TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              cursorColor: getSecondaryColour(context),
              decoration: InputDecoration(hintText: details.title),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              onChanged: (String text) {
                int intQuantity = int.tryParse(text);
                if (intQuantity == null) intQuantity = 0;
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

Widget raidAttackerTilePresenter(BuildContext context, RaidSpawn spawn) {
  List<Widget> rowWidgets = List<Widget>();
  if (spawn.totebot > 0) {
    rowWidgets.add(
      Row(children: [
        getRaidAttackerImg(AppImage.totebot),
        getRaidAttackerCount(spawn.totebot),
      ], mainAxisSize: MainAxisSize.min),
    );
  }
  if (spawn.haybot > 0) {
    rowWidgets.add(
      Row(children: [
        getRaidAttackerImg(AppImage.haybot),
        getRaidAttackerCount(spawn.haybot),
      ], mainAxisSize: MainAxisSize.min),
    );
  }
  if (spawn.tapebot > 0) {
    rowWidgets.add(
      Row(children: [
        getRaidAttackerImg(AppImage.tapebot),
        getRaidAttackerCount(spawn.tapebot),
      ], mainAxisSize: MainAxisSize.min),
    );
  }
  if (spawn.farmbot > 0) {
    rowWidgets.add(
      Row(children: [
        getRaidAttackerImg(AppImage.farmbot),
        getRaidAttackerCount(spawn.farmbot),
      ], mainAxisSize: MainAxisSize.min),
    );
  }
  return Card(
    child: Wrap(
      children: rowWidgets,
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      spacing: 32,
    ),
  );
}

Widget getRaidAttackerImg(String path) => localImage(path, height: 100);
Widget getRaidAttackerCount(int quantity) => Center(
      child: Text(
        ' x$quantity',
        style: TextStyle(fontSize: 24),
      ),
    );
