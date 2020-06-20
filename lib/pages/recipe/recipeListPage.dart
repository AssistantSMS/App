import 'package:flutter/material.dart';

import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../components/responsiveSearchableList.dart';
import '../../components/tilePresenters/recipeTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../contracts/recipe/recipe.dart';
import '../../helpers/analytics.dart';
import '../../helpers/futureHelper.dart';
import '../../helpers/navigationHelper.dart';
import '../../helpers/searchHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import 'recipeDetailPage.dart';

class RecipeListPage extends StatelessWidget {
  final LocaleKey name;
  final List<LocaleKey> recipeLocales;
  RecipeListPage(this.name, this.recipeLocales) {
    trackEvent(AnalyticsEvent.recipeListPage);
  }

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(
        context,
        title: Text(Translations.get(context, name)),
        showHomeAction: true,
      ),
      body: ResponsiveListDetailView<Recipe>(
        () => getAllRecipeFromLocaleKeys(context, recipeLocales),
        recipeTilePresenter,
        searchRecipe,
        listItemMobileOnTap: (BuildContext context, Recipe recipe) async =>
            await navigateAwayFromHomeAsync(context,
                navigateTo: (context) => RecipeDetailPage(recipe.id)),
        listItemDesktopOnTap: (BuildContext context, Recipe recipe,
                void Function(Widget) updateDetailView) =>
            RecipeDetailPage(
          recipe.id,
          isInDetailPane: true,
          updateDetailView: updateDetailView,
        ),
        key: Key(Translations.of(context).currentLanguage),
      ),
    );
  }
}
