import 'package:flutter/material.dart';

import '../../components/adaptive/listWithScrollbar.dart';
import '../../components/scaffoldTemplates/genericPageScaffold.dart';
import '../../components/tilePresenters/recipeIngredientTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../constants/AppPadding.dart';
import '../../contracts/recipeIngredient/recipeIngredient.dart';
import '../../contracts/recipeIngredient/recipeIngredientDetail.dart';
import '../../helpers/analytics.dart';
import '../../helpers/futureHelper.dart';
import '../../helpers/genericHelper.dart';
import '../../helpers/snapshotHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';

class GenericAllRequiredPage extends StatelessWidget {
  final List<RecipeIngredient> requiredItems;

  GenericAllRequiredPage(this.requiredItems) {
    trackEvent(AnalyticsEvent.genericAllRequiredPage);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RecipeIngredientDetails>>(
        future: getAllRequiredItemsForMultiple(context, requiredItems),
        builder: (BuildContext context,
            AsyncSnapshot<List<RecipeIngredientDetails>> snapshot) {
          return genericPageScaffold<List<RecipeIngredientDetails>>(
            context,
            Translations.get(context, LocaleKey.viewAllRequiredItems),
            snapshot,
            body: getBody,
          );
        });
  }

  Widget getBody(BuildContext context,
      AsyncSnapshot<List<RecipeIngredientDetails>> snapshot) {
    Widget errorWidget = asyncSnapshotHandler(context, snapshot);
    if (errorWidget != null) return errorWidget;

    List<Widget> widgets = List<Widget>();
    if (snapshot.data.length > 0) {
      for (var ingDetailIndex = 0;
          ingDetailIndex < snapshot.data.length;
          ingDetailIndex++) {
        var indDetails = snapshot.data[ingDetailIndex];
        widgets.add(recipeIngredientDetailTilePresenter(
            context, indDetails, ingDetailIndex));
      }
    } else {
      widgets.add(
        Container(
          child: Text(
            Translations.get(context, LocaleKey.noItems),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 20),
          ),
          margin: EdgeInsets.only(top: 30),
        ),
      );
    }

    widgets.add(emptySpace8x());

    return listWithScrollbar(
      padding: AppPadding.listSidePadding,
      itemCount: widgets.length,
      itemBuilder: (context, index) => widgets[index],
    );
  }
}
