import 'package:flutter/material.dart';

import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../components/responsiveSearchableList.dart';
import '../../components/tilePresenters/gameItemTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../constants/Routes.dart';
import '../../contracts/gameItem/gameItem.dart';
import '../../contracts/misc/actionItem.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../contracts/search/checkboxOption.dart';
import '../../helpers/analytics.dart';
import '../../helpers/futureHelper.dart';
import '../../helpers/navigationHelper.dart';
import '../../helpers/searchHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import '../dialog/checkboxListPageDialog.dart';
import '../gameItem/gameItemDetailPage.dart';

class DressBotPage extends StatefulWidget {
  @override
  _DressBotWidget createState() => _DressBotWidget();
}

class _DressBotWidget extends State<DressBotPage> {
  List<CheckboxOption> currentSelection;

  _DressBotWidget() {
    trackEvent(AnalyticsEvent.dressBotPage);
  }

  Future<ResultWithValue<List<GameItem>>> getCustomisationsFiltered(
    dynamic context,
    List<CheckboxOption> selection, {
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

  CheckboxOption getOption(String text) => CheckboxOption(text, value: true);

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

    List<CheckboxOption> allItemList = List<CheckboxOption>();
    allItemList.add(getOption(hatKey));
    allItemList.add(getOption(hairKey));
    allItemList.add(getOption(faceKey));
    allItemList.add(getOption(torsoKey));
    allItemList.add(getOption(backpackKey));
    allItemList.add(getOption(glovesKey));
    allItemList.add(getOption(legsKey));
    allItemList.add(getOption(shoesKey));

    List<CheckboxOption> select =
        this.currentSelection ?? List<CheckboxOption>();
    bool showHat = select
        .firstWhere((s) => s.title == hatKey,
            orElse: () => CheckboxOption(hatKey))
        .value;
    bool showHair = select
        .firstWhere((s) => s.title == hairKey,
            orElse: () => CheckboxOption(hairKey))
        .value;
    bool showFace = select
        .firstWhere((s) => s.title == faceKey,
            orElse: () => CheckboxOption(faceKey))
        .value;
    bool showTorso = select
        .firstWhere((s) => s.title == torsoKey,
            orElse: () => CheckboxOption(torsoKey))
        .value;
    bool showBackpack = select
        .firstWhere((s) => s.title == backpackKey,
            orElse: () => CheckboxOption(backpackKey))
        .value;
    bool showGloves = select
        .firstWhere((s) => s.title == glovesKey,
            orElse: () => CheckboxOption(glovesKey))
        .value;
    bool showLegs = select
        .firstWhere((s) => s.title == legsKey,
            orElse: () => CheckboxOption(legsKey))
        .value;
    bool showShoes = select
        .firstWhere((s) => s.title == shoesKey,
            orElse: () => CheckboxOption(shoesKey))
        .value;

    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(context,
          title: Text(Translations.get(context, LocaleKey.dressBot)),
          showHomeAction: true,
          actions: [
            ActionItem(
              icon: Icons.sort,
              onPressed: () async {
                List<CheckboxOption> newSelection = await navigateAsync(
                  context,
                  navigateTo: (context) => CheckboxListPageDialog(
                    Translations.get(context, LocaleKey.dressBot),
                    this.currentSelection ?? allItemList,
                  ),
                );
                if (newSelection == null ||
                    newSelection.length != allItemList.length) return;
                this.setState(() {
                  this.currentSelection = newSelection;
                });
              },
            )
          ]),
      body: ResponsiveListDetailView<GameItem>(
        () => getCustomisationsFiltered(
          context,
          this.currentSelection,
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
          "${Translations.of(context).currentLanguage}${_getKeyFromSelection(this.currentSelection)}",
        ),
      ),
    );
  }

  String _getKeyFromSelection(List<CheckboxOption> list) {
    String temp = '';
    for (var item in list ?? List<CheckboxOption>()) {
      temp += item.title + (item.value ? '1' : '0');
    }
    print(temp);
    return temp;
  }
}
