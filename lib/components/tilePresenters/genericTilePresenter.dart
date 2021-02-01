import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

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
          badgeColor: getTheme().getSecondaryColour(context),
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
              getAnalytics().trackEvent(onTapAnalyticsEvent);
            }
            if (onTap != null) {
              onTap();
            }
          },
    onLongPress: onLongPress == null
        ? null
        : () {
            if (onLongPressAnalyticsEvent != null) {
              getAnalytics().trackEvent(onLongPressAnalyticsEvent);
            }
            if (onLongPress != null) {
              onLongPress();
            }
          },
  );
}
