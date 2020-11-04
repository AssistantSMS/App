import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../components/adaptive/listWithScrollbar.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../constants/AppColour.dart';
import '../../contracts/enum/platformType.dart';
import '../../contracts/generated/AssistantApps/versionViewModel.dart';
import '../../helpers/analytics.dart';
import '../../helpers/colourHelper.dart';
import '../../helpers/deviceHelper.dart';
import '../../helpers/genericHelper.dart';

class WhatIsNewDetailPage extends StatelessWidget {
  final VersionViewModel version;

  WhatIsNewDetailPage(this.version) {
    trackEvent(AnalyticsEvent.whatIsNewDetailPage);
  }

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(
        context,
        showHomeAction: true,
        title: Text(this.version.buildName),
      ),
      body: getBody(context),
    );
  }

  Widget getBody(BuildContext context) {
    List<Widget> columnWidgets = List<Widget>();
    columnWidgets.add(emptySpace1x());
    columnWidgets.add(genericItemText(simpleDate(this.version.activeDate)));

    List<Widget> wrapChildren = List<Widget>();
    for (var plat in this.version.platforms) {
      if (plat == PlatformType.iOS) {
        wrapChildren.add(Chip(
          label: Text('iOS', style: TextStyle(color: Colors.white)),
          backgroundColor: HexColor(AppColour.iOSChipHex),
        ));
      }
      if (!isiOS) {
        if (plat == PlatformType.Android)
          wrapChildren.add(Chip(
            label: Text('Android', style: TextStyle(color: Colors.white)),
            backgroundColor: HexColor(AppColour.androidChipHex),
          ));
        if (plat == PlatformType.Web) {
          wrapChildren.add(Chip(label: Text('Web')));
        }
      }
    }

    columnWidgets.add(Wrap(
      alignment: WrapAlignment.center,
      children: wrapChildren,
    ));

    columnWidgets.add(MarkdownBody(data: this.version.markdown));

    return listWithScrollbar(
      itemCount: columnWidgets.length,
      itemBuilder: (BuildContext context, int index) => columnWidgets[index],
    );
  }
}
