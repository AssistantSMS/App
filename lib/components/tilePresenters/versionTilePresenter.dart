import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../contracts/generated/AssistantApps/versionViewModel.dart';
import '../../helpers/colourHelper.dart';
import '../../helpers/genericHelper.dart';
import '../../helpers/navigationHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import '../../pages/whatIsNew/whatIsNewDetailPage.dart';
import '../common/newBanner.dart';
import 'genericTilePresenter.dart';

Widget Function(BuildContext context, VersionViewModel version)
    versionTilePresenter(BuildContext context, String versionGuid) {
  return (BuildContext context, VersionViewModel version) {
    bool isCurrentVersion =
        version.guid.toLowerCase() == versionGuid.toLowerCase();
    String handleFutureDate(DateTime dateTime) {
      if (isCurrentVersion) return simpleDate(DateTime.now());
      return dateTime.isAfter(DateTime.now())
          ? Translations.get(context, LocaleKey.pendingAppStoreRelease)
          : simpleDate(dateTime);
    }

    var child = TimelineTile(
      alignment: TimelineAlign.left,
      rightChild: genericListTileWithSubtitle(
        context,
        leadingImage: null,
        name: Translations.get(context, LocaleKey.release)
            .replaceAll('{0}', version.buildName),
        subtitle: genericEllipsesText(handleFutureDate(version.activeDate)),
        trailing: Icon(Icons.chevron_right),
        onTap: () async => await navigateAsync(context,
            navigateTo: (context) => WhatIsNewDetailPage(version)),
      ),
      indicatorStyle: IndicatorStyle(
        width: 25,
        color: getSecondaryColour(context),
      ),
      topLineStyle: LineStyle(color: getSecondaryColour(context)),
    );
    if (version.guid.toLowerCase() == versionGuid.toLowerCase()) {
      return wrapInNewBanner(context, LocaleKey.current, child);
    }
    return child;
  };
}
