import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/contracts/packing/packedUsing.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../components/customPaint/ratingOval.dart';
import '../../components/webSpecific/mousePointer.dart';
import '../../constants/AppImage.dart';
import '../../constants/ItemDetail.dart';
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
import '../../contracts/usedInRecipe/usedInRecipe.dart';
import '../../helpers/textSpanHelper.dart';
import '../../state/modules/cart/cartItemState.dart';
import '../../state/modules/gameItem/gameItemViewModel.dart';
import '../tilePresenters/cartTilePresenter.dart';
import '../tilePresenters/recipeIngredientTilePresenter.dart';
import '../tilePresenters/recipeTilePresenter.dart';

ResultWithValue<Widget> getRatingTableRows(
    BuildContext context, GameItem gameItem) {
  List<TableRow> rows = List.empty(growable: true);
  if (gameItem.rating == null) {
    return ResultWithValue<Table>(false, null, 'rating is null');
  }
  if (gameItem.rating.buoyancy == 0 &&
      gameItem.rating.density == 0 &&
      gameItem.rating.durability == 0 &&
      gameItem.rating.friction == 0) {
    return ResultWithValue<Table>(
        false, null, 'rating is not worth displaying');
  }

  bool isDark = getTheme().getIsDark(context);
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
      rowValue(context, gameItem.rating.buoyancy),
    ]));
  }
  if (gameItem.flammable != null) {
    rows.add(TableRow(children: [
      headingLocaleKeyWithImage(
          context, AppImage.flammable(isDark), LocaleKey.flammable),
      Text(
        getTranslations()
            .fromKey(gameItem.flammable ? LocaleKey.yes : LocaleKey.no),
        textAlign: TextAlign.center,
        style: TextStyle(
            color: getTheme().getPrimaryColour(context), fontSize: 16),
      ),
    ]));
  }
  if (gameItem.edible != null) {
    List<TableRow> edibles = List.empty(growable: true);
    if (gameItem.edible.hpGain != null && gameItem.edible.hpGain > 0) {
      edibles.add(TableRow(children: [
        headingLocaleKeyWithImage(
            context, AppImage.health(isDark), LocaleKey.health),
        Text(
          gameItem.edible.hpGain.toString() + '%',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: getTheme().getPrimaryColour(context), fontSize: 16),
        ),
      ]));
    }
    if (gameItem.edible.foodGain != null && gameItem.edible.foodGain > 0) {
      edibles.add(TableRow(children: [
        headingLocaleKeyWithImage(
            context, AppImage.food(isDark), LocaleKey.hunger),
        Text(
          gameItem.edible.foodGain.toString() + '%',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: getTheme().getPrimaryColour(context), fontSize: 16),
        ),
      ]));
    }
    if (gameItem.edible.waterGain != null && gameItem.edible.waterGain > 0) {
      edibles.add(TableRow(children: [
        headingLocaleKeyWithImage(
            context, AppImage.water(isDark), LocaleKey.thirst),
        Text(
          gameItem.edible.waterGain.toString() + '%',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: getTheme().getPrimaryColour(context), fontSize: 16),
        ),
      ]));
    }

    if (edibles.isNotEmpty) {
      rows.add(TableRow(children: [customDivider(), customDivider()]));
      rows.addAll(edibles);
    }
  }

  var child = Padding(
    padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
    child: Table(
      children: rows,
      // border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FractionColumnWidth(.5),
        1: FractionColumnWidth(.5)
      },
    ),
  );
  return ResultWithValue<Widget>(true, child, '');
}

Widget headingLocaleKeyWithImage(
        BuildContext context, String imagePath, LocaleKey key,
        {TextAlign textAlign}) =>
    Row(children: [
      Padding(
        padding: const EdgeInsets.only(right: 4),
        child: localImage(
          imagePath,
          height: 16,
          // imageInvertColor: true, //getIsDark(context) == false,
        ),
      ),
      headingText(context, getTranslations().fromKey(key),
          textAlign: textAlign),
    ]);

Widget headingLocaleKey(BuildContext context, LocaleKey key,
        {TextAlign textAlign}) =>
    headingText(context, getTranslations().fromKey(key), textAlign: textAlign);

Widget headingText(BuildContext context, String text, {TextAlign textAlign}) =>
    Padding(
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
        textAlign: textAlign,
      ),
      padding: const EdgeInsets.only(top: 2, bottom: 4),
    );

Widget rowValue(BuildContext context, int value) {
  return Center(
    child: StepProgressIndicator(
      size: 16,
      totalSteps: 10,
      currentStep: value,
      selectedColor: getTheme().getPrimaryColour(context),
      unselectedColor: Colors.black,
      customStep: (index, color, size) {
        return ratingOval(index < value, getTheme().getPrimaryColour(context));
      },
    ),
  );
}

Widget rowText(BuildContext context, String text) {
  return Padding(
    child: Text(text),
    padding: const EdgeInsets.only(top: 2, bottom: 4),
  );
}

Widget rowInt(
    BuildContext context, int quantity, String suffix, String suffixPural) {
  return Padding(
    child: Text(quantity.toString() + (quantity == 1 ? suffix : suffixPural)),
    padding: const EdgeInsets.only(top: 2, bottom: 4),
  );
}

Widget cubeDimensionGrid(BuildContext context, Box box) {
  String suffix = "";
  String suffixPural = "";
  return Padding(
    padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
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
      columnWidths: const {
        0: FractionColumnWidth(.5),
        1: FractionColumnWidth(.5)
      },
    ),
  );
}

Widget cubeDimension(BuildContext context, Box box) {
  var textStyleDim = TextStyle(
    fontSize: 20,
    color: getTheme().getSecondaryColour(context),
  );
  return Stack(
    children: [
      Padding(
        child: localImage(AppImage.dimensionsCube),
        padding: const EdgeInsets.all(24),
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
    color: getTheme().getSecondaryColour(context),
  );
  return Stack(
    children: [
      Padding(
        child: localImage(AppImage.dimensionsCylinder),
        padding: const EdgeInsets.all(24),
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
    padding: const EdgeInsets.all(10),
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
                    Text(
                      upgrade.cost.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ]),
          padding: const EdgeInsets.all(18),
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
    padding: const EdgeInsets.only(bottom: 12),
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
    padding: const EdgeInsets.only(bottom: 12),
  );
}

Widget itemDetailLootChancesWidget(List<LootChance> lootChances) {
  const double chestIconSize = 40;
  List<Widget> rows = List.empty(growable: true);
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
        const SizedBox(width: 10, height: chestIconSize),
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
  List<TableRow> rows = List.empty(growable: true);
  for (Feature feature in features) {
    LocaleKey locale =
        EnumToString.fromString(localesFromString, feature.localeKey);
    rows.add(TableRow(children: [
      Padding(
        child: Text(getTranslations().fromKey(locale) + ": "),
        padding: const EdgeInsets.all(4),
      ),
      Padding(child: Text(feature.value), padding: const EdgeInsets.all(4)),
    ]));
  }
  return paddedCardWithMaxSize(Padding(
    child: Table(children: rows),
    padding: const EdgeInsets.all(8),
  ));
}

List<Widget> itemCraftingRecipesWidget(
    BuildContext context,
    List<CraftedUsing> craftingRecipes,
    String title,
    Future Function(String) navigateToGameItem) {
  List<Widget> widgets = List.empty(growable: true);
  for (CraftedUsing craftingRecipe in craftingRecipes) {
    var stationName = getTranslations().fromKey(craftingRecipe.name);
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
          onTap: (_) => navigateToGameItem(ingDetails.id),
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
  List<Widget> widgets = List.empty(growable: true);
  for (UsedInRecipe usedInRecipe in usedInRecipes) {
    widgets.add(emptySpace1x());
    widgets.add(customDivider());
    widgets.add(emptySpace1x());
    var name = getTranslations().fromKey(usedInRecipe.name);
    widgets.add(getTextSpanFromTemplateAndArray(
        context, LocaleKey.usedInXToCreate, [name]));
    for (var recipeIndex = 0;
        recipeIndex < usedInRecipe.recipes.length;
        recipeIndex++) {
      Recipe recipe = usedInRecipe.recipes[recipeIndex];
      widgets.add(
        GestureDetector(
          child: Card(
            child: recipeTileWithIngDetailsPresenter(
                context, recipe, recipeIndex,
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
  List<Widget> widgets = List.empty(growable: true);
  if (cartItems == null || cartItems.isEmpty) return widgets;

  widgets.add(emptySpace3x());
  widgets.add(genericItemText(getTranslations().fromKey(LocaleKey.cart)));
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
      onTap: () async => await getNavigation()
          .navigateHomeAsync(context, navigateToNamed: Routes.cart),
      onEdit: () {
        var controller =
            TextEditingController(text: cartItems[0].quantity.toString());
        getDialog().showQuantityDialog(
          context,
          controller,
          onSuccess: (BuildContext dialogCtx, String quantity) {
            int intQuantity = int.tryParse(quantity);
            if (intQuantity == null) return;
            viewModel.editCartItem(gameItem.id, intQuantity);
          },
        );
      },
      onDelete: () {
        viewModel.removeFromCart(gameItem.id);
      },
    ),
    margin: const EdgeInsets.all(0.0),
  ));
  return widgets;
}

List<Widget> itemUsedInPackingRecipesWidget(
    BuildContext context,
    LocaleKey template,
    List<PackedUsing> packingRecipes,
    Future Function(String) navigateToGameItem) {
  List<Widget> widgets = List.empty(growable: true);
  for (PackedUsing packingRecipe in packingRecipes) {
    RecipeIngredientDetails ingDetails = packingRecipe.outputDetails;
    var title = ingDetails.title;
    var stationName = getTranslations().fromKey(LocaleKey.packingStation);
    widgets.add(emptySpace1x());
    widgets.add(customDivider());
    widgets.add(emptySpace1x());
    widgets.add(getTextSpanFromTemplateAndArray(
      context,
      template,
      [title, stationName],
    ));

    widgets.add(Card(
      child: packingRecipeTilePresenter(
        context,
        ingDetails,
        packingRecipe.ingredientDetails,
        onTap: () => navigateToGameItem(ingDetails.id),
      ),
    ));
  }
  return widgets;
}
