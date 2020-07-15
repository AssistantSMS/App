import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../constants/ExternalUrls.dart';
import '../constants/Routes.dart';
import '../contracts/results/resultWithValue.dart';
import '../localization/localeKey.dart';
import '../localization/translations.dart';
import 'colourHelper.dart';
import 'deviceHelper.dart';
import 'external.dart';
import 'genericHelper.dart';
import 'navigationHelper.dart';

Future<List<Widget>> getDrawerItems(context,
    Future<ResultWithValue<PackageInfo>> currentAppVersionFuture) async {
  List<Widget> widgets = List<Widget>();
  Color drawerIconColour = getDarkModeSecondaryColour();
  widgets.add(emptySpace1x());
  widgets.add(_drawerItem(
    context,
    image: getCorrectlySizedImageFromIcon(context, Icons.help_outline,
        colour: drawerIconColour),
    key: LocaleKey.about,
    navigateToNamed: Routes.about,
  ));
  if (!isiOS) {
    widgets.add(_drawerItem(
      context,
      image: getListTileImage(context, 'donation/buyMeACoffee.png'),
      key: LocaleKey.donation,
      navigateToNamed: Routes.donation,
    ));
  }

  widgets.add(customDivider());

  widgets.add(_drawerItem(
    context,
    image: getListTileImage(context, 'drawer/twitter.png'),
    key: LocaleKey.twitter,
    navigateToExternal: ExternalUrls.twitter,
  ));
  widgets.add(_drawerItem(
    context,
    image: getListTileImage(context, 'drawer/github.png'),
    key: LocaleKey.contribute,
    navigateToExternal: ExternalUrls.githubOrganization,
  ));

  widgets.add(customDivider());

  widgets.add(_drawerItem(
    context,
    image: getCorrectlySizedImageFromIcon(context, Icons.email),
    key: LocaleKey.feedback,
    navigateToExternal: ExternalUrls.kurtLourensEmail,
  ));

  // widgets.add(_drawerItem(
  //   context,
  //   image: getCorrectlySizedImageFromIcon(context, Icons.feedback,
  //       colour: drawerIconColour),
  //   key: LocaleKey.feedback,
  //   navigateToNamed: Routes.feedback,
  // ));
  // widgets.add(_drawerItem(
  //   context,
  //   image: getListTileImage(context, 'drawer/twitter.png'),
  //   key: LocaleKey.social,
  //   navigateToNamed: Routes.socialLinks,
  // ));

  ResultWithValue<PackageInfo> packageInfoResult =
      await currentAppVersionFuture;

  String appVersion = 'App Version ';
  Widget gameVersion = Text('Game Version: 0.4.7');
  widgets.add(customDivider());
  if (packageInfoResult.isSuccess) {
    var versionText = packageInfoResult.value != null
        ? packageInfoResult.value.version
        : Translations.get(context, LocaleKey.loading);
    widgets.add(ListTile(
      key: Key('versionNumber'),
      leading: getCorrectlySizedImageFromIcon(context, Icons.code),
      title: Text('$appVersion $versionText'),
      subtitle: gameVersion,
      dense: true,
    ));
  } else {
    widgets.add(ListTile(title: gameVersion, dense: true));
  }

  return widgets;
}

Widget _drawerItem(context,
    {@required Widget image,
    @required LocaleKey key,
    Function navigateTo,
    String navigateToNamed,
    String navigateToExternal,
    Function onTap}) {
  return ListTile(
    key: Key('$image-${key.toString()}'),
    leading: image,
    title: Text(Translations.get(context, key)),
    dense: true,
    onTap: () async {
      Navigator.pop(context);
      if (navigateTo != null) {
        await navigateHomeAsync(context, navigateTo: navigateTo);
      } else if (navigateToNamed != null) {
        await navigateHomeAsync(context, navigateToNamed: navigateToNamed);
      } else if (navigateToExternal != null) {
        launchExternalURL(navigateToExternal);
      } else if (onTap != null) {
        onTap();
      }
    },
  );
}
