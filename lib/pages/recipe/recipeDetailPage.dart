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
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/analytics.dart';
import '../../helpers/futureHelper.dart';
import '../../helpers/genericHelper.dart';
import '../../helpers/snapshotHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';

class RecipeDetailPage extends StatelessWidget {
  final String itemId;
  final bool isInDetailPane;

  RecipeDetailPage(this.itemId, {this.isInDetailPane = false}) {
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
          snapshot?.data?.value?.recipe?.title ?? loading,
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
    widgets.add(genericItemName(recipeItem.title));
    if (recipeItem.description != null && recipeItem.description.length > 0) {
      widgets.add(genericItemDescription(recipeItem.description));
    }

    widgets.add(Divider());

    for (var recipeIngIndex = 0;
        recipeIngIndex < recipeItem.inputs.length;
        recipeIngIndex++) {
      var recipeIng = recipeItem.inputs[recipeIngIndex];
      widgets.add(
        recipeIngredientTilePresenter(context, recipeIng, recipeIngIndex),
      );
    }

    widgets.add(emptySpace3x());

    return listWithScrollbar(
      padding: AppPadding.listSidePadding,
      itemCount: widgets.length,
      itemBuilder: (context, index) => widgets[index],
    );
  }
}
