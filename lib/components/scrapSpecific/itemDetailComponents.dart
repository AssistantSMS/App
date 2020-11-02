import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../components/common/image.dart';
import '../../components/customPaint/ratingOval.dart';
import '../../components/webSpecific/mousePointer.dart';
import '../../constants/AppImage.dart';
import '../../constants/Routes.dart';
import '../../contracts/craftingIngredient/craftedUsing.dart';
import '../../contracts/gameItem/box.dart';
import '../../contracts/gameItem/cylinder.dart';
import '../../contracts/gameItem/feature.dart';
import '../../contracts/gameItem/gameItem.dart';
import '../../contracts/gameItem/upgrade.dart';
import '../../contracts/generated/LootChance.dart';
import '../../contracts/recipe/recipe.dart';
import '../../contracts/recipeIngredient/recipeIngredientDetail.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../contracts/usedInRecipe/usedInRecipe.dart';
import '../../helpers/colourHelper.dart';
import '../../helpers/deviceHelper.dart';
import '../../helpers/genericHelper.dart';
import '../../helpers/navigationHelper.dart';
import '../../helpers/textSpanHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/localesFromString.dart';
import '../../localization/translations.dart';
import '../../state/modules/cart/cartItemState.dart';
import '../../state/modules/gameItem/gameItemViewModel.dart';
import '../common/image.dart';
import '../dialogs/quantityDialog.dart';
import '../tilePresenters/cartTilePresenter.dart';
import '../tilePresenters/recipeIngredientTilePresenter.dart';
import '../tilePresenters/recipeTilePresenter.dart';

ResultWithValue<Widget> getRatingTableRows(
    BuildContext context, GameItem gameItem) {
  List<TableRow> rows = List<TableRow>();
  if (gameItem.rating == null) {
    return ResultWithValue<Table>(false, null, 'rating is null');
  }
  if (gameItem.rating.durability == null) {
    return ResultWithValue<Table>(false, null, 'rating is null');
  }

  var isDark = getIsDark(context);
  if (gameItem.rating.density != null) {
    rows.add(TableRow(children: [
      headingLocaleKeyWithImage(
          context, AppImage.weight(isDark), LocaleKey.density),
      rowValue(context, gameItem.rating.density)
    ]));
  }
  if (gameItem.rating.durability != null) {
    rows.add(TableRow(children: [
      headingLocaleKeyWithImage(
          context, AppImage.durability(isDark), LocaleKey.durability),
      rowValue(context, gameItem.rating.durability)
    ]));
  }
  if (gameItem.rating.friction != null) {
    rows.add(TableRow(children: [
      headingLocaleKeyWithImage(
          context, AppImage.friction(isDark), LocaleKey.friction),
      rowValue(context, gameItem.rating.friction)
    ]));
  }
  if (gameItem.rating.buoyancy != null) {
    rows.add(TableRow(children: [
      headingLocaleKeyWithImage(
          context, AppImage.buoyancy(isDark), LocaleKey.buoyancy),
      rowValue(context, gameItem.rating.buoyancy)
    ]));
  }
  if (gameItem.flammable != null) {
    rows.add(TableRow(children: [
      headingLocaleKeyWithImage(
          context, AppImage.flammable(isDark), LocaleKey.flammable),
      Text(
        Translations.get(
            context, gameItem.flammable ? LocaleKey.yes : LocaleKey.no),
        textAlign: TextAlign.center,
        style: TextStyle(color: getPrimaryColour(context), fontSize: 16),
      ),
    ]));
  }

  var child = Padding(
    padding: EdgeInsets.only(top: 8, left: 8, right: 8),
    child: Table(
      children: rows,
      // border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {0: FractionColumnWidth(.5), 1: FractionColumnWidth(.5)},
    ),
  );
  return ResultWithValue<Widget>(true, child, '');
}

Widget headingLocaleKeyWithImage(
        BuildContext context, String imagePath, LocaleKey key,
        {TextAlign textAlign}) =>
    Row(children: [
      Padding(
        padding: EdgeInsets.only(right: 4),
        child: localImage(
          imagePath,
          height: 16,
          // imageInvertColor: true, //getIsDark(context) == false,
        ),
      ),
      headingText(context, Translations.get(context, key),
          textAlign: textAlign),
    ]);

Widget headingLocaleKey(BuildContext context, LocaleKey key,
        {TextAlign textAlign}) =>
    headingText(context, Translations.get(context, key), textAlign: textAlign);

Widget headingText(BuildContext context, String text, {TextAlign textAlign}) =>
    Padding(
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
        textAlign: textAlign,
      ),
      padding: EdgeInsets.only(top: 2, bottom: 4),
    );

Widget rowValue(BuildContext context, int value) {
  return Center(
    child: StepProgressIndicator(
      size: 16,
      totalSteps: 10,
      currentStep: value,
      selectedColor: getPrimaryColour(context),
      unselectedColor: Colors.black,
      customStep: (index, color, size) {
        return ratingOval(index < value, getPrimaryColour(context));
      },
    ),
  );
}

Widget rowText(BuildContext context, String text) {
  return Padding(
    child: Text(text),
    padding: EdgeInsets.only(top: 2, bottom: 4),
  );
}

Widget rowInt(
    BuildContext context, int quantity, String suffix, String suffixPural) {
  return Padding(
    child: Text(quantity.toString() + (quantity == 1 ? suffix : suffixPural)),
    padding: EdgeInsets.only(top: 2, bottom: 4),
  );
}

Widget cubeDimensionGrid(BuildContext context, Box box) {
  String suffix = "";
  String suffixPural = "";
  return Padding(
    padding: EdgeInsets.only(top: 8, left: 8, right: 8),
    child: Table(
      children: [
        TableRow(children: [
          headingText(context, "X: ", textAlign: TextAlign.end),
          rowInt(context, box.x, suffix, suffixPural),
        ]),
        TableRow(children: [
          headingText(context, "Y: ", textAlign: TextAlign.end),
          rowInt(context, box.y, suffix, suffixPural),
        ]),
        TableRow(children: [
          headingText(context, "Z: ", textAlign: TextAlign.end),
          rowInt(context, box.z, suffix, suffixPural),
        ]),
        TableRow(children: [
          headingText(context, "Area: ", textAlign: TextAlign.end),
          rowInt(context, (box.x * box.y * box.z), suffix, suffixPural),
        ])
      ],
      // border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {0: FractionColumnWidth(.5), 1: FractionColumnWidth(.5)},
    ),
  );
}

Widget cubeDimension(BuildContext context, Box box) {
  var textStyleDim = TextStyle(
    fontSize: 20,
    color: getSecondaryColour(context),
  );
  return Stack(
    children: [
      Padding(
        child: localImage(AppImage.dimensionsCube),
        padding: EdgeInsets.all(24),
      ),
      Positioned(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(box.z.toString(), style: textStyleDim),
            Text(box.x.toString(), style: textStyleDim),
          ],
        ),
        left: 8,
        right: 8,
        bottom: 0,
      ),
      Positioned.fill(
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(box.y.toString(), style: textStyleDim),
        ),
      ),
    ],
  );
}

Widget cylinderDimension(BuildContext context, Cylinder cylinder) {
  var textStyleDim = TextStyle(
    fontSize: 20,
    color: getSecondaryColour(context),
  );
  return Stack(
    children: [
      Padding(
        child: localImage(AppImage.dimensionsCylinder),
        padding: EdgeInsets.all(24),
      ),
      Positioned(
        child: Text(
          cylinder.diameter.toString(),
          style: textStyleDim,
          textAlign: TextAlign.center,
        ),
        left: 8,
        right: 8,
        bottom: 0,
      ),
      Positioned.fill(
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(cylinder.depth.toString(), style: textStyleDim),
        ),
      ),
    ],
  );
}

Widget paddedCardWithMaxSize(Widget child,
    {double maxWidth = 450, EdgeInsetsGeometry padding}) {
  var container = Container(
    constraints: BoxConstraints(maxWidth: maxWidth),
    padding: EdgeInsets.all(10),
    child: child,
  );
  return (padding == null)
      ? Card(child: container)
      : Card(
          child: Padding(
            padding: padding,
            child: container,
          ),
        );
}

Widget itemDetailUpgradeWidget(
    Upgrade upgrade, Future Function(String) navigateToGameItem) {
  return GestureDetector(
    child: paddedCardWithMaxSize(
      Center(
        child: Padding(
          child: Stack(children: [
            localImage(AppImage.upgradeButton, height: 100),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    localImage(AppImage.componentKit, height: 20),
                    Container(width: 10),
                    Text(upgrade.cost.toString(),
                        style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            ),
          ]),
          padding: EdgeInsets.all(18),
        ),
      ),
    ),
    onTap: () => navigateToGameItem(upgrade.targetId),
  ).showPointerOnHover;
}

Widget itemDetailBoxWidget(BuildContext context, Box box) {
  return paddedCardWithMaxSize(
    Center(
      child: SizedBox(
        child: cubeDimension(context, box),
        height: 120,
      ),
    ),
    padding: EdgeInsets.only(bottom: 12),
  );
}

Widget itemDetailCylinderWidget(BuildContext context, Cylinder cylinder) {
  return paddedCardWithMaxSize(
    Center(
      child: SizedBox(
        child: cylinderDimension(context, cylinder),
        height: 120,
      ),
    ),
    padding: EdgeInsets.only(bottom: 12),
  );
}

Widget itemDetailLootChancesWidget(List<LootChance> lootChances) {
  const double chestIconSize = 40;
  List<Widget> rows = List<Widget>();
  for (var lootChance in lootChances) {
    var imagePath = lootChance.type == 0 ? AppImage.chest : AppImage.chestGold;
    var quantityString = "${lootChance.min} to ${lootChance.max}";
    if (lootChance.min == lootChance.max) {
      quantityString = "";
    }
    rows.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        localImage(imagePath, height: chestIconSize),
        Container(width: 10, height: chestIconSize),
        Text(
          "${lootChance.chance}% chance of dropping $quantityString",
        ),
      ],
    ));
  }
  return paddedCardWithMaxSize(
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: rows,
    ),
  );
}

Widget itemDetailFeaturesWidget(BuildContext context, List<Feature> features) {
  List<TableRow> rows = List<TableRow>();
  for (Feature feature in features) {
    LocaleKey locale =
        EnumToString.fromString(localesFromString, feature.localeKey);
    rows.add(TableRow(children: [
      Padding(
        child: Text(Translations.get(context, locale) + ": "),
        padding: EdgeInsets.all(4),
      ),
      Padding(child: Text(feature.value), padding: EdgeInsets.all(4)),
    ]));
  }
  return paddedCardWithMaxSize(Padding(
    child: Table(children: rows),
    padding: EdgeInsets.all(8),
  ));
}

List<Widget> itemCraftingRecipesWidget(
    BuildContext context,
    List<CraftedUsing> craftingRecipes,
    String title,
    Future Function(String) navigateToGameItem) {
  List<Widget> widgets = List<Widget>();
  for (CraftedUsing craftingRecipe in craftingRecipes) {
    var stationName = Translations.get(context, craftingRecipe.name);
    widgets.add(emptySpace1x());
    widgets.add(customDivider());
    widgets.add(emptySpace1x());
    var templateLocale = (craftingRecipe.name == LocaleKey.hideout)
        ? LocaleKey.getXByTradingY
        : LocaleKey.createXUsingY;
    widgets.add(getTextSpanFromTemplateAndArray(
      context,
      templateLocale,
      [title, stationName],
    ));
    for (var ingDetailsIndex = 0;
        ingDetailsIndex < craftingRecipe.ingredientDetails.length;
        ingDetailsIndex++) {
      RecipeIngredientDetails ingDetails =
          craftingRecipe.ingredientDetails[ingDetailsIndex];
      widgets.add(Card(
        child: recipeIngredientDetailCustomOnTapTilePresenter(
          context,
          ingDetails,
          ingDetailsIndex,
          onTap: () => navigateToGameItem(ingDetails.id),
        ),
      ));
    }
  }
  return widgets;
}

List<Widget> itemUsedInRecipesWidget(
    BuildContext context,
    List<UsedInRecipe> usedInRecipes,
    bool isInDetailPane,
    Future Function(String) navigateToRecipeItem) {
  List<Widget> widgets = List<Widget>();
  for (UsedInRecipe usedInRecipe in usedInRecipes) {
    widgets.add(emptySpace1x());
    widgets.add(customDivider());
    widgets.add(emptySpace1x());
    var name = Translations.get(context, usedInRecipe.name);
    widgets.add(getTextSpanFromTemplateAndArray(
        context, LocaleKey.usedInXToCreate, [name]));
    for (var recipeIndex = 0;
        recipeIndex < usedInRecipe.recipes.length;
        recipeIndex++) {
      Recipe recipe = usedInRecipe.recipes[recipeIndex];
      widgets.add(
        GestureDetector(
          child: Card(
            child: recipeTilePresenter(context, recipe, recipeIndex,
                showOutputQuantity: true),
          ),
          onTap: () => navigateToRecipeItem(recipe.id),
        ),
      );
    }
  }
  return widgets;
}

List<Widget> inCartWidget(
  BuildContext context,
  GameItem gameItem,
  List<CartItemState> cartItems,
  GameItemViewModel viewModel,
) {
  List<Widget> widgets = List<Widget>();
  if (cartItems == null || cartItems.length < 1) return widgets;

  widgets.add(emptySpace3x());
  widgets.add(genericItemText(Translations.get(context, LocaleKey.cart)));
  widgets.add(Card(
    child: cartTilePresenter(
      context,
      RecipeIngredientDetails(
        id: gameItem.id,
        icon: gameItem.icon,
        title: gameItem.title,
        quantity: cartItems[0].quantity,
      ),
      0,
      onTap: () async =>
          await navigateHomeAsync(context, navigateToNamed: Routes.cart),
      onEdit: () {
        var controller =
            TextEditingController(text: cartItems[0].quantity.toString());
        showQuantityDialog(context, controller, onSuccess: (quantity) {
          int intQuantity = int.tryParse(quantity);
          if (intQuantity == null) return;
          viewModel.editCartItem(gameItem.id, intQuantity);
        });
      },
      onDelete: () {
        viewModel.removeFromCart(gameItem.id);
      },
    ),
    margin: const EdgeInsets.all(0.0),
  ));
  return widgets;
}
