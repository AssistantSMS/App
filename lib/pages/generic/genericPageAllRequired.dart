import 'package:flutter/material.dart';

import '../../components/adaptive/listWithScrollbar.dart';
import '../../components/adaptive/segmentedControl.dart';
import '../../components/scaffoldTemplates/genericPageScaffold.dart';
import '../../components/tilePresenters/recipeIngredientTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../constants/AppPadding.dart';
import '../../contracts/recipeIngredient/recipeIngredient.dart';
import '../../contracts/recipeIngredient/recipeIngredientDetail.dart';
import '../../contracts/recipeIngredient/recipeIngredientTreeDetails.dart';
import '../../helpers/analytics.dart';
import '../../helpers/futureHelper.dart';
import '../../helpers/genericHelper.dart';
import '../../helpers/itemsHelper.dart';
import '../../helpers/snapshotHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import 'genericPageAllRequiredTreeComponents.dart';

class GenericAllRequiredPage extends StatefulWidget {
  final List<RecipeIngredient> requiredItems;
  GenericAllRequiredPage(this.requiredItems);

  @override
  _GenericAllRequiredWidget createState() =>
      _GenericAllRequiredWidget(this.requiredItems);
}

class _GenericAllRequiredWidget extends State<GenericAllRequiredPage> {
  final List<RecipeIngredient> requiredItems;
  int currentSelection = 0;

  _GenericAllRequiredWidget(this.requiredItems) {
    trackEvent(AnalyticsEvent.genericAllRequiredPage);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> options = [
      getSegmentedControlWithIconOption(
        Icons.list,
        Translations.get(context, LocaleKey.cart),
      ),
      getSegmentedControlWithIconOption(
        Icons.call_split,
        Translations.get(context, LocaleKey.tradedFor),
      )
    ];
    var segmentedWidget = Container(
      child: adaptiveSegmentedControl(context,
          controlItems: options,
          currentSelection: currentSelection, onSegmentChosen: (index) {
        setState(() {
          currentSelection = index;
        });
      }),
      margin: EdgeInsets.all(8),
    );

    if (currentSelection == 0) {
      return FutureBuilder<List<RecipeIngredientDetails>>(
          future: getAllRequiredItemsForMultiple(context, requiredItems),
          builder: (BuildContext context,
              AsyncSnapshot<List<RecipeIngredientDetails>> snapshot) {
            return genericPageScaffold<List<RecipeIngredientDetails>>(
              context,
              Translations.get(context, LocaleKey.viewAllRequiredItems),
              snapshot,
              body: (BuildContext innerContext,
                      AsyncSnapshot<List<RecipeIngredientDetails>>
                          asyncSnapshot) =>
                  getFlatListBody(context, asyncSnapshot, segmentedWidget),
            );
          });
    } else {
      return FutureBuilder<List<RecipeIngredientTreeDetails>>(
        future: getAllRequiredItemsForTree(context, requiredItems),
        builder: (BuildContext context,
            AsyncSnapshot<List<RecipeIngredientTreeDetails>> snapshot) {
          return genericPageScaffold<List<RecipeIngredientTreeDetails>>(
            context,
            Translations.get(context, LocaleKey.viewAllRequiredItems),
            snapshot,
            body: (BuildContext innerContext,
                    AsyncSnapshot<List<RecipeIngredientTreeDetails>>
                        snapshot) =>
                getTreeBody(innerContext, snapshot, segmentedWidget),
          );
        },
      );
    }
  }

  Widget getFlatListBody(
      BuildContext context,
      AsyncSnapshot<List<RecipeIngredientDetails>> snapshot,
      Widget segmentedWidget) {
    Widget errorWidget = asyncSnapshotHandler(context, snapshot);
    if (errorWidget != null) return errorWidget;

    List<Widget> widgets = List<Widget>();
    widgets.add(segmentedWidget);
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

Widget getTreeBody(
    BuildContext context,
    AsyncSnapshot<List<RecipeIngredientTreeDetails>> snapshot,
    Widget segmentedWidget) {
  Widget errorWidget = asyncSnapshotHandler(context, snapshot);
  if (errorWidget != null) return errorWidget;

  List<Widget> widgets = List<Widget>();
  widgets.add(segmentedWidget);

  if (snapshot.data.length > 0) {
    widgets.add(Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
          getTree(context, snapshot.data),
        ],
      ),
    ));
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

  return Column(
    children: widgets,
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.stretch,
  );
}
