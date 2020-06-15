import 'package:flutter/material.dart';

import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../components/searchableList.dart';
import '../../components/tilePresenters/recipeTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../contracts/recipe/recipe.dart';
import '../../helpers/analytics.dart';
import '../../helpers/futureHelper.dart';
import '../../helpers/searchHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';

class RecipeListPage extends StatelessWidget {
  final LocaleKey name;
  final List<LocaleKey> recipeLocales;
  RecipeListPage(this.name, this.recipeLocales) {
    trackEvent(AnalyticsEvent.recipeListPage);
  }

  @override
  Widget build(BuildContext context) {
    var hintText = Translations.get(context, LocaleKey.searchItems);
    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(
        context,
        title: Text(Translations.get(context, name)),
      ),
      body: SearchableList<Recipe>(
        () => getAllRecipeFromLocaleKeys(context, recipeLocales),
        recipeTilePresenter,
        searchRecipe,
        key: Key(Translations.of(context).currentLanguage),
        hintText: hintText,
      ),
    );
  }
}
