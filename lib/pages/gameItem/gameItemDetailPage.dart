import 'package:flutter/material.dart';

import '../../components/adaptive/listWithScrollbar.dart';
import '../../components/common/cachedFutureBuilder.dart';
import '../../components/loading.dart';
import '../../components/scaffoldTemplates/genericPageScaffold.dart';
import '../../components/tilePresenters/recipeIngredientTilePresenter.dart';
import '../../components/tilePresenters/recipeTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../constants/AppImage.dart';
import '../../constants/AppPadding.dart';
import '../../contracts/craftingIngredient/craftedUsing.dart';
import '../../contracts/gameItem/gameItemPageItem.dart';
import '../../contracts/recipe/recipe.dart';
import '../../contracts/recipeIngredient/recipeIngredientDetail.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../contracts/usedInRecipe/usedInRecipe.dart';
import '../../helpers/analytics.dart';
import '../../helpers/futureHelper.dart';
import '../../helpers/genericHelper.dart';
import '../../helpers/navigationHelper.dart';
import '../../helpers/snapshotHelper.dart';
import '../../helpers/textSpanHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import '../recipe/recipeDetailPage.dart';
import 'gameItemComponents.dart';

class GameItemDetailPage extends StatelessWidget {
  final String itemId;
  final bool isInDetailPane;

  GameItemDetailPage(this.itemId, {this.isInDetailPane = false}) {
    trackEvent('${AnalyticsEvent.itemDetailPage}: ${this.itemId}');
  }

  @override
  Widget build(BuildContext context) {
    String loading = Translations.get(context, LocaleKey.loading);
    var loadingWidget = fullPageLoading(context, loadingText: loading);
    return CachedFutureBuilder<ResultWithValue<GameItemPageItem>>(
      future: gameItemPageItemFuture(context, this.itemId),
      whileLoading: isInDetailPane
          ? loadingWidget
          : genericPageScaffold(context, loading, null,
              body: (_, __) => loadingWidget, showShortcutLinks: true),
      whenDoneLoading:
          (AsyncSnapshot<ResultWithValue<GameItemPageItem>> snapshot) {
        if (isInDetailPane) return getBody(context, snapshot);
        return genericPageScaffold<ResultWithValue<GameItemPageItem>>(
          context,
          snapshot?.data?.value?.gameItem?.title ?? loading,
          snapshot,
          body: getBody,
          showShortcutLinks: true,
        );
      },
    );
  }

  Widget getBody(BuildContext context,
      AsyncSnapshot<ResultWithValue<GameItemPageItem>> snapshot) {
    Widget errorWidget = asyncSnapshotHandler(context, snapshot);
    if (errorWidget != null) return errorWidget;

    var gameItem = snapshot?.data?.value?.gameItem;

    List<Widget> widgets = List<Widget>();

    widgets.add(genericItemImage(
      context,
      '${AppImage.base}${gameItem.icon}',
      name: gameItem.title,
    ));
    widgets.add(emptySpace1x());
    widgets.add(genericItemName(gameItem.title));

    widgets.add(emptySpace1x());
    widgets.add(Divider());

    ResultWithValue<Widget> tableResult = getTableRows(context, gameItem);
    if (tableResult.isSuccess) widgets.add(tableResult.value);

    widgets.add(Divider());

    List<CraftedUsing> craftingRecipes =
        snapshot?.data?.value?.craftingRecipes ?? [];

    for (CraftedUsing craftingRecipe in craftingRecipes) {
      var stationName = Translations.get(context, craftingRecipe.name);
      widgets.add(getTextSpanFromTemplateAndArray(
          context, LocaleKey.createXUsingY, [gameItem.title, stationName]));
      for (var ingDetailsIndex = 0;
          ingDetailsIndex < craftingRecipe.ingredientDetails.length;
          ingDetailsIndex++) {
        RecipeIngredientDetails ingDetails =
            craftingRecipe.ingredientDetails[ingDetailsIndex];
        widgets.add(Card(
          child: recipeIngredientDetailTilePresenter(
              context, ingDetails, ingDetailsIndex),
        ));
      }
      widgets.add(Divider());
    }

    widgets.add(Divider());

    List<UsedInRecipe> usedInRecipes =
        snapshot?.data?.value?.usedInRecipes ?? [];

    for (UsedInRecipe usedInRecipe in usedInRecipes) {
      var name = Translations.get(context, usedInRecipe.name);
      widgets.add(getTextSpanFromTemplateAndArray(
          context, LocaleKey.usedInXToCreate, [name]));
      for (var recipeIndex = 0;
          recipeIndex < usedInRecipe.recipes.length;
          recipeIndex++) {
        Recipe recipe = usedInRecipe.recipes[recipeIndex];
        widgets.add(GestureDetector(
          child: Card(child: recipeTilePresenter(context, recipe, recipeIndex)),
          onTap: () async => await navigateAwayFromHomeAsync(context,
              navigateTo: (context) => RecipeDetailPage(recipe.id)),
        ));
      }
      widgets.add(Divider());
    }

    widgets.add(emptySpace3x());

    return listWithScrollbar(
      padding: AppPadding.listSidePadding,
      itemCount: widgets.length,
      itemBuilder: (context, index) => widgets[index],
    );
  }
}
