import 'package:flutter/material.dart';

import '../../components/adaptive/listWithScrollbar.dart';
import '../../components/tilePresenters/raidTilePresenter.dart';
import '../../contracts/raid/raidFarmDetails.dart';
import '../../helpers/genericHelper.dart';
import '../../helpers/raidHelper.dart';

class RaidCalculatorResultComponent extends StatelessWidget {
  final RaidFarmDetails details;

  RaidCalculatorResultComponent(this.details);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List<Widget>();

    var cropValue = RaidHelper.getCropValue(details);
    var highCount = RaidHelper.getHighCount(details);
    var spawns = RaidHelper.getRaidSpawns(cropValue, highCount);

    if (spawns == null || spawns.length < 1) {
      widgets.add(emptySpace3x());
      widgets.add(genericItemName('Your farm is safe')); // TODO translation
    }

    for (int spawnIndex = 0; spawnIndex < spawns.length; spawnIndex++) {
      widgets.add(genericItemGroup(
          'Attackers on night ${(spawnIndex + 1)}')); // TODO translation
      widgets.add(raidAttackerTilePresenter(context, spawns[spawnIndex]));
      widgets.add(emptySpace2x());
    }

    return listWithScrollbar(
        shrinkWrap: true,
        itemCount: widgets.length,
        itemBuilder: (context, index) => widgets[index]);
  }
}
