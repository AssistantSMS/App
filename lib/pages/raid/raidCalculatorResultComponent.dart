import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../components/tilePresenters/raidTilePresenter.dart';
import '../../helpers/raidHelper.dart';
import '../../state/modules/raid/raidViewModel.dart';

class RaidCalculatorResultComponent extends StatelessWidget {
  final RaidViewModel details;
  final bool showMobileView;

  const RaidCalculatorResultComponent(
    this.details,
    this.showMobileView, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List.empty(growable: true);

    var cropValue = RaidHelper.getCropValue(details);
    var highCount = RaidHelper.getHighCount(details);
    var spawns = RaidHelper.getRaidSpawns(cropValue, highCount);

    if (spawns.isEmpty) {
      widgets.add(const EmptySpace3x());
      widgets.add(
          GenericItemName(getTranslations().fromKey(LocaleKey.yourFarmIsSafe)));
    }

    for (int spawnIndex = 0; spawnIndex < spawns.length; spawnIndex++) {
      var template = getTranslations().fromKey(LocaleKey.attackersOnNightX);
      widgets.add(GenericItemGroup(
        template.replaceAll('{0}', (spawnIndex + 1).toString()),
      ));
      widgets.add(raidAttackerTilePresenter(
        context,
        spawns[spawnIndex],
        showMobileView,
      ));
      widgets.add(const EmptySpace2x());
    }
    widgets.add(const EmptySpace8x());

    if (showMobileView) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widgets,
      );
    }

    return listWithScrollbar(
      shrinkWrap: true,
      itemCount: widgets.length,
      itemBuilder: (context, index) => widgets[index],
    );
  }
}
