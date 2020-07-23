import 'package:flutter/material.dart';
import 'package:grouped_checkbox/grouped_checkbox.dart';

import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../components/responsiveSearchableList.dart';
import '../../components/tilePresenters/gameItemTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../constants/Routes.dart';
import '../../contracts/gameItem/gameItem.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/analytics.dart';
import '../../helpers/colourHelper.dart';
import '../../helpers/deviceHelper.dart';
import '../../helpers/futureHelper.dart';
import '../../helpers/navigationHelper.dart';
import '../../helpers/searchHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import '../gameItem/gameItemDetailPage.dart';

class DressBotPage extends StatefulWidget {
  @override
  _DressBotWidget createState() => _DressBotWidget();
}

class _DressBotWidget extends State<DressBotPage> {
  List<String> currentSelection;

  _DressBotWidget() {
    trackEvent(AnalyticsEvent.dressBotPage);
  }

  Future<ResultWithValue<List<GameItem>>> getCustomisationsFiltered(
    dynamic context,
    List<String> selection, {
    bool showHat = false,
    bool showHair = false,
    bool showFace = false,
    bool showTorso = false,
    bool showBackpack = false,
    bool showGloves = false,
    bool showLegs = false,
    bool showShoes = false,
  }) async {
    ResultWithValue<List<GameItem>> baseItems =
        await getAllGameItemFromLocaleKeys(
            context, [LocaleKey.customisationJson]);
    if (baseItems.hasFailed) return baseItems;
    if (selection == null) return baseItems;

    List<GameItem> filtered = List<GameItem>();
    for (var baseItem in baseItems.value) {
      if (showHat && baseItem.id.contains('custHat')) {
        filtered.add(baseItem);
        continue;
      }
      if (showHair && baseItem.id.contains('custHai')) {
        filtered.add(baseItem);
        continue;
      }
      if (showFace && baseItem.id.contains('custFac')) {
        filtered.add(baseItem);
        continue;
      }
      if (showBackpack && baseItem.id.contains('custBac')) {
        filtered.add(baseItem);
        continue;
      }
      if (showTorso && baseItem.id.contains('custTor')) {
        filtered.add(baseItem);
        continue;
      }
      if (showGloves && baseItem.id.contains('custGlo')) {
        filtered.add(baseItem);
        continue;
      }
      if (showLegs && baseItem.id.contains('custLeg')) {
        filtered.add(baseItem);
        continue;
      }
      if (showShoes && baseItem.id.contains('custSho')) {
        filtered.add(baseItem);
        continue;
      }
    }
    return ResultWithValue<List<GameItem>>(true, filtered, '');
  }

  @override
  Widget build(BuildContext context) {
    String hatKey = Translations.get(context, LocaleKey.hat);
    String hairKey = Translations.get(context, LocaleKey.hair);
    String faceKey = Translations.get(context, LocaleKey.face);
    String torsoKey = Translations.get(context, LocaleKey.torso);
    String backpackKey = Translations.get(context, LocaleKey.backpack);
    String glovesKey = Translations.get(context, LocaleKey.gloves);
    String legsKey = Translations.get(context, LocaleKey.legs);
    String shoesKey = Translations.get(context, LocaleKey.shoes);

    List<String> allItemList = [
      hatKey,
      hairKey,
      faceKey,
      torsoKey,
      backpackKey,
      glovesKey,
      legsKey,
      shoesKey
    ];
    List<String> boolSearchList = this.currentSelection ?? List<String>();
    bool showHat = boolSearchList.contains(hatKey);
    bool showHair = boolSearchList.contains(hairKey);
    bool showFace = boolSearchList.contains(faceKey);
    bool showTorso = boolSearchList.contains(torsoKey);
    bool showBackpack = boolSearchList.contains(backpackKey);
    bool showGloves = boolSearchList.contains(glovesKey);
    bool showLegs = boolSearchList.contains(legsKey);
    bool showShoes = boolSearchList.contains(shoesKey);
    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(
        context,
        title: Text(Translations.get(context, LocaleKey.dressBot)),
        showHomeAction: true,
      ),
      body: ResponsiveListDetailView<GameItem>(
        () => getCustomisationsFiltered(
          context,
          currentSelection,
          showHat: showHat,
          showHair: showHair,
          showFace: showFace,
          showTorso: showTorso,
          showBackpack: showBackpack,
          showGloves: showGloves,
          showLegs: showLegs,
          showShoes: showShoes,
        ),
        gameItemTilePresenter,
        searchGameItem,
        firstListItemWidget: Column(
          children: [
            GroupedCheckbox(
              itemList: allItemList,
              checkedItemList: this.currentSelection == null
                  ? allItemList
                  : this.currentSelection,
              onChanged: (itemList) => setState(() {
                this.currentSelection = itemList;
              }),
              wrapAlignment: WrapAlignment.center,
              orientation: CheckboxOrientation.WRAP,
              checkColor: Colors.white,
              activeColor: getSecondaryColour(context),
            ),
            customDivider(),
          ],
        ),
        listItemMobileOnTap: (BuildContext context, GameItem gameItem) async {
          return await navigateAwayFromHomeAsync(
            context,
            navigateToNamed: Routes.gameDetail,
            navigateToNamedParameters: {Routes.itemIdParam: gameItem.id},
          );
        },
        listItemDesktopOnTap: (BuildContext context, GameItem recipe,
            void Function(Widget) updateDetailView) {
          return GameItemDetailPage(
            recipe.id,
            isInDetailPane: true,
            updateDetailView: updateDetailView,
          );
        },
        key: Key(
          "${Translations.of(context).currentLanguage}${this.currentSelection}",
        ),
      ),
    );
  }
}
