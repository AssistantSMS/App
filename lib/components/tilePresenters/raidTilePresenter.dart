import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/AppImage.dart';
import '../../contracts/raid/raidSpawn.dart';
import '../../contracts/recipeIngredient/recipeIngredient.dart';
import '../../contracts/recipeIngredient/recipeIngredientDetail.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../contracts/search/dropdownOption.dart';
import '../../helpers/colourHelper.dart';
import '../../helpers/futureHelper.dart';
import '../../helpers/navigationHelper.dart';
import '../../helpers/popupMenuButtonHelper.dart';
import '../../helpers/raidHelper.dart';
import '../../helpers/snapshotHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import '../../pages/dialog/optionsListPageDialog.dart';
import '../../state/modules/raid/raidViewModel.dart';
import '../common/image.dart';
import '../dialogs/quantityDialog.dart';
import '../loading.dart';
import 'genericTilePresenter.dart';

Widget raidGridTilePresenter(BuildContext context, String itemId, int quantity,
    void Function(String itemId, int quantity) onEdit) {
  return FutureBuilder<ResultWithValue<RecipeIngredientDetails>>(
    future: getRecipeIngredientDetailsFuture(
        context, RecipeIngredient(id: itemId, quantity: quantity)),
    builder: (BuildContext context,
        AsyncSnapshot<ResultWithValue<RecipeIngredientDetails>> snapshot) {
      Widget errorWidget = asyncSnapshotHandler(context, snapshot);
      if (errorWidget != null) return errorWidget;
      return raidDetailGridTilePresenter(context, snapshot.data.value, onEdit);
    },
  );
}

Widget raidTilePresenter(
  BuildContext context,
  String itemId,
  RaidViewModel currentDetails, {
  void Function(String itemId, int quantity) onEdit,
  void Function(String itemId) onDelete,
}) {
  return FutureBuilder<ResultWithValue<RecipeIngredientDetails>>(
    future:
        getRecipeIngredientDetailsFuture(context, RecipeIngredient(id: itemId)),
    builder: (BuildContext context,
        AsyncSnapshot<ResultWithValue<RecipeIngredientDetails>> snapshot) {
      Widget errorWidget = asyncSnapshotHandler(context, snapshot);
      if (errorWidget != null) return errorWidget;

      RecipeIngredientDetails plantDetail = snapshot.data.value;
      int plantQuantity = RaidHelper.getPlantQuantity(currentDetails, itemId);

      var localOnEdit = () =>
          showQuantityDialog(context, TextEditingController(),
              onSuccess: (String quantityString) {
            int quantity = int.tryParse(quantityString);
            if (quantity == null) return;
            if (onEdit == null) return;
            onEdit(plantDetail.id, quantity);
          });

      return raidPlantDetailTilePresenter(
        context,
        plantDetail,
        plantQuantity,
        onTap: localOnEdit,
        onEdit: localOnEdit,
        onDelete: () => onDelete(plantDetail.id),
      );
    },
  );
}

Widget raidPlantDetailTilePresenter(
  BuildContext context,
  RecipeIngredientDetails plantDetail,
  int plantQuantity, {
  void Function() onTap,
  void Function() onEdit,
  void Function() onDelete,
}) {
  return genericListTile(
    context,
    leadingImage: plantDetail.icon,
    name: plantDetail.title,
    quantity: plantQuantity,
    onTap: onTap,
    trailing: popupMenu(context, onEdit: onEdit, onDelete: onDelete),
  );
}

Widget raidAddPlantTilePresenter(
    BuildContext context,
    RaidViewModel currentDetails,
    void Function(String itemId, int quantity) onEdit) {
  var currentPlants = RaidHelper.getPlantsWithQuantity(currentDetails);

  List<RecipeIngredient> inputs = List<RecipeIngredient>();
  for (var plantId in RaidHelper.plants) {
    if (currentPlants.contains(plantId)) continue;
    inputs.add(RecipeIngredient(id: plantId, quantity: 0));
  }
  return FutureBuilder<ResultWithValue<List<RecipeIngredientDetails>>>(
    future: recipeIngredientDetailsFuture(context, inputs),
    builder: (BuildContext context,
        AsyncSnapshot<ResultWithValue<List<RecipeIngredientDetails>>>
            snapshot) {
      Widget errorWidget = asyncSnapshotHandler(
        context,
        snapshot,
        loader: () => listTileLoading(context),
      );
      if (errorWidget != null) return errorWidget;
      return _raidAddPlantTileContent(context, snapshot.data.value, onEdit);
    },
  );
}

Widget _raidAddPlantTileContent(
    BuildContext context,
    List<RecipeIngredientDetails> platsWithDetails,
    void Function(String itemId, int quantity) onEdit) {
  List<DropdownOption> options = List<DropdownOption>();
  for (var plantDetails in platsWithDetails) {
    options.add(DropdownOption(plantDetails.title, value: plantDetails.id));
  }
  return ListTile(
    leading: SizedBox(
      width: 55,
      height: 55,
      child: Padding(
        padding: EdgeInsets.all(4),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(12),
          padding: EdgeInsets.all(6),
          dashPattern: [8, 4],
          color: getSecondaryColour(context),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Center(
              child: Icon(Icons.add),
            ),
          ),
        ),
      ),
    ),
    title: Text(Translations.get(context, LocaleKey.addPlantPlot)),
    onTap: () async {
      String tempPlantId = await navigateAsync(
        context,
        navigateTo: (context) => OptionsListPageDialog(
          Translations.get(context, LocaleKey.raidCalculator),
          options,
          customPresenter:
              (BuildContext innerC, DropdownOption dropOpt, int index) {
            RecipeIngredientDetails currentPlantDetails =
                RecipeIngredientDetails();
            for (RecipeIngredientDetails plantDetails in platsWithDetails) {
              if (plantDetails.id == dropOpt.value) {
                currentPlantDetails = plantDetails;
              }
            }
            return raidPlantDetailTilePresenter(
              innerC,
              currentPlantDetails,
              0,
              onTap: () => Navigator.of(context).pop(currentPlantDetails.id),
            );
          },
        ),
      );
      if (tempPlantId == null || tempPlantId.length <= 0) return;
      showQuantityDialog(context, TextEditingController(),
          onSuccess: (String quantityString) {
        int quantity = int.tryParse(quantityString);
        if (quantity == null) return;
        if (onEdit == null) return;
        onEdit(tempPlantId, quantity);
      });
    },
  );
}

Widget raidDetailGridTilePresenter(
    BuildContext context,
    RecipeIngredientDetails details,
    void Function(String itemId, int quantity) onEdit) {
  TextEditingController _controller = TextEditingController();
  _controller.text = details.quantity.toString();
  return GestureDetector(
    child: Card(
      child: Column(
        children: [
          localImage('${AppImage.base}${details.icon}'),
          Padding(
            child: TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              cursorColor: getSecondaryColour(context),
              decoration: InputDecoration(
                hintText: "# of ${details.title} plots",
              ),
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

Widget raidAttackerTilePresenter(
    BuildContext context, RaidSpawn spawn, bool isMobileView) {
  List<Widget> rowWidgets = List<Widget>();
  if (spawn.totebot > 0) {
    rowWidgets.add(
      Row(children: [
        getRaidAttackerImg(AppImage.totebot, isMobileView),
        getRaidAttackerCount(spawn.totebot),
      ], mainAxisSize: MainAxisSize.min),
    );
  }
  if (spawn.haybot > 0) {
    rowWidgets.add(
      Row(children: [
        getRaidAttackerImg(AppImage.haybot, isMobileView),
        getRaidAttackerCount(spawn.haybot),
      ], mainAxisSize: MainAxisSize.min),
    );
  }
  if (spawn.tapebot > 0) {
    rowWidgets.add(
      Row(children: [
        getRaidAttackerImg(AppImage.tapebot, isMobileView),
        getRaidAttackerCount(spawn.tapebot),
      ], mainAxisSize: MainAxisSize.min),
    );
  }
  if (spawn.farmbot > 0) {
    rowWidgets.add(
      Row(children: [
        getRaidAttackerImg(AppImage.farmbot, isMobileView),
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

Widget getRaidAttackerImg(String path, bool isMobileView) => localImage(
      path,
      height: isMobileView ? 75 : 100,
    );
Widget getRaidAttackerCount(int quantity) => Center(
      child: Text(
        ' x$quantity',
        style: TextStyle(fontSize: 24),
      ),
    );
