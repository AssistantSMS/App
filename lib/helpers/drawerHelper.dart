import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../constants/Routes.dart';
import '../contracts/results/resultWithValue.dart';
import '../localization/localeKey.dart';
import '../localization/translations.dart';
import 'colourHelper.dart';
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
  // widgets.add(_drawerItem(
  //   context,
  //   image: getListTileImage(context, 'drawer/whatIsNew.png'),
  //   key: LocaleKey.whatIsNew,
  //   navigateToNamed: Routes.whatIsNew,
  // ));

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

  if (packageInfoResult.isSuccess) {
    widgets.add(Divider());
    widgets.add(ListTile(
      key: Key('versionNumber'),
      title: Text(
        "Version ${(packageInfoResult.value != null ? packageInfoResult.value.version : Translations.get(context, LocaleKey.loading))}",
        textAlign: TextAlign.center,
      ),
      dense: true,
    ));
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
        await navigateAwayFromHomeAsync(context, navigateTo: navigateTo);
      } else if (navigateToNamed != null) {
        await navigateAwayFromHomeAsync(context,
            navigateToNamed: navigateToNamed);
      } else if (navigateToExternal != null) {
        launchExternalURL(navigateToExternal);
      } else if (onTap != null) {
        onTap();
      }
    },
  );
}
