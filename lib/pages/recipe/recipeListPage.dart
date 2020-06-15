import 'package:flutter/material.dart';

import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../components/searchableList.dart';
import '../../components/tilePresenters/recipeTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../contracts/recipe/recipe.dart';
import '../../helpers/analytics.dart';
import '../../helpers/futureHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';

class RecipeListPage extends StatelessWidget {
  final List<LocaleKey> recipeLocales;
  RecipeListPage(this.recipeLocales) {
    trackEvent(AnalyticsEvent.recipeListPage);
  }

  @override
  Widget build(BuildContext context) {
    var hintText = Translations.get(context, LocaleKey.searchItems);
    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(
        context,
        title: Text('testing'),
      ),
      body: SearchableList<Recipe>(
        () => getAllFromLocaleKeys(context, recipeLocales),
        recipeTilePresenter,
        (Recipe recipe, String search) => false,
        key: Key(Translations.of(context).currentLanguage),
        hintText: hintText,
      ),
    );
  }
}
