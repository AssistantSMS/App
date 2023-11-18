// ignore_for_file: no_logic_in_create_state

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../components/scaffoldTemplates/genericPageScaffold.dart';
import '../../components/tilePresenters/recipeIngredientTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../constants/AppPadding.dart';
import '../../contracts/recipeIngredient/recipeIngredient.dart';
import '../../contracts/recipeIngredient/recipeIngredientDetail.dart';
import '../../contracts/recipeIngredient/recipeIngredientTreeDetails.dart';
import '../../helpers/futureHelper.dart';
import '../../helpers/itemsHelper.dart';
import 'genericPageAllRequiredTreeComponents.dart';

class GenericAllRequiredPage extends StatefulWidget {
  final List<RecipeIngredient> requiredItems;
  const GenericAllRequiredPage(
    this.requiredItems, {
    Key? key,
  }) : super(key: key);

  @override
  _GenericAllRequiredWidget createState() =>
      _GenericAllRequiredWidget(requiredItems);
}

class _GenericAllRequiredWidget extends State<GenericAllRequiredPage> {
  final List<RecipeIngredient> requiredItems;
  int currentSelection = 0;

  _GenericAllRequiredWidget(this.requiredItems) {
    getAnalytics().trackEvent(AnalyticsEvent.genericAllRequiredPage);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> options = [
      SegmentedControlWithIconOption(
        icon: Icons.list,
        text: getTranslations().fromKey(LocaleKey.flatList),
      ),
      SegmentedControlWithIconOption(
        icon: Icons.call_split,
        text: getTranslations().fromKey(LocaleKey.tree),
      )
    ];
    Widget segmentedWidget = Container(
      child: AdaptiveSegmentedControl(
        controlItems: options,
        currentSelection: currentSelection,
        onSegmentChosen: (index) {
          setState(() {
            currentSelection = index;
          });
        },
      ),
      margin: const EdgeInsets.all(8),
    );

    if (currentSelection == 0) {
      return FutureBuilder<List<RecipeIngredientDetails>>(
          future: getAllRequiredItemsForMultiple(context, requiredItems),
          builder: (BuildContext context,
              AsyncSnapshot<List<RecipeIngredientDetails>> snapshot) {
            return genericPageScaffold<List<RecipeIngredientDetails>>(
              context,
              getTranslations().fromKey(LocaleKey.viewAllRequiredItems),
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
            getTranslations().fromKey(LocaleKey.viewAllRequiredItems),
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
    Widget segmentedWidget,
  ) {
    Widget? errorWidget = asyncSnapshotHandler(context, snapshot);
    if (errorWidget != null) return errorWidget;

    List<Widget> widgets = List.empty(growable: true);
    widgets.add(segmentedWidget);
    List<RecipeIngredientDetails> recipes = snapshot.data!;

    if (recipes.isNotEmpty) {
      for (int ingDetailIndex = 0;
          ingDetailIndex < recipes.length;
          ingDetailIndex++) {
        RecipeIngredientDetails indDetails = recipes[ingDetailIndex];
        widgets.add(recipeIngredientDetailTilePresenter(
            context, indDetails, ingDetailIndex));
      }
    } else {
      widgets.add(
        Container(
          child: Text(
            getTranslations().fromKey(LocaleKey.noItems),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 20),
          ),
          margin: const EdgeInsets.only(top: 30),
        ),
      );
    }

    widgets.add(const EmptySpace8x());

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
  Widget? errorWidget = asyncSnapshotHandler(context, snapshot);
  if (errorWidget != null) return errorWidget;

  List<Widget> widgets = List.empty(growable: true);
  widgets.add(segmentedWidget);
  List<RecipeIngredientTreeDetails> recipes = snapshot.data!;

  if (recipes.isNotEmpty) {
    widgets.add(Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
          getTree(context, recipes),
        ],
      ),
    ));
  } else {
    widgets.add(
      Container(
        child: Text(
          getTranslations().fromKey(LocaleKey.noItems),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 20),
        ),
        margin: const EdgeInsets.only(top: 30),
      ),
    );
  }

  return Column(
    children: widgets,
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.stretch,
  );
}
