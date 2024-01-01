import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../constants/AppImage.dart';
import '../constants/SMSExternalUrls.dart';
import '../constants/Routes.dart';

List<Widget> getDrawerItems(context) {
  List<Widget> widgets = List.empty(growable: true);
  Color drawerIconColour = getTheme().getDarkModeSecondaryColour();
  widgets.add(const EmptySpace1x());
  widgets.add(_drawerItem(
    context,
    image: CorrectlySizedImageFromIcon(
      icon: Icons.campaign,
      colour: drawerIconColour,
    ),
    key: LocaleKey.whatIsNew,
    navigateToNamed: Routes.whatIsNew,
  ));
  widgets.add(_drawerItem(
    context,
    image: CorrectlySizedImageFromIcon(
      icon: Icons.people,
      colour: drawerIconColour,
    ),
    key: LocaleKey.contributors,
    navigateToNamed: Routes.contributors,
  ));
  widgets.add(_drawerItem(
    context,
    image: const ListTileImage(partialPath: AppImage.patreon),
    key: LocaleKey.patrons,
    navigateToNamed: Routes.patronList,
  ));
  if (!isiOS) {
    widgets.add(_drawerItem(
      context,
      image: const ListTileImage(partialPath: AppImage.buyMeACoffee),
      key: LocaleKey.donation,
      navigateToNamed: Routes.donation,
    ));
  }

  widgets.add(customDivider());

  widgets.add(_drawerItem(
    context,
    image: const ListTileImage(partialPath: AppImage.twitter),
    key: LocaleKey.twitter,
    navigateToExternal: SMSExternalUrls.twitter,
  ));
  widgets.add(_drawerItem(
    context,
    image: const ListTileImage(partialPath: AppImage.github),
    key: LocaleKey.contribute,
    navigateToExternal: SMSExternalUrls.githubOrganization,
  ));

  widgets.add(customDivider());

  widgets.add(_drawerItem(
    context,
    image: CorrectlySizedImageFromIcon(
      icon: Icons.help_outline,
      colour: drawerIconColour,
    ),
    key: LocaleKey.about,
    navigateToNamed: Routes.about,
  ));

  widgets.add(_drawerItem(
    context,
    image: const CorrectlySizedImageFromIcon(icon: Icons.email),
    key: LocaleKey.feedback,
    onTap: (tapCtx) {
      FeedbackWrapper.of(tapCtx).show();
    },
  ));

  widgets.add(customDivider());
  widgets.add(packageVersionTile('0.6.5'));

  widgets.add(_drawerItem(
    context,
    image: const ListTileImage(partialPath: AppImage.assistantApps),
    key: LocaleKey.assistantApps,
    onTap: (_) {
      adaptiveBottomModalSheet(
        context,
        hasRoundedCorners: true,
        builder: (BuildContext innerC) => const AssistantAppsModalBottomSheet(
          appType: AssistantAppType.sms,
        ),
      );
    },
  ));
  widgets.add(const EmptySpace3x());

  return widgets;
}

Widget _drawerItem(
  BuildContext context, {
  required Widget image,
  required LocaleKey key,
  Widget Function(BuildContext)? navigateTo,
  String? navigateToNamed,
  String? navigateToExternal,
  void Function(BuildContext)? onTap,
}) {
  return ListTile(
    key: Key('$image-${key.toString()}'),
    leading: image,
    title: Text(getTranslations().fromKey(key)),
    dense: true,
    onTap: () async {
      // Navigator.pop(context);
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
        onTap(context);
      }
    },
  );
}
