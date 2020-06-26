import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/components/adaptive/listWithScrollbar.dart';

import '../../components/adaptive/gridWithScrollbar.dart';
import '../../components/scaffoldTemplates/genericPageScaffold.dart';
import '../../components/tilePresenters/raidGridTilePresenter.dart';
import '../../contracts/raid/raidFarmDetails.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';

class RaidCalculatorResultComponent extends StatelessWidget {
  final RaidFarmDetails details;

  RaidCalculatorResultComponent(this.details);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List<Widget>();

    widgets.add(Card(
      child: CircularProgressIndicator(),
    ));

    return listWithScrollbar(
        shrinkWrap: true,
        itemCount: widgets.length,
        itemBuilder: (context, index) => widgets[index]);
  }
}
