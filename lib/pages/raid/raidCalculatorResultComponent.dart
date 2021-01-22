import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../components/tilePresenters/raidTilePresenter.dart';
import '../../helpers/raidHelper.dart';
import '../../state/modules/raid/raidViewModel.dart';

class RaidCalculatorResultComponent extends StatelessWidget {
  final RaidViewModel details;
  final bool showMobileView;

  RaidCalculatorResultComponent(this.details, this.showMobileView);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List<Widget>();

    var cropValue = RaidHelper.getCropValue(details);
    var highCount = RaidHelper.getHighCount(details);
    var spawns = RaidHelper.getRaidSpawns(cropValue, highCount);

    if (spawns == null || spawns.length < 1) {
      widgets.add(emptySpace3x());
      widgets.add(
          genericItemName(getTranslations().fromKey(LocaleKey.yourFarmIsSafe)));
    }

    for (int spawnIndex = 0; spawnIndex < spawns.length; spawnIndex++) {
      var template = getTranslations().fromKey(LocaleKey.attackersOnNightX);
      widgets.add(genericItemGroup(
        template.replaceAll('{0}', (spawnIndex + 1).toString()),
      ));
      widgets.add(raidAttackerTilePresenter(
        context,
        spawns[spawnIndex],
        showMobileView,
      ));
      widgets.add(emptySpace2x());
    }
    widgets.add(emptySpace8x());

    return listWithScrollbar(
        shrinkWrap: true,
        itemCount: widgets.length,
        itemBuilder: (context, index) => widgets[index]);
  }
}
