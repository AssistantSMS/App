import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/helpers/raidHelper.dart';
import 'package:scrapmechanic_kurtlourens_com/pages/raid/raidCalculatorResultComponent.dart';

import '../../components/adaptive/gridWithScrollbar.dart';
import '../../components/scaffoldTemplates/genericPageScaffold.dart';
import '../../components/tilePresenters/raidGridTilePresenter.dart';
import '../../contracts/raid/raidFarmDetails.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';

class RaidCalcPage extends StatefulWidget {
  const RaidCalcPage({Key key}) : super(key: key);

  @override
  _RaidCalcWidget createState() => _RaidCalcWidget();
}

// https://scrapmechanic.greeny.dev/
class _RaidCalcWidget extends State<RaidCalcPage> {
  Widget _inputScreen = Container(width: 0, height: 0);
  _RaidCalcWidget() {
    _inputScreen = gridWithScrollbar(
      itemCount: RaidHelper.plants.length,
      itemBuilder: (context, index) => raidGridTilePresenter(
          context, RaidHelper.plants[index], setFarmQuantity),
    );
  }

  RaidFarmDetails details = RaidFarmDetails();

  void setFarmQuantity(String itemId, int quantity) {
    RaidFarmDetails temp = RaidHelper.setFarmDetailsQuantity(
      details,
      itemId,
      quantity,
    );

    if (temp == null) return;

    this.setState(() {
      details = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    String loading = Translations.get(context, LocaleKey.loading);
    return genericPageScaffold(
      context,
      loading,
      null,
      body: getBody,
      showShortcutLinks: true,
    );
  }

  Widget getBody(BuildContext context, dynamic snapshot) {
    List<Widget> columnWidgets = List<Widget>();

    columnWidgets.add(_inputScreen);
    columnWidgets.add(Expanded(
      child: RaidCalculatorResultComponent(details),
    ));

    return Column(children: columnWidgets);
    // return listWithScrollbar(
    //     itemCount: widgets.length,
    //     itemBuilder: (context, index) => widgets[index]);
  }
}
