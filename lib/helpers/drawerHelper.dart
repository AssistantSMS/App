import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../constants/AppImage.dart';
import '../constants/SMSExternalUrls.dart';
import '../constants/Routes.dart';

Future<List<Widget>> getDrawerItems(context,
    Future<ResultWithValue<PackageInfo>> currentAppVersionFuture) async {
  List<Widget> widgets = List.empty(growable: true);
  Color drawerIconColour = getTheme().getDarkModeSecondaryColour();
  widgets.add(emptySpace1x());
  widgets.add(_drawerItem(
    context,
    image: getCorrectlySizedImageFromIcon(context, Icons.campaign,
        colour: drawerIconColour),
    key: LocaleKey.whatIsNew,
    navigateToNamed: Routes.whatIsNew,
  ));
  widgets.add(_drawerItem(
    context,
    image: getCorrectlySizedImageFromIcon(context, Icons.people,
        colour: drawerIconColour),
    key: LocaleKey.contributors,
    navigateToNamed: Routes.contributors,
  ));
  widgets.add(_drawerItem(
    context,
    image: getListTileImage(AppImage.patreon),
    key: LocaleKey.patrons,
    navigateToNamed: Routes.patronList,
  ));
  if (!isiOS) {
    widgets.add(_drawerItem(
      context,
      image: getListTileImage(AppImage.buyMeACoffee),
      key: LocaleKey.donation,
      navigateToNamed: Routes.donation,
    ));
  }

  widgets.add(customDivider());

  widgets.add(_drawerItem(
    context,
    image: getListTileImage(AppImage.twitter),
    key: LocaleKey.twitter,
    navigateToExternal: SMSExternalUrls.twitter,
  ));
  widgets.add(_drawerItem(
    context,
    image: getListTileImage(AppImage.github),
    key: LocaleKey.contribute,
    navigateToExternal: SMSExternalUrls.githubOrganization,
  ));

  widgets.add(customDivider());

  widgets.add(_drawerItem(
    context,
    image: getCorrectlySizedImageFromIcon(context, Icons.help_outline,
        colour: drawerIconColour),
    key: LocaleKey.about,
    navigateToNamed: Routes.about,
  ));

  widgets.add(_drawerItem(
    context,
    image: getCorrectlySizedImageFromIcon(context, Icons.email),
    key: LocaleKey.feedback,
    navigateToExternal: SMSExternalUrls.kurtLourensEmail,
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
  //   image: getListTileImage('drawer/twitter.png'),
  //   key: LocaleKey.social,
  //   navigateToNamed: Routes.socialLinks,
  // ));

  ResultWithValue<PackageInfo> packageInfoResult =
      await currentAppVersionFuture;

  String appVersion = 'App Version ';
  Widget gameVersion = Text('Game Version: 0.4.8');
  widgets.add(customDivider());
  if (packageInfoResult.isSuccess) {
    var versionText = packageInfoResult.value != null
        ? packageInfoResult.value.version
        : getTranslations().fromKey(LocaleKey.loading);
    widgets.add(ListTile(
      key: Key('versionNumber'),
      leading: getCorrectlySizedImageFromIcon(context, Icons.code),
      title: Text('$appVersion $versionText'),
      subtitle: gameVersion,
      dense: true,
    ));
  } else {
    widgets.add(ListTile(
      key: Key('versionNumber'),
      leading: getCorrectlySizedImageFromIcon(context, Icons.code),
      title: gameVersion,
      dense: true,
    ));
  }

  widgets.add(_drawerItem(
    context,
    image: getListTileImage(AppImage.assistantApps),
    key: LocaleKey.assistantApps,
    onTap: () {
      adaptiveBottomModalSheet(
        context,
        hasRoundedCorners: true,
        builder: (BuildContext innerC) => AssistantAppsModalBottomSheet(),
      );
    },
  ));
  widgets.add(emptySpace3x());

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
    title: Text(getTranslations().fromKey(key)),
    dense: true,
    onTap: () async {
      Navigator.pop(context);
      if (navigateTo != null) {
        await getNavigation().navigateHomeAsync(
          context,
          navigateTo: navigateTo,
        );
      } else if (navigateToNamed != null) {
        await getNavigation().navigateHomeAsync(
          context,
          navigateToNamed: navigateToNamed,
        );
      } else if (navigateToExternal != null) {
        launchExternalURL(navigateToExternal);
      } else if (onTap != null) {
        onTap();
      }
    },
  );
}
