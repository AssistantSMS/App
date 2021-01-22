import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../constants/AnalyticsEvent.dart';
import '../../contracts/gameItem/gameItem.dart';
import '../../contracts/search/checkboxOption.dart';
import '../../helpers/analytics.dart';
import '../../helpers/futureHelper.dart';
import '../../state/modules/base/appState.dart';
import '../../state/modules/cosmetic/cosmeticViewModel.dart';
import 'dressbotListDetailPage.dart';

class DressBotPage extends StatefulWidget {
  @override
  _DressBotWidget createState() => _DressBotWidget();
}

class _DressBotWidget extends State<DressBotPage> {
  List<CheckboxOption> currentSelection;
  List<String> currentOwnedSelection;

  _DressBotWidget() {
    trackEvent(AnalyticsEvent.dressBotPage);
  }

  Future<ResultWithValue<List<GameItem>>> getCustomisationsFiltered(
    dynamic context,
    List<CheckboxOption> selection,
    List<String> owned, {
    bool showHat = false,
    bool showHair = false,
    bool showFace = false,
    bool showTorso = false,
    bool showBackpack = false,
    bool showGloves = false,
    bool showLegs = false,
    bool showShoes = false,
    bool showOwned = true,
    bool showNotOwned = true,
  }) async {
    ResultWithValue<List<GameItem>> baseItems =
        await getAllGameItemFromLocaleKeys(
            context, [LocaleKey.customisationJson]);
    if (baseItems.hasFailed) return baseItems;

    if (selection == null) {
      List<GameItem> filtered = List<GameItem>();
      for (var baseItem in baseItems.value) {
        var isOwned = owned.any((o) => o == baseItem.id);
        if (isOwned && showOwned == false) {
          continue;
        }
        if (!isOwned && showNotOwned == false) {
          continue;
        }
        filtered.add(baseItem);
      }
      return ResultWithValue<List<GameItem>>(true, filtered, '');
    }

    List<GameItem> filtered = List<GameItem>();
    for (var baseItem in baseItems.value) {
      var isOwned = owned.any((o) => o == baseItem.id);
      if (isOwned && showOwned == false) {
        continue;
      }
      if (!isOwned && showNotOwned == false) {
        continue;
      }

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

  void setSelection(List<CheckboxOption> newSelection) {
    this.setState(() {
      this.currentSelection = newSelection;
    });
  }

  void setOwnedSelection(List<String> newSelection) {
    this.setState(() {
      this.currentOwnedSelection = newSelection;
    });
  }

  @override
  Widget build(BuildContext context) {
    String hatKey = getTranslations().fromKey(LocaleKey.hat);
    String hairKey = getTranslations().fromKey(LocaleKey.hair);
    String faceKey = getTranslations().fromKey(LocaleKey.face);
    String torsoKey = getTranslations().fromKey(LocaleKey.torso);
    String backpackKey = getTranslations().fromKey(LocaleKey.backpack);
    String glovesKey = getTranslations().fromKey(LocaleKey.gloves);
    String legsKey = getTranslations().fromKey(LocaleKey.legs);
    String shoesKey = getTranslations().fromKey(LocaleKey.shoes);
    String showOwnedKey = getTranslations().fromKey(LocaleKey.showOwned);
    String showNotOwnedKey = getTranslations().fromKey(LocaleKey.showNotOwned);

    List<CheckboxOption> allItemList = List<CheckboxOption>();
    allItemList.add(getOption(hatKey));
    allItemList.add(getOption(hairKey));
    allItemList.add(getOption(faceKey));
    allItemList.add(getOption(torsoKey));
    allItemList.add(getOption(backpackKey));
    allItemList.add(getOption(glovesKey));
    allItemList.add(getOption(legsKey));
    allItemList.add(getOption(shoesKey));

    List<String> ownedOptionList = List<String>();
    ownedOptionList.add(showOwnedKey);
    ownedOptionList.add(showNotOwnedKey);

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

    List<String> selectOwned =
        this.currentOwnedSelection ?? [showOwnedKey, showNotOwnedKey];
    bool showOwned = selectOwned.contains(showOwnedKey);
    bool showNotOwned = selectOwned.contains(showNotOwnedKey);

    return StoreConnector<AppState, CosmeticViewModel>(
      converter: (store) => CosmeticViewModel.fromStore(store),
      builder: (_, viewModel) => DressBotListDetailPage(
        allItemList,
        currentSelection,
        getCustomisationsFiltered,
        setSelection,
        ownedOptionList,
        currentOwnedSelection,
        setOwnedSelection,
        showHat,
        showHair,
        showFace,
        showTorso,
        showBackpack,
        showGloves,
        showLegs,
        showShoes,
        showOwned,
        showNotOwned,
      ),
    );
  }
}
