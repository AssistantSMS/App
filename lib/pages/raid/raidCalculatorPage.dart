import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

import '../../components/adaptive/listWithScrollbar.dart';
import '../../components/scaffoldTemplates/genericPageScaffold.dart';
import '../../contracts/raid/raidFarmDetails.dart';
import '../../helpers/columnHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import 'raidCalculatorPage.desktop.dart';
import 'raidCalculatorPage.mobile.dart';
import 'raidCalculatorResultComponent.dart';

const greenyDevGithubImage =
    'https://avatars0.githubusercontent.com/u/3734204?s=460&u=7eb6ec6aa9200855109647c7fcdd159069b673fe&v=4';
const greenyDevGithubLink = 'https://github.com/greeny/?ref=AssistantSMS';
const greenyDevTool = 'https://scrapmechanic.greeny.dev/?ref=AssistantSMS';

class RaidCalcPage extends StatefulWidget {
  const RaidCalcPage({Key key}) : super(key: key);

  @override
  _RaidCalcWidget createState() => _RaidCalcWidget();
}

// https://scrapmechanic.greeny.dev/
class _RaidCalcWidget extends State<RaidCalcPage> {
  Widget _desktopInputScreen = Container(width: 0, height: 0);
  RaidFarmDetails details = RaidFarmDetails();

  _RaidCalcWidget() {
    _desktopInputScreen = RaidCalcDesktopInputScreen(setFarmQuantity, details);
  }

  void setFarmQuantity(RaidFarmDetails temp) {
    if (temp == null) return;

    this.setState(() {
      details = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return genericPageScaffold(
      context,
      Translations.get(context, LocaleKey.raidCalculator),
      null,
      body: (BuildContext innerContext, _) => BreakpointBuilder(
        builder: (BuildContext innerContext, Breakpoint breakpoint) {
          var showMobileView = isMobileScreenWidth(breakpoint);
          return getBody(innerContext, showMobileView);
        },
      ),
      showShortcutLinks: true,
    );
  }

  Widget getBody(BuildContext context, bool showMobileView) {
    List<Widget> columnWidgets = List<Widget>();

    if (showMobileView) {
      columnWidgets.add(RaidCalcMobileInputScreen(setFarmQuantity, details));
      columnWidgets.add(Divider());
    } else {
      columnWidgets.add(_desktopInputScreen);
    }
    columnWidgets.add(RaidCalculatorResultComponent(details, showMobileView));

    return listWithScrollbar(
        itemCount: columnWidgets.length,
        itemBuilder: (context, index) => columnWidgets[index]);
  }
}
