import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../components/bottomNavbar.dart';
import '../../components/tilePresenters/recipeTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../constants/Routes.dart';
import '../../contracts/recipe/recipe.dart';
import '../../helpers/futureHelper.dart';
import '../../helpers/searchHelper.dart';
import 'recipeDetailPage.dart';

class RecipeListPage extends StatelessWidget {
  final LocaleKey name;
  final List<LocaleKey> recipeLocales;
  RecipeListPage(this.name, this.recipeLocales, {Key key}) : super(key: key) {
    getAnalytics().trackEvent(AnalyticsEvent.recipeListPage);
  }

  @override
  Widget build(BuildContext context) {
    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        title: Text(getTranslations().fromKey(name)),
        showHomeAction: true,
      ),
      body: ResponsiveListDetailView<Recipe>(
        () => getAllRecipeFromLocaleKeys(context, recipeLocales),
        recipeTilePresenter,
        searchRecipe,
        listItemMobileOnTap: (BuildContext context, Recipe recipe) =>
            getNavigation().navigateAwayFromHomeAsync(
          context,
          navigateToNamed: Routes.recipeDetail,
          navigateToNamedParameters: {Routes.itemIdParam: recipe.id},
        ),
        listItemDesktopOnTap: (BuildContext context, Recipe recipe,
            void Function(Widget) updateDetailView) {
          return RecipeDetailPage(
            recipe.id,
            isInDetailPane: true,
            updateDetailView: updateDetailView,
          );
        },
        key: Key(getTranslations().currentLanguage),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
