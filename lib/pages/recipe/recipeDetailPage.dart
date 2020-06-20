import 'package:flutter/material.dart';

import '../../components/adaptive/listWithScrollbar.dart';
import '../../components/common/cachedFutureBuilder.dart';
import '../../components/loading.dart';
import '../../components/scaffoldTemplates/genericPageScaffold.dart';
import '../../components/tilePresenters/recipeIngredientTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../constants/AppImage.dart';
import '../../constants/AppPadding.dart';
import '../../contracts/recipe/recipePageItem.dart';
import '../../contracts/recipeIngredient/recipeIngredientDetail.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/analytics.dart';
import '../../helpers/futureHelper.dart';
import '../../helpers/genericHelper.dart';
import '../../helpers/navigationHelper.dart';
import '../../helpers/snapshotHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import '../gameItem/gameItemDetailPage.dart';

class RecipeDetailPage extends StatelessWidget {
  final String itemId;
  final bool isInDetailPane;
  final void Function(Widget newDetailView) updateDetailView;

  RecipeDetailPage(
    this.itemId, {
    this.isInDetailPane = false,
    this.updateDetailView,
  }) {
    trackEvent('${AnalyticsEvent.recipeDetailPage}: ${this.itemId}');
  }

  @override
  Widget build(BuildContext context) {
    String loading = Translations.get(context, LocaleKey.loading);
    var loadingWidget = fullPageLoading(context, loadingText: loading);
    return CachedFutureBuilder<ResultWithValue<RecipePageItem>>(
      future: recipePageItemFuture(context, this.itemId),
      whileLoading: isInDetailPane
          ? loadingWidget
          : genericPageScaffold(context, loading, null,
              body: (_, __) => loadingWidget, showShortcutLinks: true),
      whenDoneLoading:
          (AsyncSnapshot<ResultWithValue<RecipePageItem>> snapshot) {
        if (isInDetailPane) return getBody(context, snapshot);
        return genericPageScaffold<ResultWithValue<RecipePageItem>>(
          context,
          (snapshot?.data?.value?.recipe?.title ?? loading) + ' recipe',
          snapshot,
          body: getBody,
          showShortcutLinks: true,
        );
      },
    );
  }

  Widget getBody(BuildContext context,
      AsyncSnapshot<ResultWithValue<RecipePageItem>> snapshot) {
    Widget errorWidget = asyncSnapshotHandler(context, snapshot,
        isValidFunction: (ResultWithValue<RecipePageItem> itemResult) {
      if (!itemResult.isSuccess) return false;
      if (itemResult.value == null) return false;
      if (itemResult.value.recipe == null) return false;
      if (itemResult.value.recipe.icon == null) return false;

      return true;
    });
    if (errorWidget != null) return errorWidget;

    var recipeItem = snapshot?.data?.value?.recipe;

    List<Widget> widgets = List<Widget>();

    widgets.add(genericItemImage(
      context,
      '${AppImage.base}${recipeItem.icon}',
      name: recipeItem.title,
    ));
    widgets.add(emptySpace1x());
    var quantitySuffix = recipeItem?.output?.quantity?.toString() != null
        ? ' x${recipeItem.output.quantity}'
        : '';
    widgets.add(genericItemName(recipeItem.title + quantitySuffix));
    if (recipeItem.description != null && recipeItem.description.length > 0) {
      widgets.add(genericItemDescription(recipeItem.description));
    }

    var timeToCraft = Translations.get(context, LocaleKey.timeToCraft) +
        ' ' +
        recipeItem.craftingTime.toString() +
        's';
    widgets.add(genericItemDescription(timeToCraft));

    widgets.add(Divider());
    widgets.add(emptySpace1x());

    widgets.add(Text(
      Translations.get(context, LocaleKey.craftedUsing),
      textAlign: TextAlign.center,
    ));
    for (var recipeIngIndex = 0;
        recipeIngIndex < recipeItem.inputs.length;
        recipeIngIndex++) {
      RecipeIngredientDetails recipeIng =
          snapshot?.data?.value?.ingredientDetails[recipeIngIndex];
      widgets.add(Card(
        child: recipeIngredientDetailCustomOnTapTilePresenter(
          context,
          recipeIng,
          recipeIngIndex,
          onTap: () async {
            if (isInDetailPane && updateDetailView != null) {
              updateDetailView(GameItemDetailPage(
                recipeIng.id,
                isInDetailPane: isInDetailPane,
                updateDetailView: updateDetailView,
              ));
            } else {
              await navigateAwayFromHomeAsync(
                context,
                navigateTo: (context) => GameItemDetailPage(
                  recipeIng.id,
                  isInDetailPane: isInDetailPane,
                  updateDetailView: updateDetailView,
                ),
              );
            }
          },
        ),
      ));
    }

    widgets.add(emptySpace10x());

    return listWithScrollbar(
      padding: AppPadding.listSidePadding,
      itemCount: widgets.length,
      itemBuilder: (context, index) => widgets[index],
    );
  }
}
