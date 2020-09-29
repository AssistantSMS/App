import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../../constants/AppImage.dart';
import '../../helpers/analytics.dart';
import '../../helpers/colourHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import '../common/image.dart';

ListTile genericListTileWithSubtitleAndImageCount(context,
    {@required Widget leadingImage,
    int leadingImageCount,
    bool imageGreyScale = false,
    @required String title,
    Widget subtitle,
    int maxLines = 1,
    String onTapAnalyticsEvent,
    String onLongPressAnalyticsEvent,
    Widget trailing,
    Function onTap,
    Function onLongPress}) {
  var leadingImageWidget = (leadingImageCount != null && leadingImageCount > 0)
      // ? leadingImage
      ? Badge(
          badgeContent: Text(leadingImageCount.toString()),
          badgeColor: getSecondaryColour(context),
          position: BadgePosition.bottomEnd(),
          child: leadingImage,
          padding: EdgeInsets.all(8),
        )
      : leadingImage;
  return ListTile(
    leading: leadingImageWidget,
    title: Text(
      title,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: subtitle,
    trailing: trailing,
    // dense: true,
    onTap: onTap == null
        ? null
        : () {
            if (onTapAnalyticsEvent != null) {
              trackEvent(onTapAnalyticsEvent);
            }
            if (onTap != null) {
              onTap();
            }
          },
    onLongPress: onLongPress == null
        ? null
        : () {
            if (onLongPressAnalyticsEvent != null) {
              trackEvent(onLongPressAnalyticsEvent);
            }
            if (onLongPress != null) {
              onLongPress();
            }
          },
  );
}

ListTile genericListTileWithSubtitle(context,
    {@required String leadingImage,
    String imageBackgroundColour,
    bool imageGreyScale = false,
    @required String name,
    String description,
    Widget subtitle,
    int maxLines = 1,
    String onTapAnalyticsEvent,
    String onLongPressAnalyticsEvent,
    Widget trailing,
    Function onTap,
    Function onLongPress}) {
  String title = description != null //
      ? name + ' - ' + description
      : name;
  if (title == null || title.length == 0) title = ' ';

  return genericListTileWithSubtitleAndImageCount(
    context,
    leadingImage: genericTileImage(leadingImage, imageBackgroundColour),
    leadingImageCount: 0,
    imageGreyScale: imageGreyScale,
    title: title,
    subtitle: subtitle,
    maxLines: maxLines,
    onTapAnalyticsEvent: onTapAnalyticsEvent,
    onLongPressAnalyticsEvent: onLongPressAnalyticsEvent,
    trailing: trailing,
    onTap: onTap,
    onLongPress: onLongPress,
  );
}

ListTile genericListTile(context,
    {@required String leadingImage,
    String imageBackgroundColour,
    @required String name,
    String description,
    int quantity,
    int maxLines = 1,
    String onLongPressAnalyticsEvent,
    Widget trailing,
    Function onTap,
    Function onLongPress}) {
  Widget subtitle = (quantity != null && quantity > 0)
      ? Text(
          "${Translations.get(context, LocaleKey.quantity)}: ${quantity.toString()}")
      : null;
  return genericListTileWithSubtitle(context,
      leadingImage: leadingImage,
      imageBackgroundColour: imageBackgroundColour,
      name: name,
      description: description,
      subtitle: subtitle,
      maxLines: maxLines,
      onLongPressAnalyticsEvent: onLongPressAnalyticsEvent,
      trailing: trailing,
      onTap: onTap,
      onLongPress: onLongPress);
}

ListTile genericListTileWithNetworkImage(context,
    {@required String imageUrl,
    @required String name,
    String description,
    Widget subtitle,
    int maxLines = 1,
    String onTapAnalyticsEvent,
    String onLongPressAnalyticsEvent,
    Widget trailing,
    Function onTap,
    Function onLongPress}) {
  String title = description != null //
      ? name + ' - ' + description
      : name;
  return ListTile(
    leading: networkImage(
      imageUrl,
      boxfit: BoxFit.contain,
      height: 50.0,
      width: 50.0,
    ),
    title: Text(
      title,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: subtitle,
    trailing: trailing,
    //dense: true,
    onTap: () {
      if (onTapAnalyticsEvent != null) {
        trackEvent(onTapAnalyticsEvent);
      }
      if (onTap != null) {
        onTap();
      }
    },
    onLongPress: () {
      if (onLongPressAnalyticsEvent != null) {
        trackEvent(onLongPressAnalyticsEvent);
      }
      if (onLongPress != null) {
        onLongPress();
      }
    },
  );
}

Widget genericTileImage(String leadingImage, String imageBackgroundColour) {
  if (leadingImage == null) return null;

  Widget image = localImage('${AppImage.base}$leadingImage');
  if (imageBackgroundColour == null) {
    return image;
  }

  return Container(
    child: image,
    color: HexColor(imageBackgroundColour),
  );
}
